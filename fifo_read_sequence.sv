import uvm_pkg::*;
`include "uvm_macros.svh"

class fifo_read_sequence extends uvm_sequence #(fifo_read_txn#(32));
  
  `uvm_object_utils(fifo_read_sequence)
  
  function new( string name  = "fifo_read_sequence");
    super.new();
  endfunction 
  
  task body();
    fifo_read_txn #(32) req;
    
    
    repeat(1000) begin 
      req = fifo_read_txn#(32)::type_id::create("req");
      start_item(req);
      assert(req.randomize());
      
      finish_item(req);
    end


  endtask
  
endclass
