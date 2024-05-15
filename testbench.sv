`include "interface.sv"
`include "test.sv"

module async_fifo_tb_class;

  parameter DSIZE = 8;
  parameter ASIZE = 9;
 


  
async_fifo_if bus_tb();
test test_inst(bus_tb);

async_fifo1 #(DSIZE, ASIZE) dut (
    .bus(bus_tb)
  );

covergroup fifo_coverage;
    option.per_instance = 1;
    /*coverpoint bus_tb.wdata{
      bins wr_data = {[0:255]};
    }*/
    coverpoint bus_tb.rinc {
      bins rinc_bin[] = {0, 1};
    }
    coverpoint bus_tb.winc {
      bins rinc_winc[] = {0, 1};
    }
    coverpoint bus_tb.wrst_n {
      bins rinc_wrst_n[] = {0, 1};
    }
    coverpoint bus_tb.rrst_n {
      bins rinc_rrst_n[] = {0, 1};
    }
    coverpoint bus_tb.wfull {
      bins wfull_bin = {0, 1};
    }
    coverpoint bus_tb.rempty {
      bins rempty_bin = {0, 1};
    }
   /* cross bus_tb.rempty,bus_tb.winc; // read and fifo empty
    cross bus_tb.rempty,bus_tb.w_en,bus_tb.wdata; // read write fifo empty
  */
	

  endgroup

  
    
  initial begin
   
    bus_tb.wclk = 1'b0;
    bus_tb.rclk = 1'b0;
       
  
    fork
      forever #10ns bus_tb.wclk = ~bus_tb.wclk;
      forever #35ns bus_tb.rclk = ~bus_tb.rclk;
    join
  end
 
initial begin 
fifo_coverage fifo_cov; // Inst the coverage group
fifo_cov=new();

     forever begin@(negedge bus_tb.wclk);
        fifo_cov.sample();

     end

  end   
 

endmodule