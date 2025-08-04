module double_task;
    reg [7:0] a;
    reg [7:0] b;
    reg [7:0] out;

    // First task to add two numbers
    task automatic tasker;
        input [7:0] A;
        input [7:0] B;
        output [7:0] sum;
        begin
            sum = A + B;
        end
    endtask

    // Second task that calls the first one twice
    task automatic taskeradd;
        input [7:0] x;
        input [7:0] y;
        output [7:0] Sum;

        reg [7:0] temp1;
        reg [7:0] temp2;

        begin
            tasker(x, y, temp1);
            tasker(x, y, temp2);
            Sum = temp1 + temp2;
        end
    endtask

    // Initial block to drive the simulation
    initial begin
        a = 8'd10; #10;
        b = 8'd20; #10;
        taskeradd(a, b, out);
        $display("Double add result is: %0d", out);
    end

endmodule

        
  
  