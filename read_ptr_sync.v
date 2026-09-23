module read_ptr_sync #(parameter ADDR_WIDTH = 8 ,
                       parameter PTR_WIDTH = ADDR_WIDTH +1)                     
                       ( input wclk ,
                       input wreset ,
                       input [PTR_WIDTH-1:0] rptr_gray,
                       output reg[PTR_WIDTH-1:0] rptr_sync_bin);
  reg[PTR_WIDTH-1:0]sync_ff3;
  reg[PTR_WIDTH-1:0]sync_ff4;
  always@(posedge wclk , negedge wreset)begin
    if(!wreset)begin
      sync_ff3<=0;
      sync_ff4<=0;
    end
    else begin 
      sync_ff3 <= rptr_gray;
      sync_ff4 <= sync_ff3;
    end
  end
  
        
 integer i ;
  always @(*)
    begin
      rptr_sync_bin[PTR_WIDTH-1] = sync_ff4[PTR_WIDTH-1];
      for(i=PTR_WIDTH-2; i>=0 ; i= i-1)
        rptr_sync_bin[i] = rptr_sync_bin[i+1] ^ sync_ff4[i];
    end
endmodule
  

