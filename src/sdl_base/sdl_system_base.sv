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
