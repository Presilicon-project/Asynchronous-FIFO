//`include "transaction.sv"

class monitor_in;
  virtual async_fifo_if vif;
  mailbox mon_in2scb;
  transaction tx=new();
int fd;
  function new(virtual async_fifo_if vif, mailbox mon_in2scb);
    this.vif = vif;
    this.mon_in2scb = mon_in2scb;
  endfunction
  
  task main;
     
    $display("[ MONITOR_IN ] ****** MONITOR_IN STARTED ******"); 
   
     
            
 
    forever begin
       
        @(posedge vif.wclk iff !vif.wfull);
        
        if (vif.winc) begin
           
           tx.wdata =vif.wdata;
           tx.uniq_id =vif.uniq_id;
           if(vif.uniq_id <=99)
               $display("[ MONITOR-IN]wdata =%h \n",tx.wdata);
          mon_in2scb.put(tx);
         
        end
     end 
    
    $display("[ MONITOR_IN ] ****** MONITOR_IN ENDED ******");    
  endtask
endclass