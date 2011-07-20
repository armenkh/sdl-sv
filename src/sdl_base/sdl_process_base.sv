/******************************************************************************
*
*                    Copyright 2010-2011 Dolak-NER Systems.
*                    All rights reserved worldwide.
*
*******************************************************************************/

`ifndef PROCESS_BASE_SV
`define PROCESS_BASE_SV

`include "sdl_base/sdl_process_base.svh"


  function sdl_process_base::new(string name, uvm_component parent);
    super.new(name, parent);
    put_port = new("put_port", this);
    input_queue = new("input_queue", this);
    fsm = new("fsm", this);
  endfunction


`endif


/******************************************************************************
*
* REVISION HISTORY:
*    
*******************************************************************************/
