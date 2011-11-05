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

module bitstuff_transmission;
    
  `ifdef INCA
    `include "uvm.svh"
    `include "sdl.svh"
  `else
    `include "uvm_macros.svh"
    import uvm_pkg::*;
    import sdl_svh::*;
  `endif

   
   //Defineing send_bits process stated
   `DEFINE_STATE(s_initial_state)
   `DEFINE_STATE(s_0_state)
   `DEFINE_STATE(s_00_state)
   `DEFINE_STATE(s_000_state)
   `DEFINE_STATE(s_0000_state)
   `DEFINE_STATE(s_1_state)
   `DEFINE_STATE(s_11_state)
   `DEFINE_STATE(s_111_state)
   `DEFINE_STATE(s_1111_state)

  task s_initial_state::run();
    //$display ("I am in s_initial_state....");
    //set_next_state("s_0");      
  endtask
  
  task s_0_state::run();
    //$display ("I am in s_initial_state....");
    //set_next_state("s_0");      
  endtask

  task s_00_state::run();
    //$display ("I am in s_initial_state....");
    //set_next_state("s_0");      
  endtask

  task s_000_state::run();
    //$display ("I am in s_initial_state....");
    //set_next_state("s_0");      
  endtask

  task s_0000_state::run();
    //$display ("I am in s_initial_state....");
    //set_next_state("s_0");      
  endtask
  
  task s_1_state::run();
    //$display ("I am in s_initial_state....");
    //set_next_state("s_0");      
  endtask

  task s_11_state::run();
    //$display ("I am in s_initial_state....");
    //set_next_state("s_0");      
  endtask
  
  task s_111_state::run();
    //$display ("I am in s_initial_state....");
    //set_next_state("s_0");      
  endtask
  
  task s_1111_state::run();
    //$display ("I am in s_initial_state....");
    //set_next_state("s_0");      
  endtask


	//Declaring first state machine
  class send_bits_fsm #(type P=int) extends sdl_fsm_base#(P);
  

    typedef send_bits_fsm#(P) this_fsm_type;
    
    s_initial_state   #(this_fsm_type, P) s_initial;
    s_0_state         #(this_fsm_type, P) s_0;
    s_00_state        #(this_fsm_type, P) s_00;
    s_000_state       #(this_fsm_type, P) s_000;
    s_0000_state      #(this_fsm_type, P) s_0000;
    s_1_state         #(this_fsm_type, P) s_1;
    s_11_state        #(this_fsm_type, P) s_11;
    s_111_state       #(this_fsm_type, P) s_111;
    s_1111_state      #(this_fsm_type, P) s_1111;
    
   `uvm_component_utils_begin(send_bits_fsm)
   `uvm_component_utils_end
	    

    int i  = 100;
      
    function new(string name, uvm_component parent);
      super.new(name,parent);
      s_initial   = new("s_initial",  this);
      s_0         = new("s_0",  this);
      s_00        = new("s_00",  this);
      s_000       = new("s_000",  this);
      s_0000      = new("s_0000",  this);
      s_1         = new("s_1",  this);
      s_11        = new("s_11",  this);
      s_111       = new("s_111",  this);
      s_1111       = new("s_1111",  this);
    endfunction

    function void build();
      set_initial_state(s_initial);
      set_states(s_0);
      set_states(s_00);
      set_states(s_000);
      set_states(s_0000);
      set_states(s_1);
      set_states(s_11);
      set_states(s_111);
      set_states(s_1111);
      super.build();
    endfunction

  endclass


  class send_bits extends sdl_process_base;
    
    send_bits_fsm fsm;
    
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    // build
    function void build();
      super.build();
      fsm = send_bits_fsm::type_id::create("send_bits_fsm", this);
    endfunction : build    
    
  
  endclass 
  
  
   send_bits_fsm t;
   
   //Defineing receive_bits process stated
   //`DEFINE_STATE(s_wait)
 
   
   initial begin
      t = new("Top", null);
   end
   
  
   initial
   run_test();
   
endmodule // test
	

	

/******************************************************************************
*
* REVISION HISTORY:
*    
*******************************************************************************/

