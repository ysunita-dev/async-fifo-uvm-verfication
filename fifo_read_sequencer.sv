import uvm_pkg::*;
`include "uvm_macros.svh"

class fifo_read_sequencer extends uvm_sequencer #(fifo_read_txn#(32));
  
  `uvm_component_utils(fifo_read_sequencer)
  
  function new(string name ="fifo_read_sequencer" , uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
endclass 
