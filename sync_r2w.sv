/****************** FIFO Read Module******************/

module sync_r2w(wq2_rptr,
		rptr,
		wclk, wrst_n);

parameter ADDRSIZE=8;

input [ADDRSIZE:0] rptr;
input wclk, wrst_n;
output reg [ADDRSIZE:0] wq2_rptr;

reg [ADDRSIZE:0] wq1_rptr;

always @(posedge wclk or negedge wrst_n) begin
	if(!wrst_n) {wq2_rptr,wq1_rptr} <=0;
	else {wq2_rptr,wq1_rptr} <= {wq1_rptr,rptr};

end

endmodule

