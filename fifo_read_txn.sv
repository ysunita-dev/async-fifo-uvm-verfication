`timescale 1ns/1ps 

import uvm_pkg::*;
`include "uvm_macros.svh"


class fifo_read_txn #(parameter DATA_WIDTH =32) extends uvm_sequence_item;
  rand bit read_enable;
  bit [DATA_WIDTH-1:0] rdata;
  bit rd_empty;
  
  constraint read_enable_c { read_enable dist { 1 := 8 , 0:=2 };}
  
  
  `uvm_object_param_utils_begin(fifo_read_txn#(DATA_WIDTH))
  
  `uvm_field_int(read_enable , UVM_ALL_ON)
  `uvm_field_int(rdata , UVM_ALL_ON)
  
  `uvm_object_utils_end
  
  function new( string name = "fifo_read_txn");
    super.new(name);
  endfunction 
  
endclass
