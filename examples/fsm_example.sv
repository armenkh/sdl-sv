//-----------------------------------------------------------------------------------------------
//   Copyright 2010-2011 Armen L. Khachatryan (armenkhl@gmail.com)
//   All Rights Reserved Worldwide
//
//   Licensed under the Apache License, Version 2.0 (the
//   "License"); you may not use this file except in
//   compliance with the License.  You may obtain a copy of
//   the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in
//   writing, software distributed under the License is
//   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
//   CONDITIONS OF ANY KIND, either express or implied.  See
//   the License for the specific language governing
//   permissions and limitations under the License.
//-----------------------------------------------------------------------------------------------

module test;


  `ifdef INCA
    `include "uvm.svh"
  `else
    import uvm_pkg::*;
  `endif

   `include "fsm_base.sv"


  //The packet to sent do FSM
  class packet;
    int i;
    function new(int v); i=v; endfunction
  endclass




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
    $display ("Packet i is: %d", local_p.i);      
    set_next_state("s2");
    this.m_fsm.i = this.m_fsm.i+2;
    $display ("FSM i is: %d", m_fsm.i);                
  endtask
 
   task s2_state::run();
     $display ("I am in s2");
     set_next_state("s1");
     m_fsm.i = m_fsm.i-3;
      $display ("FSM i is: %d", m_fsm.i);        
   endtask 

// Actual state machine

  class fsm #(type P=int) extends fsm_base#(P);

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
      set_initial_state(init_state);
    endfunction

    function void build();
      set_initial_state(init);
      set_states(s1);
      set_states(s2);
      super.build();
    endfunction

  endclass
  
  
  //The producer will generate the packets
  class producer extends uvm_component;
    
    uvm_put_port #(packet) data_out;
    
    function new(string name, uvm_component parent);
      super.new(name,parent);
      data_out = new("data_out", this);
    endfunction
    
    task run();
      packet p;
      #1 p=new(0);
      while(data_out.try_put(p)) begin 
        $display("%0t: put data %0d", $time, p.i);
        #10 p = new(p.i+1);
      end
    endtask

  endclass
  
  
  
  class consumer extends uvm_component;
  
    uvm_get_port #(packet) data_in;
    fsm #(packet) proc;
  
    function new(string name, uvm_component parent);
      super.new(name,parent);
      data_in = new("data_in", this);
      proc = new("process", this);
    endfunction
  
    task run();
      packet p;
      #100;  // fifo will fill up
      while(data_in.try_get(p)) begin
        $display("%0t: recieved data %0d", $time, p.i);
        proc.change_state(p);
        #10;
      end
    endtask
  endclass

  producer prod = new("prod", null);
  consumer cons = new("cons", null);
  uvm_tlm_fifo #(packet) fifo = new("fifo", null, 10);

  initial begin
    prod.data_out.connect(fifo.put_export);
    cons.data_in.connect(fifo.get_export);

    fork
      run_test();
      repeat(30) begin
        $display("%0t:   FIFO level %0d of %0d", $time, fifo.used(), fifo.size());
        #10;
      end
      #5us global_stop_request();
    join
  end

endmodule



  

/******************************************************************************
*
* REVISION HISTORY:
*    
*******************************************************************************/

