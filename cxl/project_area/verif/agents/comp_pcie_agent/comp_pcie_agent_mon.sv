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

class comp_pcie_agent_mon extends uvm_monitor;

  `uvm_component_utils(comp_pcie_agent_mon)

  comp_tx   tx_h;

  virtual pcie_intf   pcie_pif;

  uvm_analysis_port #(comp_tx)       comp_pcie_agent_mon_port;

  function new(string name="comp_pcie_agent_mon", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    comp_pcie_agent_mon_port = new("comp_pcie_agent_mon_port", this);
    tx_h = comp_tx::type_id::create("tx_h", this);

     if(!uvm_config_db#(virtual pcie_intf)::get(this, " ", "pcie_intf", pcie_pif))
      `uvm_fatal("DRV", "***** Could not get pcie_pif *****")

  endfunction:build_phase

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("comp_pcie_agent_mon","Monitor Run Phase", UVM_LOW)

    forever
    begin
	    collect_packet_intf;
	    //tx_h.print();
    end

  endtask:run_phase

  task collect_packet_intf;
	  @((pcie_pif.clk) && !pcie_pif.rst )
	    if(!pcie_pif.rst && pcie_pif.mon_cb.rx_req_tlp_valid)
	    begin
		  @(pcie_pif.comp_mon);
			 tx_h.tx_cpl_tlp_data     =        pcie_pif.comp_mon.tx_cpl_tlp_data; 
			 tx_h.tx_cpl_tlp_strb     =        pcie_pif.comp_mon.tx_cpl_tlp_strb;
                         tx_h.tx_cpl_tlp_hdr      =        pcie_pif.comp_mon.tx_cpl_tlp_hdr;
                         tx_h.tx_cpl_tlp_valid    =        pcie_pif.comp_mon.tx_cpl_tlp_valid;
                         tx_h.tx_cpl_tlp_sop      =        pcie_pif.comp_mon.tx_cpl_tlp_sop;
                         tx_h.tx_cpl_tlp_eop      =        pcie_pif.comp_mon.tx_cpl_tlp_eop;
                         tx_h.tx_cpl_tlp_ready    =        pcie_pif.comp_mon.tx_cpl_tlp_ready;
//		 `uvm_info(get_type_name(),$sformatf("=============================================MONITOR COMP from dut ======================================= \n %s",tx_h.sprint()),UVM_MEDIUM)
	  
	    end
  endtask

endclass:comp_pcie_agent_mon
