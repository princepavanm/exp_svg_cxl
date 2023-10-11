class axi_agent_sqr extends uvm_sequencer#(axi_agent_tx);

  `uvm_component_utils(axi_agent_sqr)

  function new(string name="axi_agent_sqr", uvm_component parent=null);
    super.new(name, parent);
  endfunction

endclass:axi_agent_sqr
