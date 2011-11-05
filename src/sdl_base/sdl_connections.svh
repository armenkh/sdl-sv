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

`ifndef SDL_CONNECTIONS_SVH
`define SDL_CONNECTIONS_SVH


virtual class sdl_if_base extends uvm_tlm_if_base #(sdl_signal_base, sdl_signal_base);

  virtual task put_signal( input sdl_signal_base t );
    uvm_report_error("put_signal", `SIG_FIFO_TASK_ERROR, UVM_NONE);
  endtask
  virtual task get_signal (output sdl_signal_base arg);
    uvm_report_error("get_signal", `SIG_FIFO_TASK_ERROR, UVM_NONE);
  endtask
  
  virtual function bit try_get_signal (output sdl_signal_base arg);
  	uvm_report_error("try_get_signal", `SIG_FIFO_FUNCTION_ERROR, UVM_NONE);
  endfunction
  
endclass

class sdl_put_imp #(type IMP=int)
  extends uvm_port_base #(sdl_if_base);
  `UVM_IMP_COMMON(`UVM_TLM_PUT_MASK,"sdl_put_imp",IMP)
  `PUT_IMP (m_imp, sdl_signal_base, t)
  task put_signal (input sdl_signal_base t); 
    m_imp.put_signal(t); 
  endtask  
endclass


class sdl_put_port extends uvm_port_base #(sdl_if_base);
  `UVM_PORT_COMMON(`UVM_TLM_PUT_MASK,"sdl_put_port")
  `PUT_IMP (this.m_if, sdl_signal_base, t)
  task put_signal (input sdl_signal_base t); 
    this.m_if.put_signal(t);
  endtask  
endclass


class sdl_get_imp #(type IMP=int)
  extends uvm_port_base #(sdl_if_base);
  `UVM_IMP_COMMON(`UVM_TLM_GET_PEEK_MASK,"uvm_get_peek_imp",IMP)
  `GET_PEEK_IMP (m_imp, sdl_signal_base, t)  
   task get_signal (output sdl_signal_base arg);
    m_imp.get_signal(arg); 
   endtask
   function bit try_get_signal (output sdl_signal_base arg);
     return m_imp.try_get_signal(arg);
   endfunction   
endclass


class sdl_get_port  extends uvm_port_base #(sdl_if_base);
  `UVM_PORT_COMMON(`UVM_TLM_GET_MASK,"uvm_get_port")
  `GET_IMP (this.m_if, sdl_signal_base, t)
   task get_signal (output sdl_signal_base arg); 
     this.m_if.get_signal(arg); 
   endtask  
   function bit try_get_signal (output sdl_signal_base arg);
     return this.m_if.try_get_signal(arg);
   endfunction   
endclass 




`endif


/******************************************************************************
*
* REVISION HISTORY:
*    
*******************************************************************************/
