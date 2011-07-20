/******************************************************************************
*
*                    Copyright 2010-2011 Dolak-NER Systems.
*                    All rights reserved worldwide.
*
*******************************************************************************/

`ifndef SYSTEM_BASE_SV
`define SYSTEM_BASE_SV

class sdl_system_base extends sdl_agent_base;

/*
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
*/

  //The system is top component
  function new(string name);
    super.new(name, null);
  endfunction

 
endclass : sdl_system_base

`endif 


/******************************************************************************
*
* REVISION HISTORY:
*    
*******************************************************************************/
