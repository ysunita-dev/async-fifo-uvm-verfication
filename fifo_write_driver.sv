import uvm_pkg::*;
`include "uvm_macros.svh"

class fifo_write_driver extends uvm_driver #(fifo_write_txn#(32));
  virtual fifo_write_if.DRIVER vif;
  `uvm_component_utils(fifo_write_driver)
  
  function new(string name = "fifo_write_driver", uvm_component parent = null);
    super.new(name,parent);
  endfunction 
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db#(virtual fifo_write_if.DRIVER)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Write virtual interface not found")
      endfunction 
      
      
      task run_phase(uvm_phase phase);
    fifo_write_txn #(32) req;
      forever begin 
        
        seq_item_port.get_next_item(req);
        
        @(vif.cb_driver);
          vif.cb_driver.write_enable <= req.write_enable ;
          vif.cb_driver.wdata<= req.wdata;
        seq_item_port.item_done();
      end
    endtask
    endclass
