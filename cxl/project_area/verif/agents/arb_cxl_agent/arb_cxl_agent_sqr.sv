class arb_cxl_agent_sqr extends uvm_sequencer#(arb_tx);

  `uvm_component_utils(arb_cxl_agent_sqr)

  function new(string name="arb_cxl_agent_sqr", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

endclass:arb_cxl_agent_sqr
