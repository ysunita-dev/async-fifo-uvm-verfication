`timescale 1ns/1ps

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "fifo_write_if.sv"
`include "fifo_read_if.sv"
`include "fifo_write_txn.sv"
`include "fifo_read_txn.sv"
`include "fifo_write_sequence.sv"
`include "fifo_read_sequence.sv"
`include "fifo_write_sequencer.sv"
`include "fifo_read_sequencer.sv"
`include "fifo_write_driver.sv"
`include "fifo_read_driver.sv"
`include "fifo_write_monitor.sv"
`include "fifo_read_monitor.sv"
`include "fifo_write_agent.sv"
`include "fifo_read_agent.sv"
`include "fifo_reset_controller.sv"
`include "fifo_scoreboard.sv"
`include "fifo_env.sv"
`include "fifo_test.sv"
`include "fifo_assertions.sv"

module fifo_tb;

    
    logic wclk;
    logic rclk;

    initial begin
        wclk = 1'b0;
        forever #5 wclk = ~wclk;
    end

    initial begin
        rclk = 1'b0;
        forever #7 rclk = ~rclk;
    end


   
    fifo_write_if write_if();

    fifo_read_if read_if();


    

    assign write_if.wclk = wclk;
    assign read_if.rclk  = rclk;


   
    fifo_wrapper dut (

        .wclk         (write_if.wclk),
        .rclk         (read_if.rclk),

        .wreset       (write_if.wreset),
        .rreset       (read_if.rreset),

        .write_enable (write_if.write_enable),
      .read_enable(read_if.read_enable),
        .wdata        (write_if.wdata),

        .rdata        (read_if.rdata),

        .wr_full      (write_if.wr_full),
        .rd_empty     (read_if.rd_empty)

    );



    initial begin

        $dumpfile("fifo_tb.vcd");
        $dumpvars(0, fifo_tb);

    end


   
    initial begin

        uvm_config_db#(
            virtual fifo_write_if.DRIVER
        )::set(
            null,
            "uvm_test_top.env.write_agent.driver",
            "vif",
            write_if
        );


        
        uvm_config_db#(
            virtual fifo_write_if.MONITOR
        )::set(
            null,
            "uvm_test_top.env.write_agent.monitor",
            "vif",
            write_if
        );


       
        uvm_config_db#(
            virtual fifo_read_if.DRIVER
        )::set(
            null,
            "uvm_test_top.env.read_agent.driver",
            "vif",
            read_if
        );


       

        uvm_config_db#(
            virtual fifo_read_if.MONITOR
        )::set(
            null,
            "uvm_test_top.env.read_agent.monitor",
            "vif",
            read_if
        );


       
        uvm_config_db#(
            virtual fifo_write_if.DRIVER
        )::set(
            null,
            "uvm_test_top.env.reset_controller",
            "w_vif",
            write_if
        );


       
        uvm_config_db#(
            virtual fifo_read_if.DRIVER
        )::set(
            null,
            "uvm_test_top.env.reset_controller",
            "r_vif",
            read_if
        );

    end


  
    initial begin
   
    run_test("fifo_test");
end

endmodule
