/******************************************************************************
*
*                    Copyright 2010-2011 Dolak-NER Systems.
*                    All rights reserved worldwide.
*
*******************************************************************************/

`ifndef SDL_VERSION_SVH
`define SDL_VERSION_SVH

  parameter string sdl_don_copyright = "(C) 2010-2011 Dolak-NER Systems.";
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
