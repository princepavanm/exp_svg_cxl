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

class cxl_pcie_agent_mon extends uvm_monitor;

  `uvm_component_utils(cxl_pcie_agent_mon)

  cxl_tx   tx_h;
  
  virtual pcie_intf     pcie_pif;

  uvm_analysis_port #(cxl_tx)       cxl_pcie_agent_mon_port;

  function new(string name="cxl_pcie_agent_mon", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual pcie_intf)::get(this, " ", "pcie_intf", pcie_pif))
      `uvm_fatal("DRV", "***** Could not get pcie_pif *****")
    cxl_pcie_agent_mon_port = new("cxl_pcie_agent_mon_port", this);
    tx_h = cxl_tx::type_id::create("tx_h", this);

  endfunction:build_phase

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("cxl_pcie_agent_mon","Monitor Run Phase", UVM_LOW)

    forever	
    begin
	@(pcie_pif.cxlio_mon);
	@(pcie_pif.cxlio_mon);

	if(pcie_pif.cxlio_mon.cxlio_mctp_en)
	begin
 		tx_h.cxlio_mctp_req_data  =   pcie_pif.cxlio_mon.cxlio_mctp_req_data; 
 		tx_h.cxlio_mctp_req_hdr   =   pcie_pif.cxlio_mon.cxlio_mctp_req_hdr; 
 		tx_h.cxlio_mctp_en        =   pcie_pif.cxlio_mon.cxlio_mctp_en;      
 		tx_h.cxlio_mctp_rsp_pkt   =   pcie_pif.cxlio_mon.cxlio_mctp_rsp_pkt; 
		`uvm_info(get_type_name(),$sformatf("=============================================MONITOR CXL ======================================= \n %s",tx_h.sprint()),UVM_MEDIUM)
	end


    end

  endtask:run_phase

endclass:cxl_pcie_agent_mon
