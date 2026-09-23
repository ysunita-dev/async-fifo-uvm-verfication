import uvm_pkg::*;
`include "uvm_macros.svh"

class fifo_test extends uvm_test;
  fifo_env env;
  `uvm_component_utils(fifo_test)
  
  function new(string name = "fifo_test" , uvm_component parent = null);
    super.new(name , parent);
  endfunction 
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = fifo_env::type_id::create("env" , this);
  endfunction 
  
  task run_phase(uvm_phase phase);
    fifo_write_sequence write_seq;
    fifo_read_sequence read_seq;
    
    phase.raise_objection(this);
    
    env.reset_controller.reset_fifo();
    env.scoreboard.reset_scoreboard();
    
    write_seq= fifo_write_sequence::type_id::create("write_seq" , this);
    read_seq = fifo_read_sequence::type_id::create("read_seq" , this);
    
    fork
      write_seq.start(env.write_agent.sequencer);
      read_seq.start(env.read_agent.sequencer);
    join
    
    phase.drop_objection(this);
  endtask
endclass
