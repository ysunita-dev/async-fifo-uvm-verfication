module fifo_read_ctrl#( parameter ADDR_WIDTH = 8,
                       parameter PTR_WIDTH = ADDR_WIDTH+1)(
  input rclk ,
  input rreset,
  input read_enable ,
  input [PTR_WIDTH-1:0]wptr_bin_sync,
  output[ADDR_WIDTH-1:0]raddr,
  output reg[PTR_WIDTH-1:0]rptr_gray,
  output rd_empty,
  output rd_allowed );
  
  reg [PTR_WIDTH-1:0] rptr_bin;
   assign raddr = rptr_bin[ADDR_WIDTH-1:0];
  assign rd_allowed = read_enable &&!rd_empty ;
  assign rd_empty = (rptr_bin[ADDR_WIDTH-1:0] == wptr_bin_sync[ADDR_WIDTH-1:0])&& (rptr_bin[PTR_WIDTH-1]== wptr_bin_sync[PTR_WIDTH-1]);
  
  
  always @ (posedge rclk , negedge rreset)begin
    if(!rreset)
      rptr_bin <= {PTR_WIDTH{1'b0}};
    else if(read_enable && !rd_empty)
      rptr_bin <= rptr_bin + 1'b1 ;
  
  end 
  assign rptr_gray = rptr_bin ^ (rptr_bin >> 1);
endmodule
