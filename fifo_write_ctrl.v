module fifo_write_ctrl#( parameter ADDR_WIDTH =8 ,
                        parameter PTR_WIDTH= ADDR_WIDTH+1)
  ( input wclk ,
   input wreset ,
   input write_enable,
   input [PTR_WIDTH-1:0]rptr_bin_sync,
   output [ ADDR_WIDTH-1:0] waddr,
   output reg [PTR_WIDTH-1:0] wptr_gray,
   output wr_full,
   output wr_allowed );
  
  reg [PTR_WIDTH-1:0] wptr_bin;
  assign waddr = wptr_bin[ADDR_WIDTH-1:0];
  assign wr_allowed = write_enable && !wr_full;
  
  always @ (posedge wclk , negedge wreset)begin
    if(!wreset)
      wptr_bin <= {PTR_WIDTH{1'b0}};
  else if(write_enable && !wr_full)
      wptr_bin <= wptr_bin + 1'b1 ;
  
  end 
  assign wr_full = (wptr_bin[ADDR_WIDTH-1:0] == rptr_bin_sync[ADDR_WIDTH-1:0])&& (wptr_bin[PTR_WIDTH-1]!= rptr_bin_sync[PTR_WIDTH-1]);
  
  assign wptr_gray = wptr_bin ^ (wptr_bin >> 1);
  
endmodule
