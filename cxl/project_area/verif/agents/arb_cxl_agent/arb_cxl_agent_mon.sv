class arb_cxl_agent_mon extends uvm_monitor;

  `uvm_component_utils(arb_cxl_agent_mon)

  arb_tx   tx_h;

  uvm_analysis_port #(arb_tx)       arb_cxl_agent_mon_port;

  function new(string name="arb_cxl_agent_mon", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    arb_cxl_agent_mon_port = new("arb_cxl_agent_mon_port", this);
    tx_h = arb_tx::type_id::create("tx_h", this);

  endfunction:build_phase

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("arb_cxl_agent_mon","Monitor Run Phase", UVM_LOW)

  endtask:run_phase

endclass:arb_cxl_agent_mon
