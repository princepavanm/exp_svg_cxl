class ph_cxl_agent_mon extends uvm_monitor;

  `uvm_component_utils(ph_cxl_agent_mon)

  ph_tx   tx_h;

  uvm_analysis_port #(ph_tx)       ph_cxl_agent_mon_port;

  function new(string name="ph_cxl_agent_mon", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    ph_cxl_agent_mon_port = new("ph_cxl_agent_mon_port", this);
    tx_h = ph_tx::type_id::create("tx_h", this);

  endfunction:build_phase

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("ph_cxl_agent_mon","Monitor Run Phase", UVM_LOW)

  endtask:run_phase

endclass:ph_cxl_agent_mon
