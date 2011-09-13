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

`ifndef SDL_PROCESS_INPUT_FIFO_SV
`define SDL_PROCESS_INPUT_FIFO_SV

`include "sdl_base/sdl_process_input_fifo.svh"


  function sdl_process_input_fifo_base::new(string name = "", uvm_component parent = null);
    super.new(name, parent);
    put_export      = new("put_export", this);
    get_export      = new("get_peek_export", this);    
  endfunction

  function int sdl_process_input_fifo_base::size ();
  	return m_signal_queue.size();
  endfunction



  //task  sdl_process_input_fifo_base::get_signal (output sdl_signal_base s,
  //						   input sdl_signal_base priority_signals [],
  //						   input sdl_signal_base save_signals []);
  //endtask
  
  task sdl_process_input_fifo_base::get_signal (output sdl_signal_base arg);
    while (this.size() == 0) #1;
    arg = m_signal_queue.pop_back();
  endtask

  function bit sdl_process_input_fifo_base::try_get_signal (output sdl_signal_base arg);
    if (this.size() == 0)
    	return 0;
    arg = m_signal_queue.pop_back();
    return 1;	 
  endfunction
  
  task  sdl_process_input_fifo_base::put_signal (input sdl_signal_base t);
  	m_signal_queue.push_front(t);
  endtask

`endif
/******************************************************************************
*
* REVISION HISTORY:
*    
*******************************************************************************/
