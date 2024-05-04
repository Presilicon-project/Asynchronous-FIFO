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



  
    
  initial begin
   
    bus_tb.wclk = 1'b0;
    bus_tb.rclk = 1'b0;
       
  
    fork
      forever #10ns bus_tb.wclk = ~bus_tb.wclk;
      forever #35ns bus_tb.rclk = ~bus_tb.rclk;
    join
  end
    
 

endmodule