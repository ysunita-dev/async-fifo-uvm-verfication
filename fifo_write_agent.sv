import uvm_pkg::*;
`include "uvm_macros.svh"

class fifo_write_agent extends uvm_agent;
  fifo_write_sequencer sequencer;
  fifo_write_driver driver;
  fifo_write_monitor monitor;
  
  `uvm_component_utils(fifo_write_agent)
  
  function new(string name = "fifo_write_agent" , uvm_component parent = null );
    super.new(name , parent);
  endfunction 
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sequencer = fifo_write_sequencer::type_id::create("sequencer", this);
    driver = fifo_write_driver::type_id::create("driver" , this);
    monitor = fifo_write_monitor::type_id::create("monitor", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction 
endclass
