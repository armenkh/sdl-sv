/******************************************************************************
*
*                    Copyright 2010-2011 Dolak-NER Systems.
*                    All rights reserved worldwide.
*
*******************************************************************************/

module bitstuff_transmission_top;

  import uvm_pkg::*;    
  import sdl_pkg::*;
  
  
/*****************************************************************/
/************************ Signals ********************************/
/*****************************************************************/  
  
  // Declaring signal zero
  class zero extends sdl_signal_base;
    
    function new(string name="zero"); 
        super.new (name);
    endfunction
    
  endclass : zero

  // Declaring signal one
  class one extends sdl_signal_base;
    
    function new(string name="one"); 
        super.new (name);
    endfunction
    
  endclass : one

/*****************************************************************/
/************************ Processes ******************************/
/*****************************************************************/
  
  class send_bits_fsm #(type P=sdl_signal_base) extends sdl_fsm_base#(P);

    typedef send_bits_fsm#(P) this_fsm_type;
    

//Declaring states 
//  s1_state   #(this_fsm_type, P) s1;
//  s2_state   #(this_fsm_type, P) s2;
//  init_state #(this_fsm_type, P) init;

    function new(string name, uvm_component parent);
      super.new(name,parent);
//    s1   = new("s1",  this);
//    s2   = new("s2",  this);
//    init = new("init",this);
    endfunction

    function void build();
//    set_initial_state(init);
//    set_states(s1);
//    set_states(s2);
      super.build();
    endfunction

  endclass : send_bits_fsm
  
  class send_bits_process extends sdl_process_base#(send_bits_fsm);
  
  // Provide implementations of virtual methods such as get_type_name and create
  `uvm_component_utils_begin(send_bits_process)
  `uvm_component_utils_end

    
    function new(string name="send_bits", uvm_component parent);
      super.new(name,parent);
    endfunction
    
  endclass  
  

  
  class receive_bits_fsm #(type P=sdl_signal_base) extends sdl_fsm_base#(P);

    typedef receive_bits_fsm#(P) this_fsm_type;
    

//Declaring states 
//  s1_state   #(this_fsm_type, P) s1;
//  s2_state   #(this_fsm_type, P) s2;
//  init_state #(this_fsm_type, P) init;

    function new(string name, uvm_component parent);
      super.new(name,parent);
//    s1   = new("s1",  this);
//    s2   = new("s2",  this);
//    init = new("init",this);
    endfunction

    function void build();
//    set_initial_state(init);
//    set_states(s1);
//    set_states(s2);
      super.build();
    endfunction

  endclass : receive_bits_fsm
  
  class receive_bits_process extends sdl_process_base#(receive_bits_fsm);
  
  // Provide implementations of virtual methods such as get_type_name and create
  `uvm_component_utils_begin(receive_bits_process)
  `uvm_component_utils_end

    
    function new(string name="receive_bits", uvm_component parent);
      super.new(name,parent);
    endfunction
    
  endclass  
    
  
	
  // System declaration		
  class  bitstuff_transmission_system extends sdl_system_base;

	send_bits_process    send_bits;
	receive_bits_process receive_bits;

    function new(string name="bitstuff_transmission");
      super.new(name);
    endfunction

    // build_phase
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      send_bits    = send_bits_process::type_id::create("send_bits", this);
      receive_bits = receive_bits_process::type_id::create("receive_bits", this);
    endfunction : build_phase    
     
  
  endclass :  bitstuff_transmission_system

  
  bitstuff_transmission_system  bitstuff_transmission;
  
  initial
    bitstuff_transmission = new(); 	 
  
  initial begin
    run_test();
  end  
  
endmodule

/******************************************************************************
*
* REVISION HISTORY:
*    
*******************************************************************************/
