`timescale 1ns/1ps 

import uvm_pkg::*;
`include "uvm_macros.svh"


class fifo_write_txn #(parameter DATA_WIDTH = 32) extends uvm_sequence_item;
  rand bit write_enable;
  rand bit [DATA_WIDTH-1:0] wdata;
  bit wr_full;
  
  constraint write_enable_c { write_enable dist { 1 := 8 , 0:=2 };}
  
  
  `uvm_object_param_utils_begin(fifo_write_txn#(DATA_WIDTH))
  
  `uvm_field_int(write_enable , UVM_ALL_ON)
  `uvm_field_int(wdata , UVM_ALL_ON)
  
  `uvm_object_utils_end
  
  function new( string name = "fifo_write_txn");
    super.new(name);
  endfunction 
  
endclass
