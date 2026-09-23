module write_ptr_sync #(parameter ADDR_WIDTH = 8 ,
                        parameter PTR_WIDTH =ADDR_WIDTH+1)
                        (input rclk ,
                       input rreset ,
                       input [PTR_WIDTH-1:0] wptr_gray,
                       output reg[PTR_WIDTH-1:0] wptr_sync_bin);
  reg[PTR_WIDTH-1:0]sync_ff1;
  reg[PTR_WIDTH-1:0]sync_ff2;
  
  always@(posedge rclk , negedge rreset)begin
    if(!rreset)begin
      sync_ff1<=0;
      sync_ff2<=0;
    end
    else begin 
      sync_ff1 <= wptr_gray;
      sync_ff2 <= sync_ff1;
    end
  end
  integer i ;
  always @(*)
    begin
      wptr_sync_bin[PTR_WIDTH-1] = sync_ff2[PTR_WIDTH-1];
      for(i=PTR_WIDTH-2; i>=0 ; i= i-1)
        wptr_sync_bin[i] = wptr_sync_bin[i+1] ^ sync_ff2[i];
    end
endmodule
