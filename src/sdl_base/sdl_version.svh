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

`ifndef SDL_VERSION_SVH
`define SDL_VERSION_SVH

  parameter string sdl_don_copyright = "(C) 2010-2011 Armen L. Khachatryan.";
  parameter string sdl_revision = `SDL_VERSION_STRING;

  function string sdl_revision_string();
    return sdl_revision;
  endfunction

  function string sdl_copyright_string();
    return sdl_don_copyright;
  endfunction

`endif // SDL_VERSION_SVH



/******************************************************************************
*
* REVISION HISTORY:
*    
*******************************************************************************/
