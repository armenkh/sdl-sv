/******************************************************************************
*
*                    Copyright 2010-2011 Dolak-NER Systems.
*                    All rights reserved worldwide.
*
*******************************************************************************/

`ifndef SDL_PKG_SVH
`define SDL_PKG_SVH

  `include "sdl_macros.svh"
  
package sdl_pkg;

  import uvm_pkg::*;
   `include "uvm_macros.svh"

  typedef class sdl_fsm_base;
  typedef class sdl_agent_base;	
  typedef class sdl_block_base;
  typedef class sdl_state_base;
  typedef class sdl_process_base;
  typedef class sdl_system_base;
  typedef class sdl_signal_base;
  typedef class sdl_process_input_fifo_base;  

  `include "sdl_base/sdl_base.svh"

	
endpackage : sdl_pkg

`endif





/******************************************************************************
*
* REVISION HISTORY:
*    
*******************************************************************************/
