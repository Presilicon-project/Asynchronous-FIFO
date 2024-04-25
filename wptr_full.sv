//*******************write pointer full **********************//
module wptr_full(wfull, waddr, wptr, wq2_rptr, winc, wclk, wrst_n);

parameter ADDRSIZE = 8;

input [ADDRSIZE:0] wq2_rptr;
input winc, wclk, wrst_n;
output reg wfull;
output [ADDRSIZE-1:0] waddr;
output reg [ADDRSIZE:0] wptr;

reg [ADDRSIZE:0] wbin;
wire [ADDRSIZE:0] wgraynext, wbinnext;
wire wfull_val;

//Graystyle pointer

always @(posedge wclk or negedge wrst_n)begin

	if(!wrst_n) {wbin, wptr}<=0;
	else {wbin, wptr} <= {wbinnext, wgraynext};

end

// Memory write address pointer

assign waddr = wbin[ADDRSIZE-1:0];

assign wbinnext = wbin + (winc & ~wfull);
assign wgraynext = (wbinnext>>1) ^ wbinnext;


assign wfull_val = (wgraynext=={~wq2_rptr[ADDRSIZE:ADDRSIZE-1],
				wq2_rptr[ADDRSIZE-2:0]});

always @(posedge wclk or negedge wrst_n)begin
	if(!wrst_n) wfull<=1'b0;
	wfull <=wfull_val;
end

endmodule
