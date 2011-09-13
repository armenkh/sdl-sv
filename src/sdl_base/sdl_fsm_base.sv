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

`ifndef SDL_FSM_BASE_SV
`define SDL_FSM_BASE_SV

  

//  sdl_state_base class extends uvm_object class
class sdl_state_base #(type P = sdl_signal_base) extends uvm_object;

//It has parameterized sdl_fsm_base type member: m_fsm.
//The sdl_fsm_base is the base EFSM class.
  typedef sdl_fsm_base#(P) this_fsm_base;
  this_fsm_base m_fsm;

// With the new constructor we will pass actual EFSM object to
// the state class that can use state machine methods and members.
  function new(string name = "", this_fsm_base f);
    super.new(name);
    $cast(m_fsm, f);
  endfunction

// The set_next_state function will set EFMS m_current_state
// base state class handler to the corresponding extended state class object.
  function void set_next_state (string state_name);
    `sdl_info($psprintf("FSM changes state to: %s", state_name),UVM_LOW)
    m_fsm.m_current_state = m_fsm.m_system_states[state_name];
  endfunction

// The send_signal task will get signal object from the
// associative array and send to output thought EFSM put_port.
  task send_signal(string signal_name);
    `sdl_info($psprintf("FSM sends signal: %s", signal_name),UVM_LOW)
    m_fsm.put_port.put_signal(m_fsm.m_system_signals[signal_name]);
  endtask

// The run task will be implemented in the extended classes.
  virtual task run();
  endtask

endclass

//Parametrized with actual EFSM class
class sdl_state #(type fsm = int, type p = sdl_signal_base)
                       extends sdl_state_base#(p);

  protected fsm m_fsm;
  // Constructor will pass the actual EFSM object to supper class
  function new(string name = "", fsm f);
    super.new(name,f);
    m_fsm = f;
  endfunction

endclass
 
  
  
// The EFSM base class extends uvm_component and parametrized
// with sdl_signal base

class sdl_fsm_base #(type P = sdl_signal_base)
                             extends uvm_component;

// Defining sdl_state_base parametrized type with certain
// sdl_signal_base type
  typedef sdl_state_base#(P) this_state_base;

// Declaring current state
  this_state_base m_current_state;

// Declaring associative dynamic array to get  state object by name
  this_state_base m_system_states [string];

// This will store current signal that state machine should process
  P m_current_event;

// Declaring associative dynamic array to get  signal object by name
  P m_system_signals[string];

//Declaring get_port to get signals from process signal queue
//sdl_get_port implantation will be discussed in next post

  sdl_get_port get_port;

// Declaring put_portto send signals
// sdl_put_port implantation will be discussed in next post
  sdl_put_port put_port;

// UVM staff
`uvm_component_utils_begin(sdl_fsm_base)
`uvm_component_utils_end

// Constructor will create port objects
  function new(string name, uvm_component parent);
    super.new(name,parent);
    get_port = new("get_port", this);
    put_port = new("put_port", this);
   endfunction

// The function will register the state object with system_states that
// can by fetched by name. All EFSM states should be registered.
  function void register_state (this_state_base st);
    string name = st.get_name();
    m_system_states[name]= st;
    `sdl_info($psprintf("State: %s, has been registered.", name),UVM_LOW)
  endfunction

// This function will set initial state
  function void set_initial_state (this_state_base st);
    m_current_state = st;
  endfunction
  
// The function will register the signal object with m_system_signalsthat
// can by fetched by name. All signals those EFSM can send should be
// registered.
  function void register_signal (P sig);
    string name = sig.get_name();
    m_system_signals[name]= sig;
    `sdl_info($psprintf("Signal: %s, has been registered.", name),UVM_LOW)
  endfunction

// The change_state task will be called every time when EFSM gets new signal
// It will update m_current_event and call current state run() function
  task change_state (P p);
    m_current_event = p;
    m_current_state.run();
  endtask

// UVM run_phase
  task run_phase(uvm_phase phase);
    sdl_signal_base temp_signal;
    P current_signal;
    string signal_name;
    // Trying to get signal from process queue
    // Implementation is temporary
    while(1) begin
      if (get_port.try_get_signal(temp_signal)) begin
      $cast(current_signal, temp_signal);
      signal_name = current_signal.get_name();
      `sdl_info($psprintf("FSM got new signal: %s", signal_name),UVM_LOW)
      change_state(current_signal);
      end
      #1;
    end
  endtask

endclass

`define DEFINE_SDL_STATE(STATE_NAME) class STATE_NAME \
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
 
    