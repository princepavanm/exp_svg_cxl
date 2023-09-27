class tl_cxl_agent_sqr extends uvm_sequencer#(tl_tx);

  `uvm_component_utils(tl_cxl_agent_sqr)

  function new(string name="tl_cxl_agent_sqr", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

endclass:tl_cxl_agent_sqr
