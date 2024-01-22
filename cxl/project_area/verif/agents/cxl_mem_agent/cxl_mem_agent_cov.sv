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

class cxl_mem_agent_cov extends uvm_subscriber#(cxl_mem_tx);

  `uvm_component_utils(cxl_mem_agent_cov)

  uvm_analysis_imp#(cxl_mem_tx, cxl_mem_agent_cov)       cxl_mem_agent_cov_port;

  cxl_mem_tx   tx_h;

  covergroup cg();

    // Implement Cover bins here

  endgroup:cg

  function new(string name="cxl_mem_agent_cov", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cxl_mem_agent_cov_port = new("cxl_mem_agent_cov_port", this);
    tx_h = cxl_mem_tx::type_id::create("tx_h", this);
  endfunction:build_phase

  function void write(cxl_mem_tx   t);

    `uvm_info("cxl_pcie_agent_COV", "From Coverage Write function", UVM_LOW)

  endfunction:write

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("cxl_mem_agent_COV","From Coverage Run Phase", UVM_LOW)

  endtask:run_phase

endclass:cxl_mem_agent_cov
