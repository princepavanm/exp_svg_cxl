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

class req_pcie_agent_mon extends uvm_monitor;

  `uvm_component_utils(req_pcie_agent_mon)

  req_tx   tx_h;

  uvm_analysis_port #(req_tx)       req_pcie_agent_mon_port;

  function new(string name="req_pcie_agent_mon", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    req_pcie_agent_mon_port = new("req_pcie_agent_mon_port", this);
    tx_h = req_tx::type_id::create("tx_h", this);

  endfunction:build_phase

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("req_pcie_agent_mon","Monitor Run Phase", UVM_LOW)

  endtask:run_phase

endclass:req_pcie_agent_mon
