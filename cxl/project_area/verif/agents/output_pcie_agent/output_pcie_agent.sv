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

class output_pcie_agent extends uvm_agent;

  output_pcie_agent_mon      mon_h; 

  virtual output_intf     output_pif;


  `uvm_component_utils(output_pcie_agent)

  function new(string name="output_pcie_agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

     mon_h = output_pcie_agent_mon::type_id::create("mon_h", this);


  endfunction:build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

  endfunction:connect_phase

endclass:output_pcie_agent
