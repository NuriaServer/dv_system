class test_i2c_write extends base_test;
  `uvm_component_utils(test_i2c_write)
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    i2c_basic_seq seq;
    phase.raise_objection(this);
    `uvm_info(get_name(), "  ** TEST I2C WRITE **", UVM_LOW)


    // **** TEST STARTS HERE ****
  
    this.wait_reset();
  
    // I2C read to know previous value
    seq = i2c_basic_seq::type_id::create("seq");
    seq.i2c_addr = 0; // FIR_COEF_0
    //seq.i2c_data = 0;
    seq.i2c_read = 1; // Knowing that is inverted
    seq.start(env.i2c_agt.m_sequencer);

    #(1000*1ns);
    seq.i2c_addr = 0; // FIR_COEF_0
    //seq.i2c_data = 0;
    seq.i2c_read = 1; // Knowing that is inverted
    seq.start(env.i2c_agt.m_sequencer);

    #(1000*1ns);
    seq.i2c_addr = 0; // FIR_COEF_0
    //seq.i2c_data = 0;
    seq.i2c_read = 1; // Knowing that is inverted
    seq.start(env.i2c_agt.m_sequencer);

    // I2C reads are unstable!!!

    ///////////////////////////////////////////////

    // I2C write
    #(1000*1ns);
    seq.i2c_addr = 0;
    seq.i2c_data = 8'hBE;
    seq.i2c_read = 0;
    seq.start(env.i2c_agt.m_sequencer);

    ///////////////////////////////////////////////

    // I2C read to assert
    #(1000*1ns);
    seq.i2c_addr = 0;
    //seq.i2c_data = 0;
    seq.i2c_read = 1;
    seq.start(env.i2c_agt.m_sequencer);

    // We don't recover expected value!!!


    ///////////////////////////////////////////////

    // TODO: implement sequencer on reset_agent
    env.dut_vif.reset_n = 0;
    #(100*1ns);
    env.dut_vif.reset_n = 1;

    // I2C read to assert
    #(1000*1ns);
    seq.i2c_addr = 0;
    //seq.i2c_data = 0;
    seq.i2c_read = 1;
    seq.start(env.i2c_agt.m_sequencer);

    // Reset works, register returns to default value


    // **** TEST ENDS HERE ****

    
 	phase.drop_objection(this);
  endtask
endclass : test_i2c_write
