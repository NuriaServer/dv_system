`ifndef _CLK_AGT
`define _CLK_AGT
`include "driver_clock.sv"


//https://www.edaplayground.com/x/LmEd
class clock_agent extends uvm_agent;
  `uvm_component_utils(clock_agent)
    
  clock_driver driver;
      
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
    
  function void build_phase(uvm_phase phase);
  driver = clock_driver::type_id::create("clk_drv", this);
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
 
  endfunction : connect_phase
  
  task run_phase(uvm_phase phase);
  endtask : run_phase
endclass : clock_agent

`endif  // _CLK_AGT