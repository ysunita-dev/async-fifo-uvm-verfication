import uvm_pkg::*;
`include "uvm_macros.svh"

class fifo_write_sequence extends uvm_sequence #(fifo_write_txn#(32));
  
  `uvm_object_utils(fifo_write_sequence)
  
  function new( string name  = "fifo_write_sequence");
    super.new(name);
  endfunction 
  
  task body();
    fifo_write_txn #(32) req;
    
    repeat(200) begin
    req = fifo_write_txn#(32)::type_id::create("req");
    start_item(req);
    assert(req.randomize());
    
    finish_item(req);
end
    
    repeat(400) begin 
      req = fifo_write_txn#(32)::type_id::create("req");
      start_item(req);
      req.write_enable = 1;
      assert(req.randomize());
      finish_item(req);
    end
    
    repeat(7) begin 
      req = fifo_write_txn#(32)::type_id::create("req");
      start_item(req);
      req.write_enable = 0;
      assert(req.randomize());
      finish_item(req);
    end
  endtask
  
endclass
