class dl_cxl_agent_sqr extends uvm_sequencer#(dl_tx);

  `uvm_component_utils(dl_cxl_agent_sqr)

  function new(string name="dl_cxl_agent_sqr", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

endclass:dl_cxl_agent_sqr
