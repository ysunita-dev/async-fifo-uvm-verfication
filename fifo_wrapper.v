module fifo_wrapper#( parameter DATA_WIDTH = 32,
                     parameter ADDR_WIDTH = 8 ,
                     parameter PTR_WIDTH = ADDR_WIDTH + 1)
  ( input wclk ,
   input rclk,
   input wreset,
   input rreset,
   input write_enable,
   input read_enable,
   input [ DATA_WIDTH-1:0] wdata,
   output [DATA_WIDTH-1:0] rdata,
   output wr_full,
   output rd_empty );
  
  wire [ADDR_WIDTH-1:0]waddr;
  wire[ ADDR_WIDTH-1:0]raddr;
  wire [ PTR_WIDTH-1:0] wptr_gray;
  wire[PTR_WIDTH-1:0] rptr_gray;
  wire[PTR_WIDTH-1:0] wptr_sync_bin;
  wire[PTR_WIDTH-1:0] rptr_sync_bin;
  wire wr_allowed;
  wire rd_allowed;
  
  
  fifo_mem#(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH))u_fifo_mem(
    .wclk(wclk),
    .rclk(rclk),
    .waddr(waddr),
    .raddr(raddr),
    .wdata(wdata),
    .rdata(rdata),
    .write_allowed(wr_allowed),
    .read_allowed(rd_allowed)
  );
            
            
  fifo_write_ctrl #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .PTR_WIDTH(PTR_WIDTH)
) u_write_ctrl (
    .wclk(wclk),
    .wreset(wreset),
    .write_enable(write_enable),
    .rptr_bin_sync(rptr_sync_bin),

    .waddr(waddr),
    .wptr_gray(wptr_gray),
    .wr_full(wr_full),
    .wr_allowed(wr_allowed)
);
  
  
  write_ptr_sync #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .PTR_WIDTH(PTR_WIDTH)
) u_write_ptr_sync (
    .rclk(rclk),
    .rreset(rreset),
    .wptr_gray(wptr_gray),
    .wptr_sync_bin(wptr_sync_bin)
);
            
 fifo_read_ctrl #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .PTR_WIDTH(PTR_WIDTH)
) u_read_ctrl (
    .rclk(rclk),
    .rreset(rreset),
    .read_enable(read_enable),
    .wptr_bin_sync(wptr_sync_bin),

    .raddr(raddr),
    .rptr_gray(rptr_gray),
    .rd_empty(rd_empty),
    .rd_allowed(rd_allowed)
);
  
     read_ptr_sync #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .PTR_WIDTH(PTR_WIDTH)
) u_read_ptr_sync (
    .wclk(wclk),
    .wreset(wreset),
    .rptr_gray(rptr_gray),
    .rptr_sync_bin(rptr_sync_bin)
);
endmodule 
            
