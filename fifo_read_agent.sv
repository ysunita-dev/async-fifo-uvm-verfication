import uvm_pkg::*;
`include "uvm_macros.svh"

class fifo_read_agent extends uvm_agent;
  fifo_read_sequencer sequencer;
  fifo_read_driver driver;
  fifo_read_monitor monitor;
  
  `uvm_component_utils(fifo_read_agent)
  
  function new(string name = "fifo_read_agent" , uvm_component parent = null );
    super.new(name , parent);
  endfunction 
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sequencer = fifo_read_sequencer::type_id::create("sequencer", this);
    driver = fifo_read_driver::type_id::create("driver" , this);
    monitor = fifo_read_monitor::type_id::create("monitor", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction 
endclass
