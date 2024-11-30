`ifndef _RST_DRV
`define _RST_DRV

class reset_driver extends uvm_driver;
  
  int reset_duration_ns = 1000; // 100 clock cycles (100 MHz)
  
  `uvm_component_utils(reset_driver)

  virtual dut_if dut_vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
  endfunction : build_phase
  
  function void connect_phase(uvm_phase phase);
    assert(uvm_config_db#(virtual dut_if)::get(this, "", "dut_if", dut_vif));  
  endfunction

  task run_phase(uvm_phase phase);
   
    
    
    dut_vif.reset_n = 0;

  //   forever begin
  //     fork
  //         dut_vif.reset_n = 0;
  //         #(reset_duration_ns*1ns);
  //         dut_vif.reset_n = 1;
          
         
  //     join_any;
  //     disable fork;
      
  //   end
  // endtask : run_phase
 
   begin
              
           dut_vif.reset_n = 0;
           #(reset_duration_ns*1ns);
           dut_vif.reset_n = 1;
           #(reset_duration_ns*1ns);
      
    end
  endtask : run_phase
endclass: reset_driver

`endif // _RST_DRV
