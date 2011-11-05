module fsm_test;

// Importing UVM and SDL packages

import uvm_pkg::*;
import sdl_pkg::*;

/********************************************************/
/********************************************************/
/********************************************************/
//Declaring signal by extending sdl_signal_base class

//The ConnectRequest signal
  class ConnectRequest_sig extends sdl_signal_base;
    function new(string name, uvm_component initiator = null);
      super.new (name, initiator);
    endfunction
  endclass

//The ConnectRequestAck signal
  class ConnectRequestAck_sig extends sdl_signal_base;
    function new(string name, uvm_component initiator = null);
      super.new (name, initiator);
    endfunction
  endclass

//The Query signal
class Query_sig extends sdl_signal_base;
//The signal has two parameters
  int value1;
  int value2;
  function new(string name, uvm_component initiator = null);
    super.new (name, initiator);
  endfunction
//Setting parameters values
  function void set_values(int v1, int v2);
    this.value1 = v1;
    this.value2 = v2;
  endfunction
endclass

//The Result signal
class Result_sig extends sdl_signal_base;
//Has one parameter
  int sum;
  function new(string name, uvm_component initiator = null);
    super.new (name, initiator);
  endfunction
//Setting parameter value
  function set_values(int sum);
    this.sum = sum;
  endfunction
endclass

/********************************************************/
/********************************************************/
/********************************************************/
//Defining EFSM states

//Using macro to declare WaitConReq state class
`DEFINE_SDL_STATE(WaitConReq_state)

//Defining state run function for WaitConReq state
task WaitConReq_state::run();
// In this state we should send ConnectRequestAck and go
// to WaitQuery state.
  send_signal("ConnectRequestAck");
  set_next_state("WaitQuery");
endtask

//Using macro to declare WaitQuery state class
`DEFINE_SDL_STATE(WaitQuery_state)

//Defining state run function for WaitQuery state
task WaitQuery_state::run();
//Getting signal
//Some checkers should be added here
  Query_sig Query;
  $cast(Query,m_fsm.m_current_event);

//Updating parameters
  m_fsm.value1 = Query.value1;
  m_fsm.value2 = Query.value2;

//Calling sum task and updating values
  m_fsm.calculate_sum();
  m_fsm.Result.set_values(m_fsm.sum);
//Sending signal Result and changing state to WaitConReq
  send_signal("Result");
  set_next_state("WaitConReq");
endtask

/********************************************************/
/********************************************************/
/********************************************************/
// Actual state machine implementation
// Declaring "Server" EFSM by extending
// sdl_fsm_base class

class server extends sdl_fsm_base;

// Declaring States
  WaitConReq_state #(server) WaitConReq;
  WaitQuery_state #(server) WaitQuery;

//Declaring signal that state machine should send out
  ConnectRequestAck_sig ConnectRequestAck;
  Result_sig Result;

//Declaring EFSM local parameters
  integer sum, value1, value2;

// Class constructor
  function new(string name, uvm_component parent);
    super.new(name,parent);
  // Initializing states and sygnals
    WaitConReq = new("WaitConReq", this);
    WaitQuery = new("WaitQuery", this);
    ConnectRequestAck = new("ConnectRequestAck", this);
    Result = new("Result", this);
  endfunction

//During UVM build_phase we will register states and signals
//as well as we should set initial state
  function void build_phase(uvm_phase phase);
  //Setting initial state
    set_initial_state(WaitConReq);
  //Registering States with EFSM
    register_state(WaitConReq);
    register_state(WaitQuery);
  //Registering sygnals
    register_signal(ConnectRequestAck);
    register_signal(Result);
    super.build_phase(phase);
  endfunction

//The task to calculate sum of parameters
  function void calculate_sum;
    this.sum = this.value1 + this.value2;
  endfunction

endclass

//Test environment
 
  class env extends uvm_env;

//The server state machine declaration
  server server_i;
//environment ports for sending/receiving signals to/from server
  sdl_put_port data_out;
  sdl_get_port data_in;

// We will use sdl fifos to connect environment to EFSM
// See corresponding posts about sdl fifos and comunications
  sdl_process_input_fifo_base inf;
  sdl_process_input_fifo_base out;

//Declaring signals
  ConnectRequest_sig ConnectRequest;
  Query_sig Query;
  Result_sig Result;
  sdl_signal_base temp_signal;

//The constructor will create environment ports, EFSM and sdl fifos
  function new (string name="env", uvm_component parent=null);
    super.new(name,parent);
    data_out = new("data_out", parent);
    data_in = new("data_in", parent);
    server_i = new ("server", parent);
    inf = new ("inf", parent);
    out = new("out", parent);
  endfunction

//UVM run_phase
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    // 1. Environment sends ConnectRequest to server
    ConnectRequest = new("ConnectRequest", this);
    data_out.put_signal(ConnectRequest);

    //2. Environment waits for ConnectRequestAck
    data_in.get_signal(temp_signal);
    if( temp_signal.get_name() != "ConnectRequestAck") begin
      `sdl_error ($psprintf("Env got wrong signal: %s", temp_signal.get_name()))
      $finish;
    end
    `sdl_info($psprintf("Env got: %s", temp_signal.get_name()),UVM_LOW)

    // 3. Environment sends the Query
    Query = new("Query", this);
    Query.set_values(2, 3);
    `sdl_info($psprintf("CLIENT Sends: %d, %d", 2,3),UVM_LOW)
    data_out.put_signal(Query);

    // 4. Environment waits for Result
    data_in.get_signal(temp_signal);
    if( temp_signal.get_name() != "Result") begin
      `sdl_error ($psprintf("Env got wrong signal: %s", temp_signal.get_name()))
      $finish;
    end
    `sdl_info($psprintf("Env got: %s", temp_signal.get_name()),UVM_LOW)
    $cast(Result,temp_signal);
    `sdl_info($psprintf("SERVER Returns: %d", Result.sum),UVM_LOW)
    phase.drop_objection(this);
  endtask

//UVM connect_phase
  function void connect_phase(uvm_phase phase);
  //Connecting EFSM to environment ports
    server_i.get_port.connect(inf.get_export);
    data_out.connect(inf.put_export);
    server_i.put_port.connect(out.put_export);
    data_in.connect(out.get_export);

  endfunction : connect_phase

endclass
  
  env e = new("env", null);  
  initial begin
     run_test();
  end
     

endmodule
