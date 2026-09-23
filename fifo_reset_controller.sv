import uvm_pkg::*;
`include "uvm_macros.svh"

class fifo_reset_controller extends uvm_component;
  virtual fifo_write_if.DRIVER w_vif;
  virtual fifo_read_if.DRIVER r_vif;
  
  `uvm_component_utils(fifo_reset_controller)
  
  function new( string name = "fifo_reset_controller" , uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db#(virtual fifo_write_if.DRIVER)::get(this,"","w_vif",w_vif))
      `uvm_fatal("NOVIF" , "Write virtual interface not found")
      
      if(!uvm_config_db#(virtual fifo_read_if.DRIVER)::get(this , "", "r_vif", r_vif))
        `uvm_fatal("NOVIF" , "Read virtual interface not found")
        
        endfunction
        
        task reset_fifo();
    w_vif.cb_driver.wreset <= 1'b0;
    r_vif.cb_driver.rreset <= 1'b0;
    
    repeat(2) @( w_vif.cb_driver);
    repeat(2) @(r_vif.cb_driver);
    
    @(w_vif.cb_driver);
    w_vif.cb_driver.wreset <= 1'b1;
    @(r_vif.cb_driver);
    r_vif.cb_driver.rreset <= 1'b1;
    
    endtask
    endclass
