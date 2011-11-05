/******************************************************************************
*
*                    Copyright 2010-2011 Dolak-NER Systems.
*                    All rights reserved worldwide.
*
*******************************************************************************/




module basic_test;
    
//`ifdef INCA
    //`include "uvm.sv"
    //`include "sdl.svh"
  //`else
   import uvm_pkg::*;    
   import sdl_pkg::*;
  //`endif


  //The packet to sent do FSM
  class packet extends sdl_signal_base;
    int i;
    
    function new(string name, int v); 
        super.new (name, null);
    	i=v; 
    endfunction
    
  endclass
  
  class block1 extends sdl_block_base;
    
    sdl_put_port  data_out;
    packet p;
    
    function new(string name, uvm_component parent);
      super.new(name,parent);
      data_out = new("data_out", parent);
      
    endfunction

    task run_phase(uvm_phase phase);
      //phase.raise_objection(this);
      `uvm_info("component", "hello out there!", UVM_LOW)
      p = new("p0",0);
      data_out.put_signal(p);
      #1
      p = new("p1",1);
      data_out.put_signal(p);
       #1
      p = new("p0",3);
      data_out.put_signal(p);
       #1
      p = new("p1",4);
      data_out.put_signal(p);
       #1
      p = new("p0",5);
      data_out.put_signal(p);

      //phase.drop_objection(this);
    endtask

    
    //task run_phase();
      //packet p;
      //#1 p=new(0);
      //while(data_out.try_put(p)) begin 
        //$display("%0t: put data %0d", $time, p.i);
        //#10 p = new(p.i+1);
      //end
    //endtask
    
  endclass
  
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////

//Defining 3 states
    
  `DEFINE_STATE(init_state) 
  `DEFINE_STATE(s1_state) 
  `DEFINE_STATE(s2_state)     
     
//Defining state run functions 

  task init_state::run();
    $display ("I am in init....");
    set_next_state("s1");      
  endtask
  
  task s1_state::run();
    packet local_p;
    $cast(local_p, m_fsm.m_current_event);
    $display ("I am in s1...");
    `sdl_info($psprintf("STATE got signal: %s", local_p.get_name()),UVM_LOW)
    $display ("Packet i is: %d", local_p.i);      
    set_next_state("s2");
    //this.m_fsm.i = this.m_fsm.i+2;
    //$display ("FSM i is: %d", m_fsm.i);                
  endtask
 
   task s2_state::run();
     $display ("I am in s2");
     set_next_state("s1");
     //m_fsm.i = m_fsm.i-3;
     // $display ("FSM i is: %d", m_fsm.i);        
   endtask 

// Actual state machine

  class fsm #(type P=sdl_signal_base) extends sdl_fsm_base#(P);

    typedef fsm#(P) this_fsm_type;
    
    s1_state   #(this_fsm_type, P) s1;
    s2_state   #(this_fsm_type, P) s2;
    init_state #(this_fsm_type, P) init;

    int i  = 100;
      
    function new(string name, uvm_component parent);
      super.new(name,parent);
      s1   = new("s1",  this);
      s2   = new("s2",  this);
      init = new("init",this);
    endfunction

    function void build();
      set_initial_state(init);
      set_states(s1);
      set_states(s2);
      super.build();
    endfunction

  endclass
  
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
  
  class env extends uvm_env;
    
    block1  b1;
    typedef fsm #(packet) this_sdl_fsm;
    sdl_process_base #(this_sdl_fsm) proc;
      
    
    function new (string name="env", uvm_component parent=null);
      super.new(name,parent);
      b1    = new("block1", null);
      proc  = new ("proc", null);
    endfunction
     
    task run_phase(uvm_phase phase);
       phase.raise_objection(this);
       #100  ;
       phase.drop_objection(this);
    endtask
    
    
    function void connect_phase(uvm_phase phase);
      b1.data_out.connect(proc.put_port);
    endfunction : connect_phase  
      
  endclass
  
  sdl_agent_base   a              = new ("a", null);
  sdl_block_base   b              = new ("b", null);
  sdl_process_input_fifo_base inf = new ("inf", null); 
  sdl_signal_base s               = new ("s", null);
  env             e               = new("env", null);
  
  
  
  
  //initial begin
      
      
      //packet p;
      //100;  // fifo will fill up
      //p = new("p1",0);
      //proc.put_port.put_signal(p);
      
      //while(data_in.try_get(p)) begin
      //  $display("%0t: recieved data %0d", $time, p.i);
      // proc.change_state(p);
      //  #10;
      //end
       
 // end
  

  initial begin
    run_test();
  end  
  
     
   
endmodule  
/******************************************************************************
*
* REVISION HISTORY:
*    
*******************************************************************************/
