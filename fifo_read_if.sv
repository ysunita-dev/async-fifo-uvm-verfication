interface fifo_read_if #(parameter DATA_WIDTH = 32);
  
  logic rclk;
  logic rreset;
  logic read_enable;
  logic[DATA_WIDTH-1:0] rdata;
  logic rd_empty;
  
  clocking cb_driver@(posedge rclk);
    default input #1step output #1step;
  
    input rd_empty;
    output rreset;
    output  read_enable;
    input rdata ;
  endclocking
  
  
clocking cb_monitor@(posedge rclk);
   // default input #1 output #1step;
  
    input rd_empty;
    input rreset;
    input  read_enable;
    input   rdata ;
  endclocking
  
  modport DRIVER(
    clocking cb_driver);
      
modport MONITOR(clocking cb_monitor);
        
    endinterface
