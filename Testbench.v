`timescale 1ns / 1ps

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2026 10:09:50
// Design Name: 
// Module Name: tb_comp2b
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


module tb_magComp4b();
    reg [3:0]a_i;
    reg [3:0]b_i; 
    wire A_o; 
    wire B_o; 
    wire AB_o;

//instantiation
magComp4b DUT(.a_i(a_i), 
    .b_i(b_i), 
    .A_o(A_o), 
    .B_o(B_o), 
    .AB_o(AB_o));

//feeding
initial begin
a_i = 4'b0000; b_i = 4'b0000; //all 0s
#5 a_i = 4'b0000; b_i = 4'b1000; //A 0, B something
#5 a_i = 4'b0100; b_i = 4'b0000; //B 0, A something
#5 a_i = 4'b0010; b_i = 4'b0010; //equal
#5 a_i = 4'b1000; b_i = 4'b0110; //A>B
#5 a_i = 4'b0011; b_i = 4'b0100; //B>A
#5 a_i = 4'bxxxx; b_i = 4'b1101; //A all bits X, B something
#5 a_i = 4'b00x0; b_i = 4'b0010; //A has some bit X, B something
#5 a_i = 4'b00x0; b_i = 4'bxx00; //both has some bits X, but different bits
#5 a_i = 4'b0x00; b_i = 4'b0x00; //both has same bit X
#5 a_i = 4'b1111; b_i = 4'b1111;
#5 $finish;
end

initial begin
$monitor("Time: %t | A: %d, B: %d | A>B: %b, A=B: %b, A<B: %b", $time, a_i, b_i, A_o, AB_o, B_o);
//some simulator may not show X values by %d format specifiers, %b can be used. 
//I'm using %d, readability, my simulator shows 'X' if any bit is X and 'x' if all bits are X.
$dumpfile("magComp4b.vcd");
$dumpvars(0, tb_magComp4b);
end

endmodule
