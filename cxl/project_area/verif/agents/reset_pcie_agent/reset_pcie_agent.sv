//////////////////////////////////////////////////////////////////////////////////
// Company:  Expolog Technologies.
//           Copyright (c) 2023 by Expolog Technologies, Inc. All rights reserved.
//
// Engineer : 
// Revision tag :
// Module Name      :    
// Project Name      : 
// component name : 
// Description: This module provides a test to generate clocks
//              
//
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

class reset_pcie_agent extends uvm_agent;

  reset_pcie_agent_mon      mon_h; 

  virtual pcie_intf     pcie_pif;

  reset_pcie_agent_drv      drv_h; 
  reset_pcie_agent_sqr      sqr_h; 
  reset_pcie_agent_cov      cov_h; 

  `uvm_component_utils(reset_pcie_agent)

  function new(string name="reset_pcie_agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

     mon_h = reset_pcie_agent_mon::type_id::create("mon_h", this);

     drv_h = reset_pcie_agent_drv::type_id::create("drv_h", this);
     sqr_h = reset_pcie_agent_sqr::type_id::create("sqr_h", this);
     cov_h = reset_pcie_agent_cov::type_id::create("cov_h", this);

    if(!uvm_config_db#(virtual pcie_intf)::get(this," ","pcie_intf",pcie_pif))
      `uvm_fatal("AGENT", "***** Could not get vif *****")
    uvm_config_db#(virtual pcie_intf)::set(this,"*","pcie_intf",pcie_pif);

  endfunction:build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    drv_h.seq_item_port.connect(sqr_h.seq_item_export);

  endfunction:connect_phase

endclass:reset_pcie_agent
