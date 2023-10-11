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

class cxl_virtual_sqr extends uvm_sequencer;
  `uvm_component_utils(cxl_virtual_sqr)

  req_pcie_agent_sqr 	 req_pcie_agent_sqr_h;
  comp_pcie_agent_sqr 	 comp_pcie_agent_sqr_h;
  reset_pcie_agent_sqr 	 reset_pcie_agent_sqr_h;
  cxl_pcie_agent_sqr 	 cxl_pcie_agent_sqr_h;
  axi_agent_sqr 	 axi_agent_sqr_h;

  function new(string name="cxl_virtual_sqr", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    req_pcie_agent_sqr_h = req_pcie_agent_sqr::type_id::create("req_pcie_agent_sqr_h", this);
    comp_pcie_agent_sqr_h = comp_pcie_agent_sqr::type_id::create("comp_pcie_agent_sqr_h", this);
    reset_pcie_agent_sqr_h = reset_pcie_agent_sqr::type_id::create("reset_pcie_agent_sqr_h", this);
    cxl_pcie_agent_sqr_h = cxl_pcie_agent_sqr::type_id::create("cxl_pcie_agent_sqr_h", this);
    axi_agent_sqr_h = axi_agent_sqr::type_id::create("axi_agent_sqr_h", this);

  endfunction:build_phase

endclass:cxl_virtual_sqr
