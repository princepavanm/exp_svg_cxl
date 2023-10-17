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

class comp_pcie_agent_drv extends uvm_driver#(comp_tx);

  `uvm_component_utils(comp_pcie_agent_drv)

  comp_tx               tx_h;

  virtual pcie_intf     pcie_pif;

  function new(string name="comp_pcie_agent_drv", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual pcie_intf)::get(this, " ", "pcie_intf", pcie_pif))
      `uvm_fatal("DRV", "***** Could not get pcie_pif *****")
  endfunction:build_phase

  task run_phase(uvm_phase phase);

     seq_item_port.get_next_item(req);
       //req.print();
       send_to_dut_comp(req);
     seq_item_port.item_done();

  endtask:run_phase

  task send_to_dut_comp(comp_tx     tx_h);

	  pcie_pif.tx_cpl_tlp_ready      = 1;// tx_h.tx_cpl_tlp_ready;

  endtask:send_to_dut_comp

endclass:comp_pcie_agent_drv
