#! /c/iverilog/bin/vvp
:ivl_version "0.9.7 " "(v0_9_7)";
:vpi_time_precision + 0;
:vpi_module "system";
:vpi_module "v2005_math";
:vpi_module "va_math";
S_00AD6F50 .scope module, "and_gate_data" "and_gate_data" 2 1;
 .timescale 0 0;
L_00AD7EB0 .functor AND 1, C4<z>, C4<z>, C4<1>, C4<1>;
v00AD6FD8_0 .net "A", 0 0, C4<z>; 0 drivers
v00AD7E00_0 .net "B", 0 0, C4<z>; 0 drivers
v00AD7E58_0 .net "Y", 0 0, L_00AD7EB0; 1 drivers
# The file index is used to find the file name in the following table.
:file_names 3;
    "N/A";
    "<interactive>";
    "andflow.v";
