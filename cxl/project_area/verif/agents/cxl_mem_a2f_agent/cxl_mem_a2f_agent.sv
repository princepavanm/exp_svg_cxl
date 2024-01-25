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

class cxl_mem_a2f_agent extends uvm_agent;

  cxl_mem_a2f_mon      mon_h; 

  virtual pcie_intf     pcie_pif;

  cxl_mem_a2f_drv      drv_h; 
  cxl_mem_a2f_sqr      sqr_h; 

  `uvm_component_utils(cxl_mem_a2f_agent)

  function new(string name="cxl_mem_a2f_agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

     mon_h = cxl_mem_a2f_mon::type_id::create("mon_h", this);

     drv_h = cxl_mem_a2f_drv::type_id::create("drv_h", this);
     sqr_h = cxl_mem_a2f_sqr::type_id::create("sqr_h", this);

    if(!uvm_config_db#(virtual pcie_intf)::get(this," ","pcie_intf",pcie_pif))
      `uvm_fatal("AGENT", "***** Could not get vif *****")
    uvm_config_db#(virtual pcie_intf)::set(this,"*","pcie_intf",pcie_pif);

  endfunction:build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    drv_h.seq_item_port.connect(sqr_h.seq_item_export);

  endfunction:connect_phase

endclass:cxl_mem_a2f_agent
