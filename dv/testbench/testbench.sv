import uvm_pkg::*;
`include "uvm_macros.svh"

`include "dut_if.sv"
`include "lib_test.sv"
`include "adc_dms_model.sv"

module top;
  dut_if dut_if();
  
  logic enable_tb;
  logic ready_tb;
  logic[7:0] q_tb;
  
  digital_top dut(
    .reset_n(dut_if.reset_n),
    .clk(dut_if.clk),
    .sclk(dut_if.sclk),
    .sdata(dut_if.sdata),
    .adc_convert(enable_tb),
    .adc_ready(ready_tb),
    .adc_q(q_tb)    
  );
  
  adc_dms_model adc(
    .clk(dut_if.clk),
    .rst_n(dut_if.reset_n),
    .v_in(dut_if.v_in),
    .v_ref(dut_if.v_ref),
    .enable(enable_tb),
    .data_ready(ready_tb),
    .adc_q(q_tb)
  );


  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    $shm_open("waves.shm");
    $shm_probe("ASM");

    // **** Quick non-UVM testbench ****
	
    // reset
    //#1000 rst_n_tb = 0;
    //#100 rst_n_tb = 1;

  end
  
  initial begin    
    //interface to database
    uvm_config_db#(virtual dut_if)::set(null, "*", "dut_if", dut_if);

    run_test(); //+UVM_TESTNAME=test_i2c_write
  end
  
    
endmodule : top
