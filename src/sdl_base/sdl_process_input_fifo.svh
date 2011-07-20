/******************************************************************************
*
*                    Copyright 2010-2011 Dolak-NER Systems.
*                    All rights reserved worldwide.
*
*******************************************************************************/

`ifndef SDL_PROCESS_INPUT_FIFO_SVH
`define SDL_PROCESS_INPUT_FIFO_SVH


`define SIG_FIFO_TASK_ERROR "fifo channel task not implemented"
`define SIG_FIFO_FUNCTION_ERROR "fifo channel function not implemented"


class sdl_process_input_fifo_base extends uvm_component;

  

 // Port: put_export
  //
  // The ~put_export~ provides both the blocking and non-blocking put interface
  // methods to any attached port:
  //
  //|  task put (input T t)
  //|  function bit can_put ()
  //|  function bit try_put (input T t)


  //sdl_put_imp #(sdl_signal_base, sdl_process_input_fifo_base) put_export;
  sdl_put_imp #(sdl_process_input_fifo_base) put_export;
  

  // Port: get_peek_export
  //
  // The ~get_peek_export~ provides all the blocking and non-blocking get and peek
  // interface methods:
  //
  //|  task get (output T t)
  //|  function bit can_get ()
  //|  function bit try_get (output T t)
  //|  task peek (output T t)
  //|  function bit can_peek ()
  //|  function bit try_peek (output T t)


  //uvm_get_peek_imp #(sdl_signal_base, sdl_process_input_fifo_base) get_peek_export;
  sdl_get_imp #(sdl_process_input_fifo_base) get_export;
  
  
  local sdl_signal_base m_signal_queue[$];
  
  // Function: new
  //
  // Creates a new fifo object. The name is the instance name of the
  // fifo. If not supplied, then the object is unnamed.
  
  extern function new(string name = "", uvm_component parent = null);    


  // Function: get_signal
  //
  // 
  // First much priority signal from input array will be returned.
  // If no much, current signal will be saved if it is from save_signals list 
  // and next signal will be returned.
  // Else current signal will be returned  
  //extern task  get_signal (output sdl_signal_base s,
  //						   input sdl_signal_base priority_signals [],
  //						   input sdl_signal_base save_signals []
  //						   );
  extern task get_signal (output sdl_signal_base arg);
  
  extern function bit try_get_signal (output sdl_signal_base arg);
  
  // Function: put_signal
  //
  // 
  // The signal will be placed at the end of queue  
  extern task  put_signal (input sdl_signal_base t);


  // Function: size
  //
  // 
  // The size() method returns the number of items in the queue.
    
   extern function int size();


  virtual task put(sdl_signal_base t);
    uvm_report_error("put", `SIG_FIFO_TASK_ERROR, UVM_NONE);
  endtask

  virtual function bit try_put(sdl_signal_base t);
    uvm_report_error("try_put", `SIG_FIFO_FUNCTION_ERROR, UVM_NONE);
    return 0;
  endfunction

  virtual function bit can_put();
    uvm_report_error("can_put", `SIG_FIFO_FUNCTION_ERROR, UVM_NONE);
    return 0;
  endfunction


  virtual task get(output sdl_signal_base  t);
    uvm_report_error("get", `SIG_FIFO_TASK_ERROR, UVM_NONE);
  endtask

  virtual task peek(output sdl_signal_base  t);
    uvm_report_error("peek", `SIG_FIFO_TASK_ERROR, UVM_NONE);
  endtask
  
  virtual function bit try_get(output sdl_signal_base  t);
    uvm_report_error("try_get", `SIG_FIFO_FUNCTION_ERROR, UVM_NONE);
    return 0;
  endfunction

  virtual function bit try_peek(output sdl_signal_base  t);
    uvm_report_error("try_peek", `SIG_FIFO_FUNCTION_ERROR, UVM_NONE);
    return 0;
  endfunction
  
  virtual function bit can_get();
    uvm_report_error("can_get", `SIG_FIFO_FUNCTION_ERROR, UVM_NONE);
    return 0;
  endfunction

  virtual function bit can_peek();
    uvm_report_error("can_peek", `SIG_FIFO_FUNCTION_ERROR, UVM_NONE);
    return 0;
  endfunction


endclass : sdl_process_input_fifo_base


`endif

/******************************************************************************
*
* REVISION HISTORY:
*    
*******************************************************************************/
