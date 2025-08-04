module uart_RX(input rx,input clk,input rst,output [7:0] dout,output reg rx_done);
 parameter [1:0] idle=2'b00,
                 start=2'b01,
                 data=2'b10,
                 stop=2'b11;
 parameter clockspeed=50000000;
 parameter baudrate=9600;
 reg [3:0] s;
 reg s_tick;
 reg [8:0] baud_counter;
 parameter baud_count=clock_speed/(Baud_rate*16);
 reg [7:0] temp;
 reg [1:0] state;
 reg [2:0] n;
 always @(posedge clk or posedge rst) begin
  if(rst) begin
    baud_counter<=0;
    s_tick<=0;
  end
  else begin
    if(baud_counter==baud_count) begin
      s_tick<=1;
      baud_counter<=0;
    end
    else begin
      s_tick<=0;
      baud_counter<=baud_counter+1;
   end
  end
 end
 always @(posedge clk or posedge reset) begin
   if(reset) begin
     s<=4'b0;
     state<=idle;
     temp<=8'b0;
     dout<=8'b0;
     rx_done<=0;
   end 
   else begin
      idle: begin
       if(rx) begin
        s<=4'b0;
        state<=start;
       end
       else begin
        state<=idle;
       end
      end
      start: begin
       if(s_tick) begin
         if(s==7) begin
            s<=0;
            n<=0;
            state<=data;
         end
         else begin
            s<=s+1;
            state<=start;
         end
       else begin
         state<=start;
       end
      end
      data: begin
       if(s_tick) begin
        if(s==15) begin
          s<=0;
          temp<={rx,temp[7:1]};
          if(n==3'b111) begin
            state<=stop;
          end
          else begin
            n<=n+1;
            state<=data;
          end
        else begin
           s<=s+1;
           state<=data;
        end
       else begin
          state<=data;
       end
      end
      stop: begin
        if(s_tick) begin
         if(s==15) begin
          if(rx) begin
           rx_done<=1;
           state<=idle;
          end
          else begin
           state<=idle;
          end
         else begin
           s<=s+1;
           state<=stop;
         end
       else begin
         state<=stop;
       end
      end
   end
endmodule
module lcd(
    input clk,
    input rst,
    input rx_done,              // UART data received flag
    input [7:0] data_in,        // UART data (ASCII character)
    output reg lcd_rs,
    output reg lcd_e,
    output reg [7:0] data
);

    // State encoding
    parameter INIT = 2'b00, IDLE = 2'b01, WRITE = 2'b10;
    reg [1:0] state;

    reg [7:0] data_rom[0:20];   // store init + runtime characters
    reg [4:0] data_pos;         // data_rom index
    reg [16:0] en_timing;

    reg [3:0] char_count;       // count chars printed in line (max 16)

    always @(posedge clk) begin
        if (rst) begin
            // LCD Init Commands
            data_rom[0] <= 8'h38;
            data_rom[1] <= 8'h0C;
            data_rom[2] <= 8'h06;
            data_rom[3] <= 8'h01;
            data_rom[4] <= 8'h80;

            data_pos <= 0;
            en_timing <= 0;
            lcd_e <= 0;
            lcd_rs <= 0;
            data <= 8'h00;
            state <= INIT;
            char_count <= 0;
        end else begin
            en_timing <= en_timing + 1;

            case (state)
                INIT: begin
                    if (en_timing == 17'd0) begin
                        lcd_e <= 1;
                        lcd_rs <= 0;
                        data <= data_rom[data_pos];
                    end else if (en_timing == 17'd50000) begin
                        lcd_e <= 0;
                    end else if (en_timing == 17'd100000) begin
                        en_timing <= 0;
                        data_pos <= data_pos + 1;
                        if (data_pos == 4) begin
                            state <= IDLE;
                            data_pos <= 5;
                        end
                    end
                end

                IDLE: begin
                    if (rx_done) begin
                        // If 16 chars reached, reset cursor
                        if (char_count == 15) begin
                            data_rom[5] <= 8'h80;           // cursor home
                            data_rom[6] <= data_in;         // new char
                            data_pos <= 5;
                            char_count <= 0;
                        end else begin
                            data_rom[5] <= data_in;
                            data_pos <= 5;
                            char_count <= char_count + 1;
                        end
                        state <= WRITE;
                        en_timing <= 0;
                    end
                end

                WRITE: begin
                    if (en_timing == 17'd0) begin
                        lcd_e <= 1;
                        lcd_rs <= (char_count == 0) ? 0 : 1; // 0 if reset, 1 if data
                        data <= data_rom[data_pos];
                    end else if (en_timing == 17'd50000) begin
                        lcd_e <= 0;
                    end else if (en_timing == 17'd100000) begin
                        en_timing <= 0;
                        state <= IDLE;
                    end
                end
            endcase
        end
    end

endmodule

module top_uart_lcd_display (
    input clk,
    input rst,
    input rx,                      // UART RX pin from external source
    output wire lcd_rs,           // LCD register select
    output wire lcd_e,            // LCD enable
    output wire [7:0] data        // LCD data bus
);

    wire [7:0] dout;
    wire rx_done;

    // UART Receiver instance
    uart_RX uart_inst (
        .rx(rx),
        .clk(clk),
        .rst(rst),
        .dout(dout),
        .rx_done(rx_done)
    );

    // LCD instance that displays received character
    lcd lcd_inst (
        .clk(clk),
        .rst(rst),
        .rx_done(rx_done),
        .data_in(dout),
        .lcd_rs(lcd_rs),
        .lcd_e(lcd_e),
        .data(data)
    );

endmodule


   
       
      
   
    
 