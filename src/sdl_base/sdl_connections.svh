/******************************************************************************
*
*                    Copyright 2010-2011 Dolak-NER Systems.
*                    All rights reserved worldwide.
*
*******************************************************************************/


`ifndef SDL_CONNECTIONS_SVH
`define SDL_CONNECTIONS_SVH


virtual class sdl_if_base extends uvm_tlm_if_base #(sdl_signal_base, sdl_signal_base);

  virtual task put_signal( input sdl_signal_base t );
    uvm_report_error("put_signal", `TASK_ERROR, UVM_NONE);
  endtask
  virtual task get_signal (output sdl_signal_base arg);
    uvm_report_error("get_signal", `TASK_ERROR, UVM_NONE);
  endtask
  
  virtual function bit try_get_signal (output sdl_signal_base arg);
  	uvm_report_error("try_get_signal", `FUNCTION_ERROR, UVM_NONE);
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
