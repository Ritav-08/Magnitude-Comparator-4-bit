`timescale 1ns / 1ps
//======================================================
//   File Name:
//      Design.v
//   Modules: 
//      mag_comp_4b
//      magComp4b
//   Extra Comments: 
//      out[2] - >
//      out[1] - =
//      out[0] - <
//======================================================
module mag_comp_4b(
   input [3:0] in1, 
   input [3:0] in2, 
   output reg [2:0] out  
);

   always @(*) begin
      if(^in1 === 1'bx || ^in2 === 1'bx) begin 
         out = 3'bx;   // X handling
      end else if(in1 > in2) begin 
         out = 3'b001; // A > B
      end else if(in1 < in2) begin 
         out = 3'b100; // B > A
      end else begin 
         out = 3'b010; // A = B
      end
   end
endmodule

/* ----- OLD DESIGN -----
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
*/
