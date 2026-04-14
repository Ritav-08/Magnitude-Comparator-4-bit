`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2026 10:50:41
// Design Name: 
// Module Name: mag_comp4b
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


module magComp4b(
    input [3:0]a_i, 
    input [3:0]b_i, 
    output reg A_o, 
    output reg B_o, 
    output reg AB_o
);

always@(*)
if(^a_i === 1'bx || ^b_i === 1'bx) begin //X handling
   A_o = 1'bx; 
   B_o = 1'bx;
   AB_o = 1'bx;
end
else if(a_i > b_i) begin //A>B
   A_o = 1'b1; 
   B_o = 1'b0;
   AB_o = 1'b0;
end
else if(b_i > a_i) begin //B>A
   A_o = 1'b0; 
   B_o = 1'b1;
   AB_o = 1'b0;
end
else begin //A=B
   A_o = 1'b0; 
   B_o = 1'b0;
   AB_o = 1'b1;
end

endmodule