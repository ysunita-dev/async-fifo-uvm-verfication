module fifo_mem#(parameter DATA_WIDTH = 32 , parameter ADDR_WIDTH = 8)(
input rclk , wclk,
  input [ADDR_WIDTH-1:0]waddr,
  input [ADDR_WIDTH-1:0]raddr,
  input [DATA_WIDTH-1:0]wdata,
input write_allowed,
  input read_allowed,
  output reg [DATA_WIDTH-1:0]rdata);

 reg [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];

always @(posedge wclk)
  if (write_allowed)
    mem[waddr]<= wdata;

always@(posedge rclk)
  if(read_allowed)
    rdata <= mem[raddr];
endmodule


