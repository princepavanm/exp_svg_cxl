class dl_cxl_agent_mon extends uvm_monitor;

  `uvm_component_utils(dl_cxl_agent_mon)

  dl_tx   tx_h;

  uvm_analysis_port #(dl_tx)       dl_cxl_agent_mon_port;

  function new(string name="dl_cxl_agent_mon", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    dl_cxl_agent_mon_port = new("dl_cxl_agent_mon_port", this);
    tx_h = dl_tx::type_id::create("tx_h", this);

  endfunction:build_phase

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("dl_cxl_agent_mon","Monitor Run Phase", UVM_LOW)

  endtask:run_phase

endclass:dl_cxl_agent_mon
