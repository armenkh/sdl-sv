/******************************************************************************
*
*                    Copyright 2010-2011 Dolak-NER Systems.
*                    All rights reserved worldwide.
*
*******************************************************************************/

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
    $display("GETTING SIGNAL START");
    while (this.size() == 0) #1;
    arg = m_signal_queue.pop_back();
    $display("GETTING SIGNAL END");
  endtask

  function bit sdl_process_input_fifo_base::try_get_signal (output sdl_signal_base arg);
    if (this.size() == 0)
    	return 0;
    arg = m_signal_queue.pop_back();
    $display("TRY GETTING SIGNAL");
    return 1;	 
  endfunction
  
  task  sdl_process_input_fifo_base::put_signal (input sdl_signal_base t);
  	m_signal_queue.push_front(t);
  	$display("PUTTING SIGNAL");
  endtask

`endif
/******************************************************************************
*
* REVISION HISTORY:
*    
*******************************************************************************/
