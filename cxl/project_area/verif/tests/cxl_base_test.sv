class cxl_base_test extends uvm_test;

  cxl_env      env_h; 

  `uvm_component_utils(cxl_base_test)

  function new(string name="cxl_base_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    env_h = cxl_env::type_id::create("env_h", this);

  endfunction:build_phase

  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_factory factory = uvm_factory::get();
    uvm_top.print_topology();
    factory.print();
  endfunction:end_of_elaboration_phase

endclass:cxl_base_test
