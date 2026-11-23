`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2026 10:45:07 AM
// Design Name: 
// Module Name: cp_driver
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


//============================================================
//cp_driver.sv
//Drives transactions onto the DUT via the interface
//============================================================

`ifndef CP_DRIVER_SV
`define CP_DRIVER_SV

class driver;
   
//-------------------------------------------------------
//Virtual interface handle (driver modport)
//-------------------------------------------------------
   virtual cp_if.DRV vif;
   
//-------------------------------------------------------
//Mailbox
//-------------------------------------------------------
   mailbox #(transaction) gen2drv_mbx;
   mailbox #(bit)             ack_mbx;
   
//-------------------------------------------------------
//Statistics variable
//-------------------------------------------------------
   uint txn_count;
   
//-------------------------------------------------------
//Constructor
//-------------------------------------------------------
   function new(
      virtual cp_if.DRV              vif,
      mailbox #(transaction) gen2drv_mbx, 
      mailbox #(bit)             ack_mbx
   );
      this.vif         =         vif;
      this.gen2drv_mbx = gen2drv_mbx;
      this.ack_mbx     =     ack_mbx;
      this.txn_count   =           0;
   endfunction
   
//-------------------------------------------------------
//Tasks
//-------------------------------------------------------
   //run task for the top level functionality of driver
   task run();
      transaction txn;
      $display("[DRV] Started fetching transactions");
      forever begin
         gen2drv_mbx.get(txn);
         drive(txn);
         txn_count++;
         ack_mbx.put(1'b1);
      end
   endtask
   
   //drive task to drive signal/values to the interface
   task drive(transaction txn);
      #5;  //Driving values after a delay
      vif.in1 = txn.in1;
      vif.in2 = txn.in2;
      
      #5;  //Holding values till a delay, then resetting again
      vif.in1 = 4'h0;
      vif.in2 = 4'h0;
      
      $display("[DRV] In1: %0d, In2: %0d", txn.in1, txn.in2);
   endtask
   
endclass : driver

`endif //CP_DRIVER_SV
