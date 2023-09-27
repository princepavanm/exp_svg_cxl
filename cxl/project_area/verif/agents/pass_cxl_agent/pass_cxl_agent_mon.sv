class pass_cxl_agent_mon extends uvm_monitor;

  `uvm_component_utils(pass_cxl_agent_mon)

 // pass_tx   tx_h;


  function new(string name="pass_cxl_agent_mon", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

   // tx_h = pass_tx::type_id::create("tx_h", this);

  endfunction:build_phase

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("pass_cxl_agent_mon","Monitor Run Phase", UVM_LOW)

  endtask:run_phase

endclass:pass_cxl_agent_mon
