import uvm_pkg::*;
`include "uvm_macros.svh"

class fifo_read_driver extends uvm_driver #(fifo_read_txn#(32));
  virtual fifo_read_if.DRIVER vif;
  `uvm_component_utils(fifo_read_driver)
  
  function new(string name = "fifo_read_driver", uvm_component parent = null);
    super.new(name,parent);
  endfunction 
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db#(virtual fifo_read_if.DRIVER)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "read virtual interface not found")
      endfunction 
      
      
    task run_phase(uvm_phase phase);
    fifo_read_txn #(32) req;
      forever begin 
        
        seq_item_port.get_next_item(req);
        
        @( vif.cb_driver);
          vif.cb_driver.read_enable <= req.read_enable ;
          
        seq_item_port.item_done();
      end
    endtask
    endclass
