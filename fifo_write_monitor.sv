import uvm_pkg::*;
`include "uvm_macros.svh"

class fifo_write_monitor extends uvm_monitor;
  virtual fifo_write_if.MONITOR vif;
  
  uvm_analysis_port #(fifo_write_txn#(32))analysis_port;
  `uvm_component_utils(fifo_write_monitor)
  
  
  covergroup write_cg;
    cp_write_enable : coverpoint vif.cb_monitor.write_enable {
      bins no_write = {0};
      bins write    = {1};
    }
    
    cp_wr_full : coverpoint vif.cb_monitor.wr_full {
      bins not_full = {0};
      bins full     = {1};
    }
    
    write_full_cross : cross cp_write_enable, cp_wr_full;
  endgroup

  
  function new(string name = "fifo_write_monitor", uvm_component parent = null);
    super.new(name,parent);
    analysis_port =  new("analysis_port", this);
     write_cg = new();
  endfunction 
  
  
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db#(virtual fifo_write_if.MONITOR)::get(this , "", "vif", vif))
      `uvm_fatal("NOVIF", "write monitor virtual interface not found")
      
      endfunction 
      
      
      task run_phase(uvm_phase phase);
    fifo_write_txn #(32) tx;
    forever begin 
      @(vif.cb_monitor);
       write_cg.sample();
      
      if(vif.cb_monitor.write_enable && !vif.cb_monitor.wr_full)begin
        tx= fifo_write_txn#(32)::type_id::create ("tx");
        
        tx.write_enable = vif.cb_monitor.write_enable;
        tx.wdata= vif.cb_monitor.wdata;
        analysis_port.write(tx);
      end
    end
    endtask
    
   function void report_phase(uvm_phase phase);

  `uvm_info("WRITE_COV",
    $sformatf("WRITE COVERAGE = %0.2f%%",
              write_cg.get_coverage()),
    UVM_MEDIUM)

  `uvm_info("WRITE_COV",
    $sformatf("write_enable = %0.2f%%",
              write_cg.cp_write_enable.get_coverage()),
    UVM_MEDIUM)

  `uvm_info("WRITE_COV",
    $sformatf("wr_full = %0.2f%%",
              write_cg.cp_wr_full.get_coverage()),
    UVM_MEDIUM)

  `uvm_info("WRITE_COV",
    $sformatf("write_full_cross = %0.2f%%",
              write_cg.write_full_cross.get_coverage()),
    UVM_MEDIUM)

endfunction
    
    endclass
