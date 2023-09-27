class arb_cxl_agent_cov extends uvm_subscriber#(arb_tx);

  `uvm_component_utils(arb_cxl_agent_cov)

  uvm_analysis_imp#(arb_tx, arb_cxl_agent_cov)       arb_cxl_agent_cov_port;

  arb_tx   tx_h;

  covergroup cg();

    // Implement Cover bins here

  endgroup:cg

  function new(string name="arb_cxl_agent_cov", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    arb_cxl_agent_cov_port = new("arb_cxl_agent_cov_port", this);
    tx_h = arb_tx::type_id::create("tx_h", this);
  endfunction:build_phase

  function void write(arb_tx   t);

    `uvm_info("arb_cxl_agent_COV", "From Coverage Write function", UVM_LOW)

  endfunction:write

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("arb_cxl_agent_COV","From Coverage Run Phase", UVM_LOW)

  endtask:run_phase

endclass:arb_cxl_agent_cov
