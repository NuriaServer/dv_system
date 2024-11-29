`include "agent_i2c.sv"
`include "agent_clock.sv"

class environment extends uvm_env;  
  `uvm_component_utils(environment)
  
  i2c_agent i2c_agt;
  //other agents
  clock_agent clk_agt;

  virtual dut_if dut_vif;
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
	
  function void build_phase(uvm_phase phase);
    i2c_agt = i2c_agent::type_id::create("i2c_agt", this);
	//create other agents?
   clk_agt = clock_agent::type_id::create("clk_agt", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    //interface from database 
    uvm_config_db#(virtual dut_if)::get(null, "*", "dut_if", dut_vif);
  endfunction
endclass : environment
