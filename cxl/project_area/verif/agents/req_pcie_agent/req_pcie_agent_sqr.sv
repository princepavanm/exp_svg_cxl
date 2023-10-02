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

class req_pcie_agent_sqr extends uvm_sequencer#(req_tx);

  `uvm_component_utils(req_pcie_agent_sqr)

  function new(string name="req_pcie_agent_sqr", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

endclass:req_pcie_agent_sqr
