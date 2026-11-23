`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2026 06:33:44 PM
// Design Name: 
// Module Name: cp_transaction
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


`ifndef CP_TRANSACTION_SV 
`define CP_TRANSACTION_SV

// ============================================================
// cp_transaction.sv
// Transaction for 4-bit Magnitude Comparator
// ============================================================

class transaction;
   
   rand logic [3:0] in1;
   rand logic [3:0] in2;
        logic [2:0] out;
   
   //-------------------------------------------------------
   //constraints
   //-------------------------------------------------------
   constraint inputs {
      //4'b0000 <= in1 <= 4'b1111
      in1 >= 4'h0;
      in1 <= 4'hF;
      //4'b0000 <= in2 <= 4'b1111
      in2 inside {[4'h0 : 4'hF]};
   }
   
   //-------------------------------------------------------
   //constructor
   //-------------------------------------------------------
   function new();
      in1 = 4'h0;
      in2 = 4'h0;
      out = 3'b000;
   endfunction
   
   //-------------------------------------------------------
   //deep copy
   //-------------------------------------------------------
   function transaction copy();
      copy = new();
      copy.in1 = this.in1;
      copy.in2 = this.in2;
      copy.out = this.out;
   endfunction
   
   //-------------------------------------------------------
   //display helper
   //-------------------------------------------------------
   function void print(string tag = " ");
      $display("[TR] @%0t %s | In1: %d, In2: %0d, Out: %0b", 
         $time, tag, 
            in1, in2, out);
   endfunction
   
endclass

`endif //CP_TRANSACTION_SV
