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

//----List of Include Files--------------------//

 // `include "req_pcie_agent_intf.sv"
  //`include "comp_pcie_agent_intf.sv"
  //`include "reset_pcie_agent_intf.sv"
  //`include "cxl_pcie_agent_intf.sv"
  //
  `include "define.sv"
  `include "pcie_intf.sv"

  `include "req_pcie_agent_tx.sv"
  `include "req_pcie_agent_drv.sv"
  `include "req_pcie_agent_sqr.sv"
  `include "req_pcie_agent_cov.sv"
  `include "req_pcie_agent_mon.sv"
  `include "req_pcie_agent.sv"

  `include "comp_pcie_agent_tx.sv"
  `include "comp_pcie_agent_drv.sv"
  `include "comp_pcie_agent_sqr.sv"
  `include "comp_pcie_agent_cov.sv"
  `include "comp_pcie_agent_mon.sv"
  `include "comp_pcie_agent.sv"

  `include "reset_pcie_agent_tx.sv"
  `include "reset_pcie_agent_drv.sv"
  `include "reset_pcie_agent_sqr.sv"
  `include "reset_pcie_agent_cov.sv"
  `include "reset_pcie_agent_mon.sv"
  `include "reset_pcie_agent.sv"

  `include "cxl_pcie_agent_tx.sv"
  `include "cxl_pcie_agent_drv.sv"
  `include "cxl_pcie_agent_sqr.sv"
  `include "cxl_pcie_agent_cov.sv"
  `include "cxl_pcie_agent_mon.sv"
  `include "cxl_pcie_agent.sv"

  `include "output_pcie_agent_tx.sv"
  `include "output_pcie_agent_mon.sv"
  `include "output_pcie_agent.sv"
  

  `include "virtual_sqr.sv"

// Sequence List
  `include "../seqs/sequence_list.sv"
  `include "env.sv"

// Test List
  `include "../tests/test_list.sv"
