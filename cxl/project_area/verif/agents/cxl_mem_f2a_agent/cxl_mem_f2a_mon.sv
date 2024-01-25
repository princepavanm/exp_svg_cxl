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

class cxl_mem_f2a_mon extends uvm_monitor;

  `uvm_component_utils(cxl_mem_f2a_mon)

  cxl_mem_f2a_tx   tx_h;
  
  virtual pcie_intf     pcie_pif;

  uvm_analysis_port #(cxl_mem_f2a_tx)       cxl_mem_f2a_mon_port;

  function new(string name="cxl_mem_f2a_mon", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual pcie_intf)::get(this, " ", "pcie_intf", pcie_pif))
      `uvm_fatal("DRV", "***** Could not get pcie_pif *****")
    cxl_mem_f2a_mon_port = new("cxl_mem_f2a_mon_port", this);
    tx_h = cxl_mem_f2a_tx::type_id::create("tx_h", this);

  endfunction:build_phase

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("cxl_mem_f2a_mon","Monitor Run Phase", UVM_LOW)
  endtask:run_phase

endclass:cxl_mem_f2a_mon
