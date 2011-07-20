/******************************************************************************
*
*                    Copyright 2010-2011 Dolak-NER Systems.
*                    All rights reserved worldwide.
*
*******************************************************************************/

`ifndef PROCESS_BASE_SVH
`define PROCESS_BASE_SVH

class sdl_process_base #(type FSM=sdl_fsm_base) extends sdl_agent_base;

  typedef sdl_process_base#(FSM) this_sdl_process_base;
  
  // Declaring input put port 
  sdl_put_port put_port;
  // Declaring input queue
  sdl_process_input_fifo_base input_queue;
  // Declaring process state machine
  FSM fsm;
  
  extern function new(string name, uvm_component parent);
  
  function void connect ();
    fsm.get_port.connect(input_queue.get_export);
    put_port.connect(input_queue.put_export);
  endfunction  

endclass : sdl_process_base


`endif



/******************************************************************************
*
* REVISION HISTORY:
*    
*******************************************************************************/
