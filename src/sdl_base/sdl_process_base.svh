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
