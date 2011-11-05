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
