class cxl_virtual_sqr extends uvm_sequencer;
  `uvm_component_utils(cxl_virtual_sqr)

  tl_cxl_agent_sqr 	 tl_cxl_agent_sqr_h;
  dl_cxl_agent_sqr 	 dl_cxl_agent_sqr_h;
  ph_cxl_agent_sqr 	 ph_cxl_agent_sqr_h;
  arb_cxl_agent_sqr 	 arb_cxl_agent_sqr_h;

  function new(string name="cxl_virtual_sqr", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    tl_cxl_agent_sqr_h = tl_cxl_agent_sqr::type_id::create("tl_cxl_agent_sqr_h", this);
    dl_cxl_agent_sqr_h = dl_cxl_agent_sqr::type_id::create("dl_cxl_agent_sqr_h", this);
    ph_cxl_agent_sqr_h = ph_cxl_agent_sqr::type_id::create("ph_cxl_agent_sqr_h", this);
    arb_cxl_agent_sqr_h = arb_cxl_agent_sqr::type_id::create("arb_cxl_agent_sqr_h", this);

  endfunction:build_phase

endclass:cxl_virtual_sqr
