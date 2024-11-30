`ifndef _CLK_DRV
`define _CLK_DRV

class clock_driver extends uvm_driver;
  
  int period_ns = 5; //100MHz
  `uvm_component_utils(clock_driver)

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
   
    
    
    dut_vif.clk = 0;

    forever begin
      fork
        forever begin
          #(period_ns*1ns);
          dut_vif.clk = ~dut_vif.clk; 

         
        end
      join_any;
      disable fork;
      
    end
  endtask : run_phase
 
endclass: clock_driver

`endif // _CLK_DRV
