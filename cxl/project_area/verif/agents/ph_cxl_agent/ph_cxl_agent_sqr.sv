class ph_cxl_agent_sqr extends uvm_sequencer#(ph_tx);

  `uvm_component_utils(ph_cxl_agent_sqr)

  function new(string name="ph_cxl_agent_sqr", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

endclass:ph_cxl_agent_sqr
