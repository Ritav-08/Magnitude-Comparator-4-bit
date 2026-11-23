//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2026 06:12:23 PM
// Design Name: 
// Module Name: cp_if
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


// ============================================================
// cp_if.sv
// Interface for 4-bit Magnitude Comparator
// ============================================================


interface cp_if;

   logic [3:0] in1 = 4'h0;
   logic [3:0] in2 = 4'h0; 
   logic [2:0] out;

   modport MON (input in1, in2, input out);
   modport DRV (output in1, output in2, input out);
   
endinterface : cp_if
