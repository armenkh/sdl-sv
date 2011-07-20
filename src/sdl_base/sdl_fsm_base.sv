/******************************************************************************
*
*                    Copyright 2010-2011 Dolak-NER Systems.
*                    All rights reserved worldwide.
*
*******************************************************************************/

`ifndef FSM_BASE_SV
`define FSM_BASE_SV

  

  class sdl_state_base #(type P = sdl_signal_base) extends uvm_object;
  
    typedef sdl_fsm_base#(P) this_fsm_base; 
    this_fsm_base m_fsm;

    function new(string name = "", this_fsm_base f);
      super.new(name);
      $cast(m_fsm, f);
    endfunction

    function void set_next_state (string state_name);
      m_fsm.m_current_state = m_fsm.m_system_states[state_name]; 
    endfunction

    virtual task run();
    endtask

  endclass

  class sdl_state #(type fsm = int, type p = sdl_signal_base) extends sdl_state_base#(p);
    
    protected static fsm m_fsm; 
    
    function new(string name = "", fsm f);
      super.new(name,f);
      m_fsm = f;
    endfunction 
    
  endclass  
  
  class sdl_fsm_base #(type P = sdl_signal_base)  extends uvm_component;

    typedef sdl_state_base#(P) this_state_base;  
    this_state_base            m_current_state;
    this_state_base            m_system_states [string];
    P                          m_current_event;

    sdl_get_port               get_port;

   `uvm_component_utils_begin(sdl_fsm_base)
   `uvm_component_utils_end
	    

    function new(string name, uvm_component parent);
      super.new(name,parent);
      get_port = new("get_port", this);
    endfunction

    function void set_states (this_state_base st);
      string name = st.get_name();
      m_system_states[name]= st;
      $display("State: %s, has been registered.", name);
    endfunction

    function void set_initial_state (this_state_base st);
      m_current_state = st;
    endfunction

    task change_state (P p);
        m_current_event = p;
        m_current_state.run();
    endtask
        
    task run_phase(uvm_phase phase);
      sdl_signal_base temp_signal;
      P               current_signal;
      string          signal_name;      
      while(1) begin
        if (get_port.try_get_signal(temp_signal)) begin
          $cast(current_signal, temp_signal);
          //change_state(current_signal);
          signal_name = current_signal.get_name();
          `sdl_info($psprintf("FSM got new signal: %s", signal_name),UVM_LOW)
          change_state(current_signal);
        end
        #1;
      end    	      
    endtask    
   
   
  endclass


`define DEFINE_STATE(STATE_NAME) class STATE_NAME \
      #(type FSM = int, type P = sdl_signal_base) extends sdl_state#(FSM,P); \
      function new(string name = `"STATE_NAME`", FSM f); \
        super.new(name,f); \
      endfunction \
      extern task run(); \
    endclass




`endif    

/******************************************************************************
*
* REVISION HISTORY:
*    
*******************************************************************************/
 
    
   