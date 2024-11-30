class test_i2c_read extends base_test;
  `uvm_component_utils(test_i2c_read)
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    i2c_basic_seq seq;
    phase.raise_objection(this);
    `uvm_info(get_name(), "  ** TEST I2C READ **", UVM_LOW)


    // **** TEST STARTS HERE ****
  
    this.wait_reset();
  
    // I2C read
    seq = i2c_basic_seq::type_id::create("seq");
    seq.i2c_addr = 5;
    //seq.i2c_data = 0;

    // Esta negado 
    // read -> 0 pero ponemos 1 (1 segun el estandar i2c)
    // write -> 1 pero ponemos 0 (0 segun el estandar i2c)
    seq.i2c_read = 0;
    seq.start(env.i2c_agt.m_sequencer);

    // It seems that this read transaction fails
    // We test inverting WR bit

    ///////////////////////////////////////////////
    #(1000*1ns);
    seq.i2c_addr = 5;
    seq.i2c_read = 1;
    seq.start(env.i2c_agt.m_sequencer);

    // Now we recover chip ID correctly
    // I2C RW bit is inverted!!! >:(

    // **** TEST ENDS HERE ****

    
 	phase.drop_objection(this);
  endtask
endclass : test_i2c_read
