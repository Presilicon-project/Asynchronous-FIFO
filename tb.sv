
//testbench for fifo
module tb_top;

parameter DSIZE=8;
parameter ASIZE=444;

logic [DSIZE-1:0] rdata;
logic wfull;
logic rempty;
logic [DSIZE-1:0] wdata;
logic winc, wclk, wrst_n;
logic rinc, rclk, rrst_n;


logic [DSIZE-1:0] verif_data_q[$];
logic [DSIZE-1:0] verif_wdata;


//instantiating  fifo 
asynchronous_fifo fifo1(.data_out(rdata),
		.full(wfull),
		.empty(rempty),
		.data_in(wdata),
		.w_en(winc),
		.wclk(wclk),
		.wrst_n(wrst_n),
		.r_en(rinc),
		.rclk(rclk),
		.rrst_n(rrst_n));



always #1 wclk=~wclk;


always #1 rclk=~rclk;


initial begin
	rclk=1'b0;
	wclk=1'b0;
	@(negedge wclk) wrst_n=1'b1;
	@(negedge wclk) wrst_n=1'b0;
	@(negedge wclk) wrst_n=1'b1;
	@(negedge rclk) rrst_n=1'b0;
	@(negedge rclk) rrst_n=1'b1;
	$display("wfull=%b",wfull);
	fork 
	begin
		for(int i=0; i<10; i++)begin
			@(negedge wclk iff !wfull);
			winc=(i%1==0)? 1'b1:1'b0;
			if(winc)begin
				$display("Team6");
				wdata=$random;
				verif_data_q.push_front(wdata);
			end
		end
	end

	begin
		for(int j=0;j<10;j++)begin
			@(negedge rclk); 
			rinc = (j%3==0)? 1'b1:1'b0;
			$display("Team6");
			if(rinc)begin
				verif_wdata=verif_data_q.pop_back();
				$display("verif_wdata=%0h rdata=%h", verif_wdata, rdata);
				if(rdata!==verif_wdata) $error;	
			end
		end
	end

	join
end

endmodule
