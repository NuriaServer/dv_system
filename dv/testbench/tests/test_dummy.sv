class test_dummy extends base_test;
  `uvm_component_utils(test_dummy)
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    i2c_basic_seq seq;
    phase.raise_objection(this);
    `uvm_info(get_name(), "  ** TEST **", UVM_LOW)


    // **** TEST STARTS HERE ****
  
    // Reset
    /*
    env.dut_vif.reset_n = 0;
    $display("Reset: %d", env.dut_vif.reset_n);
	  #100us;    
    env.dut_vif.reset_n = 1;
    $display("Reset: %d", env.dut_vif.reset_n);
	  #100us;

 
  
*/
    this.wait_reset();
  
    // I2C read
    seq = i2c_basic_seq::type_id::create("seq");
    seq.i2c_addr = 5;
    //seq.i2c_data = 0;
    seq.i2c_read = 1;
    seq.start(env.i2c_agt.m_sequencer);

    // **** TEST ENDS HERE ****

    
 	phase.drop_objection(this);
  endtask
endclass : test_dummy
