class dl_cxl_agent_cov extends uvm_subscriber#(dl_tx);

  `uvm_component_utils(dl_cxl_agent_cov)

  uvm_analysis_imp#(dl_tx, dl_cxl_agent_cov)       dl_cxl_agent_cov_port;

  dl_tx   tx_h;

  covergroup cg();

    // Implement Cover bins here

  endgroup:cg

  function new(string name="dl_cxl_agent_cov", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    dl_cxl_agent_cov_port = new("dl_cxl_agent_cov_port", this);
    tx_h = dl_tx::type_id::create("tx_h", this);
  endfunction:build_phase

  function void write(dl_tx   t);

    `uvm_info("dl_cxl_agent_COV", "From Coverage Write function", UVM_LOW)

  endfunction:write

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("dl_cxl_agent_COV","From Coverage Run Phase", UVM_LOW)

  endtask:run_phase

endclass:dl_cxl_agent_cov
