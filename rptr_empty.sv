//**********************right pointer empty***********************************//
module rptr_empty (rempty, raddr, rptr, rq2_wptr,rinc, rclk, rrst_n);


parameter ADDRSIZE=444;
input [ADDRSIZE:0] rq2_wptr;
input rinc, rclk, rrst_n;
output reg rempty;
output [ADDRSIZE-1:0] raddr;
output reg [ADDRSIZE:0] rptr;

reg [ADDRSIZE:0] rbin;
wire [ADDRSIZE:0] rgraynext, rbinnext;
wire rempty_val;



always @(posedge rclk or negedge rrst_n)
	if(!rrst_n) {rbin, rptr}<=0;
	else {rbin, rptr}<={rbinnext, rgraynext};


assign raddr = rbin[ADDRSIZE-1:0];
assign rbinnext = rbin + (rinc & ~rempty);
assign rgraynext = (rbinnext>>1) ^ rbinnext;



assign rempty_val = (rgraynext == rq2_wptr);

always @(posedge rclk or negedge rrst_n)begin
	if(!rrst_n) rempty<=1'b1;
	else rempty<=rempty_val;
end


endmodule
