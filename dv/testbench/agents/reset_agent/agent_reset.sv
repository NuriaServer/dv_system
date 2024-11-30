`ifndef _RST_AGT
`define _RST_AGT
`include "driver_reset.sv"


//https://www.edaplayground.com/x/LmEd
class reset_agent extends uvm_agent;
  `uvm_component_utils(reset_agent)
    
  reset_driver driver;
      
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
    
  function void build_phase(uvm_phase phase);
  driver = reset_driver::type_id::create("rst_drv", this);
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
 
  endfunction : connect_phase
  
  task run_phase(uvm_phase phase);
  endtask : run_phase
endclass : reset_agent

`endif  // _RST_AGT