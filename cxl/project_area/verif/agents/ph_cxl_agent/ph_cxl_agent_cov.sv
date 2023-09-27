class ph_cxl_agent_cov extends uvm_subscriber#(ph_tx);

  `uvm_component_utils(ph_cxl_agent_cov)

  uvm_analysis_imp#(ph_tx, ph_cxl_agent_cov)       ph_cxl_agent_cov_port;

  ph_tx   tx_h;

  covergroup cg();

    // Implement Cover bins here

  endgroup:cg

  function new(string name="ph_cxl_agent_cov", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ph_cxl_agent_cov_port = new("ph_cxl_agent_cov_port", this);
    tx_h = ph_tx::type_id::create("tx_h", this);
  endfunction:build_phase

  function void write(ph_tx   t);

    `uvm_info("ph_cxl_agent_COV", "From Coverage Write function", UVM_LOW)

  endfunction:write

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("ph_cxl_agent_COV","From Coverage Run Phase", UVM_LOW)

  endtask:run_phase

endclass:ph_cxl_agent_cov
