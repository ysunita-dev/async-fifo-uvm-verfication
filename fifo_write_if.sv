interface fifo_write_if #(parameter DATA_WIDTH = 32);
  
  logic wclk;
  logic wreset;
  logic write_enable;
  logic[DATA_WIDTH-1:0] wdata;
  logic wr_full;
  
  
  clocking cb_driver @(posedge wclk);
    default input #1step output #1step;
    input wr_full;
    output wreset;
    output  write_enable;
    output wdata ;
  endclocking
  
  
 clocking cb_monitor @(posedge wclk);
    default input #1step output #1step;
    input wr_full;
    input wreset;
    input  write_enable;
    input wdata ;
  endclocking
  
  modport DRIVER (clocking cb_driver);
    modport MONITOR (clocking cb_monitor);
      
  
endinterface
