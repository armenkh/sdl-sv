/******************************************************************************
*
*                    Copyright 2010-2011 Dolak-NER Systems.
*                    All rights reserved worldwide.
*
*******************************************************************************/



module signal_test;
    
  `ifdef INCA
    `include "uvm.svh"
    `include "sdl.svh"
  `else
    `include "uvm_macros.svh"
    import uvm_pkg::*;
    import sdl_svh::*;
  `endif

  class sig extends sdl_signal_base;
  	int s = 0;
  	function new (string name="", uvm_component initiator = null);
  		super.new(name,initiator);
  	endfunction
  endclass

 
  //The producer will generate the packets
  class producer extends uvm_component;
    
    //uvm_put_port #(sdl_signal_base) data_out;
    sdl_put_port data_out;
    
    function new(string name, uvm_component parent);
      super.new(name,parent);
      data_out = new("data_out", this);
    endfunction
    
    task run();
      sig p;
      #1 p=new("a1", this);
      p.s=1;
      data_out.put_signal(p);
      #1;
      p=new("a2", this);
      p.s=2;
      data_out.put_signal(p);
      #1;
      p=new("a3", this);
      p.s=3;
      data_out.put_signal(p);
      
      //while(data_out.put(p)) begin 
        //$display("%0t: put data %0d", $time, p.i);
      //  #10 p = new("a1", this);
      //end
    endtask

  endclass
  
  
  
    class producer1 extends uvm_component;
    
    //uvm_put_port #(sdl_signal_base) data_out;
    sdl_put_port data_out;
    
    function new(string name, uvm_component parent);
      super.new(name,parent);
      data_out = new("data_out", this);
    endfunction
    
    task run();
      sig p;
      #1 p=new("a1", this);
      p.s=1;
      data_out.put_signal(p);
      #1;
      p=new("a2", this);
      p.s=2;
      data_out.put_signal(p);
      #1;
      p=new("a3", this);
      p.s=3;
      data_out.put_signal(p);
      
      //while(data_out.put(p)) begin 
        //$display("%0t: put data %0d", $time, p.i);
      //  #10 p = new("a1", this);
      //end
    endtask

  endclass
  
  
  class consumer extends uvm_component;
  
    sdl_get_port  data_in;
  
    function new(string name, uvm_component parent);
      super.new(name,parent);
      data_in = new("data_in", this);
    endfunction
  
    task run();
      sdl_signal_base p;
      sig P;
      #5;
    for (int i =0; i<6; i++) begin
      data_in.get_signal(p);
      $cast(P,p);
      $display("p.sis %d", P.s);
      #1;
    end  
      //#100;  // fifo will fill up
      //while(data_in.try_get(p)) begin
      //  $display("%0t: recieved data %0d", $time, p.i);
      //  proc.change_state(p);
      //  #10;
      //end
    endtask
  endclass

  producer prod = new("prod", null);
  producer1 prod1 = new("prod1", null);
  consumer cons = new("cons", null);
  sdl_process_input_fifo_base fifo = new("fifo", null);

  initial begin
    prod.data_out.connect(fifo.put_export);
    prod1.data_out.connect(fifo.put_export);
    cons.data_in.connect(fifo.get_export);

    fork
      run_test();
      //repeat(30) begin
        //$display("%0t:   FIFO level %0d of %0d", $time, fifo.used(), fifo.size());
        //#10;
      //end
      #100 global_stop_request();
    join
  end
  
  
     
   
   
endmodule // test
	

	

/******************************************************************************
*
* REVISION HISTORY:
*    
*******************************************************************************/

