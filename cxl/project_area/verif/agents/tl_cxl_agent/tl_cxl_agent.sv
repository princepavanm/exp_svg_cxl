class tl_cxl_agent extends uvm_agent;

  tl_cxl_agent_mon      mon_h; 

  virtual tl_intf     tl_pif;

  tl_cxl_agent_drv      drv_h; 
  tl_cxl_agent_sqr      sqr_h; 
  tl_cxl_agent_cov      cov_h; 

  `uvm_component_utils(tl_cxl_agent)

  function new(string name="tl_cxl_agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

     mon_h = tl_cxl_agent_mon::type_id::create("mon_h", this);

     drv_h = tl_cxl_agent_drv::type_id::create("drv_h", this);
     sqr_h = tl_cxl_agent_sqr::type_id::create("sqr_h", this);
     cov_h = tl_cxl_agent_cov::type_id::create("cov_h", this);

    if(!uvm_config_db#(virtual tl_intf)::get(this," ","tl_pif",tl_pif))
      `uvm_fatal("AGENT", "***** Could not get vif *****")
    uvm_config_db#(virtual tl_intf)::set(this,"*","tl_pif",tl_pif);

  endfunction:build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    drv_h.seq_item_port.connect(sqr_h.seq_item_export);

  endfunction:connect_phase

endclass:tl_cxl_agent
