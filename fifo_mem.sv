//*****************FIFO_Memory_Module*************************//

module fifomem(rdata, wdata, waddr, raddr, wclken, wfull, wclk);

parameter DATASIZE=8;

parameter ADDRSIZE=444;

input [DATASIZE-1:0] wdata;
input [ADDRSIZE-1:0] waddr, raddr;
input wclken, wfull, wclk;
output [DATASIZE-1:0] rdata;

localparam DEPTH = 1<<ADDRSIZE;  

reg [DATASIZE-1:0] mem [0:DEPTH-1];

assign rdata = mem[raddr];

always @(posedge wclk) begin
	if(wclken && !wfull) mem[waddr]<=wdata;
end

endmodule 
