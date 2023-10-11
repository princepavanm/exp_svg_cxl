class axi_agent_cov extends uvm_subscriber#(axi_agent_tx);

  `uvm_component_utils(axi_agent_cov)

  uvm_analysis_imp#(axi_agent_tx, axi_agent_cov)       axi_agent_cov_port;

  axi_agent_tx   axi_agent_tx_h;

  covergroup cg();

    // Implement Cover bins here

  endgroup:cg

  function new(string name="axi_agent_cov", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   axi_agent_cov_port = new("axi_agent_cov_port", this);
    axi_agent_tx_h = axi_agent_tx::type_id::create("axi_agent_tx_h", this);
  endfunction:build_phase

  function void write(axi_agent_tx   t);

    `uvm_info("AXI_AGENT_COV", "From Coverage Write function", UVM_LOW)

  endfunction:write

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("AXI_AGENT_COV","From Coverage Run Phase", UVM_LOW)

  endtask:run_phase

endclass:axi_agent_cov
