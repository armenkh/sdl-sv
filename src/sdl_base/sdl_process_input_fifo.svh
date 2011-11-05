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

`ifndef SDL_PROCESS_INPUT_FIFO_SVH
`define SDL_PROCESS_INPUT_FIFO_SVH


class sdl_process_input_fifo_base extends uvm_component;

    // Port: put_export
  //
  // The ~put_export~ provides both the blocking and non-blocking put interface
  // methods to any attached port same ad in UVM uvm_tlm_fifo_base and one
  // additional method put_signal:
  //
  //|  task put (input T t)
  //|  function bit can_put ()
  //|  function bit try_put (input T t)
  //|  task put_signal (input sdl_signal_base t);
  

  
  sdl_put_imp #(sdl_process_input_fifo_base) put_export;
  

  // Port: get_export
  //
  // The ~get_peek_export~ provides all the blocking and non-blocking get and peek
  // interface methods like in UVM uvm_tlm_fifo_base and additional methods:
  // get_signal (same as get), try_get_signal and sdl_get_signal.
  //
    //| task get (output T t)
    //| function bit can_get ()
    //| function bit try_get (output T t)
    //| task peek (output T t)
    //| function bit can_peek ()
    //| function bit try_peek (output T t)
    //| task get_signal (output T t)
    //| function bit try_get_signal(output T t)
    //| task sdl_get_signal (output sdl_signal_base s,
                         // input sdl_signal_base priority_signals [],
                         // input sdl_signal_base save_signals []
                         // )

  sdl_get_imp #(sdl_process_input_fifo_base) get_export;
  
 
  // Actual queue declaration:
  // Queue is declared as  local so it is available only to 
  // methods inside the class. 
  
  local sdl_signal_base m_signal_queue[$];
  
  // Function: new
  //
  // Creates a new fifo object. The name is the instance name of the
  // fifo. If not supplied, then the object is unnamed.
  
  extern function new(string name = "", uvm_component parent = null);    

 // get_export port additional methods:
  extern task get_signal (output sdl_signal_base arg);
  extern function bit try_get_signal (output sdl_signal_base arg);
  extern task sdl_get_signal (output sdl_signal_base s,
                              input sdl_signal_base priority_signals [],
                             input sdl_signal_base save_signals []
                          );  
                          
  // get_export port standard methods:
  virtual task get(output sdl_signal_base  t);
    uvm_report_error("get", `SIG_FIFO_TASK_ERROR, UVM_NONE);
  endtask
  virtual function bit can_get();
    uvm_report_error("can_get", `SIG_FIFO_FUNCTION_ERROR, UVM_NONE);
    return 0;
  endfunction
  virtual function bit try_get(output sdl_signal_base  t);
    uvm_report_error("try_get", `SIG_FIFO_FUNCTION_ERROR, UVM_NONE);
    return 0;
  endfunction
  virtual task peek(output sdl_signal_base  t);
    uvm_report_error("peek", `SIG_FIFO_TASK_ERROR, UVM_NONE);
  endtask
  virtual function bit can_peek();
    uvm_report_error("can_peek", `SIG_FIFO_FUNCTION_ERROR, UVM_NONE);
    return 0;
  endfunction
  virtual function bit try_peek(output sdl_signal_base  t);
    uvm_report_error("try_peek", `SIG_FIFO_FUNCTION_ERROR, UVM_NONE);
    return 0;
  endfunction
 
  
  // put_export port additional methods:
  // The signal will be placed at the end of queue  
  extern task  put_signal (input sdl_signal_base t);
  
  // put_export port standard methods:
  virtual task put(sdl_signal_base t);
    uvm_report_error("put", `SIG_FIFO_TASK_ERROR, UVM_NONE);
  endtask
  virtual function bit can_put();
    uvm_report_error("can_put", `SIG_FIFO_FUNCTION_ERROR, UVM_NONE);
    return 0;
  endfunction
  virtual function bit try_put(sdl_signal_base t);
    uvm_report_error("try_put", `SIG_FIFO_FUNCTION_ERROR, UVM_NONE);
    return 0;
  endfunction
  
  // Usefull aditional methods
  //
  // Function: size
  //
  // 
  // The size() method returns the number of items in the queue.
    
   extern function int size();


endclass : sdl_process_input_fifo_base


`endif

/******************************************************************************
*
* REVISION HISTORY:
*    
*******************************************************************************/
