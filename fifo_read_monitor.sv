import uvm_pkg::*;
`include "uvm_macros.svh"

class fifo_read_monitor extends uvm_monitor;
  virtual fifo_read_if.MONITOR vif;
  
  uvm_analysis_port #(fifo_read_txn#(32))analysis_port;
  `uvm_component_utils(fifo_read_monitor)
  
  covergroup read_cg;

    cp_read_enable : coverpoint vif.cb_monitor.read_enable {
      bins no_read = {0};
      bins read    = {1};
    }
    
    cp_rd_empty : coverpoint vif.cb_monitor.rd_empty {
      bins not_empty = {0};
      bins empty     = {1};
    }

    read_empty_cross : cross cp_read_enable, cp_rd_empty;

  endgroup

  
  function new(string name = "fifo_read_monitor", uvm_component parent = null);
    super.new(name,parent);
    analysis_port =  new("analysis_port", this);
    read_cg = new();
  endfunction 
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db#(virtual fifo_read_if.MONITOR)::get(this , "", "vif", vif))
      `uvm_fatal("NOVIF", "read monitor virtual interface not found")
      
      endfunction 
      
      
      task run_phase(uvm_phase phase);

    fifo_read_txn #(32) tx;
    bit pending_read;

    pending_read = 1'b0;

    forever begin
        @(vif.cb_monitor);
       read_cg.sample();

       
        if (pending_read) begin

            tx = fifo_read_txn#(32)::type_id::create("tx");

            tx.read_enable = 1'b1;
            tx.rdata       = vif.cb_monitor.rdata;

            analysis_port.write(tx);
        end

       
        pending_read = vif.cb_monitor.read_enable &&
                       !vif.cb_monitor.rd_empty;

    end

endtask
    
    function void report_phase(uvm_phase phase);

    `uvm_info("READ_COV",
      $sformatf("READ COVERAGE = %0.2f%%",
                read_cg.get_coverage()),
      UVM_MEDIUM)

    `uvm_info("READ_COV",
      $sformatf("read_enable = %0.2f%%",
                read_cg.cp_read_enable.get_coverage()),
      UVM_MEDIUM)

    `uvm_info("READ_COV",
      $sformatf("rd_empty = %0.2f%%",
                read_cg.cp_rd_empty.get_coverage()),
      UVM_MEDIUM)

    `uvm_info("READ_COV",
      $sformatf("read_empty_cross = %0.2f%%",
                read_cg.read_empty_cross.get_coverage()),
      UVM_MEDIUM)

  endfunction
    
    endclass
