import uvm_pkg::*;
`include "uvm_macros.svh"

class fifo_env extends uvm_env;
  fifo_write_agent write_agent;
  fifo_read_agent read_agent;
  fifo_scoreboard scoreboard;
  fifo_reset_controller reset_controller;

  
  `uvm_component_utils(fifo_env)
  
  function new(string name = "fifo_env" , uvm_component parent = null);
    super.new(name,parent);
  endfunction 
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    write_agent = fifo_write_agent ::type_id::create("write_agent" , this);
    read_agent = fifo_read_agent :: type_id:: create("read_agent" , this);
    scoreboard = fifo_scoreboard :: type_id:: create("scoreboard" , this);
    reset_controller = fifo_reset_controller::type_id::create("reset_controller" , this);
    
    
  endfunction 
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    write_agent.monitor.analysis_port.connect(scoreboard.write_export);
    read_agent.monitor.analysis_port.connect(scoreboard.read_export);
    
    
  endfunction 
endclass
