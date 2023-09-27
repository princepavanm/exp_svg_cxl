class pass_cxl_agent extends uvm_agent;

  pass_cxl_agent_mon      mon_h; 

  virtual pass_intf     pass_pif;


  `uvm_component_utils(pass_cxl_agent)

  function new(string name="pass_cxl_agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

     mon_h = pass_cxl_agent_mon::type_id::create("mon_h", this);


  endfunction:build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

  endfunction:connect_phase

endclass:pass_cxl_agent
