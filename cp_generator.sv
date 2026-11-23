`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2026 09:46:14 AM
// Design Name: 
// Module Name: cp_generator
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



`ifndef CP_GENERATOR_SV
`define CP_GENERATOR_SV

typedef int unsigned uint;

// ============================================================
// cp_generator.sv
// Generates input transactions
// ============================================================

class generator;
   
//-------------------------------------------------------
//Mailbox
//-------------------------------------------------------
   mailbox #(transaction) gen2drv_mbx; //transaction class object exchange
   mailbox #(bit)             ack_mbx; //acknowledgement of input driven
   
//-------------------------------------------------------
//Constructor
//-------------------------------------------------------
   function new(
      mailbox #(transaction) gen2drv_mbx,
      mailbox #(bit)             ack_mbx
   );
      this.gen2drv_mbx = gen2drv_mbx;
      this.ack_mbx     =     ack_mbx;
   endfunction
   
//-------------------------------------------------------
//Tasks
//-------------------------------------------------------
   //Task for sending transaction
   local task send_txn(
      input logic [3:0] in1, 
      input logic [3:0] in2
   );
      transaction txn = new(); 
      txn.in1 = in1;
      txn.in2 = in2;
      txn.print("[GEN]");
      gen2drv_mbx.put(txn);
   endtask
   
   //Task to wait for n cycles to get acknowledgement
   local task ack_txn(
      input uint n
   );
      bit token;
      repeat(n) begin
         ack_mbx.get(token); //it'll block till ack for all sent txns get received
      end
   endtask
   
   //Task to randomize and call other tasks at right time
   local task run(
      input logic [3:0]   in1 [],     //manual array of inputs, to sent each element per transaction
      input logic [3:0]   in2 [],     
      input  uint         n_txns,     //number of transactions to sent
      input  uint randomize_txns = 0  //number of randomizations to perform
   );
      $display("[GEN] Sending %d transactions", n_txns);
      if(randomize_txns) begin  //we have to sent random values
         for(int i = 0; i < n_txns; i++) begin  //for n_txns times, randomize and pass variables
            transaction txn = new();
            if(!txn.randomize()) begin
               $fatal(1, "[GEN-RUN] Randomization failed for txn %d...", i);
            end
            send_txn(txn.in1, txn.in2);
         end
      end
      else begin  //we have to sent manual values from array inputs
         for(int i = 0; i < n_txns; i++) begin
            send_txn(in1[i], in2[i]);
         end
      end
      
      ack_txn(n_txns);  //wait for all acknowledgements
      $display("[GEN] All transactions Done");
      
   endtask
   
endclass : generator

`endif //CP_GENERATOR_SV
