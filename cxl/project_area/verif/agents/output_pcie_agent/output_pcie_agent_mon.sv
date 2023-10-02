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

class output_pcie_agent_mon extends uvm_monitor;

  `uvm_component_utils(output_pcie_agent_mon)

  output_tx   tx_h;


  function new(string name="output_pcie_agent_mon", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    tx_h = output_tx::type_id::create("tx_h", this);

  endfunction:build_phase

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("output_pcie_agent_mon","Monitor Run Phase", UVM_LOW)

  endtask:run_phase

endclass:output_pcie_agent_mon
