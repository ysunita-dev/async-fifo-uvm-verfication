import uvm_pkg::*;
`include "uvm_macros.svh"

`uvm_analysis_imp_decl(_write)
`uvm_analysis_imp_decl(_read)

class fifo_scoreboard extends uvm_scoreboard;
  bit[31:0] expected_queue[$];
  
  uvm_analysis_imp_write#(fifo_write_txn#(32) , fifo_scoreboard)write_export;
  uvm_analysis_imp_read#(fifo_read_txn#(32) , fifo_scoreboard)read_export;
  
  `uvm_component_utils(fifo_scoreboard)
  
  function new(string name = " fifo_scoreboard" , uvm_component parent = null);
    super.new(name, parent);
    write_export = new("write_export", this);
    read_export = new("read_export" , this);
  endfunction 
  
  function void write_write(fifo_write_txn#(32) tx);
    expected_queue.push_back(tx.wdata);
  endfunction 
  
  function void write_read(fifo_read_txn#(32) tx);
    bit[31:0] expected_data;
    if(expected_queue.size()==0)begin
      `uvm_error("FIFO_SCB" ,"Read occured but expected queue is empty")
      return;
    end
    
    expected_data = expected_queue.pop_front();
    
    if (tx.rdata !== expected_data)begin
      `uvm_error("FIFO SCB" , $sformatf("FIFO DATA MISMATCH : expected = %0d , actual = %0d ", expected_data , tx.rdata))
                                        
       end
    else begin
      `uvm_info("FIFO_SCB" , $sformatf("FIFO DATA MATCH: data %0d ", tx.rdata), UVM_MEDIUM)
       end
       endfunction 
  
   function void reset_scoreboard();
     expected_queue.delete();
     `uvm_info("FIFO_SCB", " Scoreboard reference queue cleared due to FIFO reset ", UVM_MEDIUM )
     endfunction
   endclass
                                                                   
