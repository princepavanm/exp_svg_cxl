class arb_cxl_agent extends uvm_agent;

  arb_cxl_agent_mon      mon_h; 

  virtual arb_intf     arb_pif;

  arb_cxl_agent_drv      drv_h; 
  arb_cxl_agent_sqr      sqr_h; 
  arb_cxl_agent_cov      cov_h; 

  `uvm_component_utils(arb_cxl_agent)

  function new(string name="arb_cxl_agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

     mon_h = arb_cxl_agent_mon::type_id::create("mon_h", this);

     drv_h = arb_cxl_agent_drv::type_id::create("drv_h", this);
     sqr_h = arb_cxl_agent_sqr::type_id::create("sqr_h", this);
     cov_h = arb_cxl_agent_cov::type_id::create("cov_h", this);

    if(!uvm_config_db#(virtual arb_intf)::get(this," ","arb_pif",arb_pif))
      `uvm_fatal("AGENT", "***** Could not get vif *****")
    uvm_config_db#(virtual arb_intf)::set(this,"*","arb_pif",arb_pif);

  endfunction:build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    drv_h.seq_item_port.connect(sqr_h.seq_item_export);

  endfunction:connect_phase

endclass:arb_cxl_agent
