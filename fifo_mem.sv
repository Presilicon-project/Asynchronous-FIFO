//
// FIFO memory
//
module fifomem
#(
  parameter DATASIZE = 8, // Memory data word width
  parameter ADDRSIZE = 9  // Number of mem address bits
)
(
  input  logic winc, wfull, wclk,
  input  logic [ADDRSIZE-1:0] waddr, raddr,
  input  logic [DATASIZE-1:0] wdata,
  output logic [DATASIZE-1:0] rdata
);

  // RTL Verilog memory model
  localparam DEPTH = 444;//1<<ADDRSIZE;

  logic [DATASIZE-1:0] mem [0:DEPTH-1];

  assign rdata = mem[raddr];

  always_ff @(posedge wclk)
    if (winc && !wfull)
      mem[waddr] <= wdata;

endmodule