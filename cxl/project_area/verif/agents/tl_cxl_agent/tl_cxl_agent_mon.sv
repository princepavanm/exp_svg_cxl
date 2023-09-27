class tl_cxl_agent_mon extends uvm_monitor;

  `uvm_component_utils(tl_cxl_agent_mon)

  tl_tx   tx_h;

  uvm_analysis_port #(tl_tx)       tl_cxl_agent_mon_port;

  function new(string name="tl_cxl_agent_mon", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    tl_cxl_agent_mon_port = new("tl_cxl_agent_mon_port", this);
    tx_h = tl_tx::type_id::create("tx_h", this);

  endfunction:build_phase

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("tl_cxl_agent_mon","Monitor Run Phase", UVM_LOW)

  endtask:run_phase

endclass:tl_cxl_agent_mon
