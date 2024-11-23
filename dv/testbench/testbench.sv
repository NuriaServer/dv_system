import uvm_pkg::*;
`include "uvm_macros.svh"

`include "dut_if.sv"
`include "lib_test.sv"
`include "adc_dms_model.sv"

module top;
  dut_if dut_if();
  
  digital_top dut(
    .reset_n(dut_if.reset_n),
    .clk(dut_if.clk),
    .sclk(dut_if.sclk),
    .sdata(dut_if.sdata),
    .adc_convert(dut_if.adc_convert),
    .adc_ready(dut_if.adc_ready),
    .adc_q(dut_if.adc_q)    
  );
  
  logic clk_tb = 0;
  logic rst_n_tb;
  real v_in_tb;
  real v_ref_tb = 5;
  logic enable_tb = 0;
  logic data_ready_tb;
  logic[7:0] adc_q_tb;

  adc_dms_model adc(
    .clk(clk_tb),
    .rst_n(rst_n_tb),
    .v_in(v_in_tb),
    .v_ref(v_ref_tb),
    .enable(enable_tb),
    .data_ready(data_ready_tb),
    .adc_q(adc_q_tb)
  );

  always begin
      #10 clk_tb = ~clk_tb;
  end
  
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    $shm_open("waves.shm");
    $shm_probe("ASM");

    // **** Quick non-UVM testbench ****
	
    // reset
    //#1000 rst_n_tb = 0;
    //#100 rst_n_tb = 1;

    // adc model test 0 V
    // expected adc_q_tb=0 when data_ready_tb=1
    //#200 v_in_tb = 0;
    //#200 enable_tb = 1;
    
    // adc model test 5 V
    // expected adc_q_tb=255 when data_ready_tb=1
    //#200 v_in_tb = 5;

    // adc model test 3 V
    // expected adc_q_tb=153 when data_ready_tb=1
    //#200 v_in_tb = 3;

    //#1000 $finish;

  end
  
  initial begin    
    //interface to database
    uvm_config_db#(virtual dut_if)::set(null, "*", "dut_if", dut_if);

    run_test(); //+UVM_TESTNAME=test_i2c_write
  end
  
    
endmodule : top
