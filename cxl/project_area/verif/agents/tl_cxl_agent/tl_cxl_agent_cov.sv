class tl_cxl_agent_cov extends uvm_subscriber#(tl_tx);

  `uvm_component_utils(tl_cxl_agent_cov)

  uvm_analysis_imp#(tl_tx, tl_cxl_agent_cov)       tl_cxl_agent_cov_port;

  tl_tx   tx_h;

  covergroup cg();

    // Implement Cover bins here

  endgroup:cg

  function new(string name="tl_cxl_agent_cov", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tl_cxl_agent_cov_port = new("tl_cxl_agent_cov_port", this);
    tx_h = tl_tx::type_id::create("tx_h", this);
  endfunction:build_phase

  function void write(tl_tx   t);

    `uvm_info("tl_cxl_agent_COV", "From Coverage Write function", UVM_LOW)

  endfunction:write

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("tl_cxl_agent_COV","From Coverage Run Phase", UVM_LOW)

  endtask:run_phase

endclass:tl_cxl_agent_cov
