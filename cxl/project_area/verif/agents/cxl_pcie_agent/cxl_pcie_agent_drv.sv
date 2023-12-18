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

class cxl_pcie_agent_drv extends uvm_driver#(cxl_tx);

  `uvm_component_utils(cxl_pcie_agent_drv)

  cxl_tx               tx_h;
  cxl_io_mctp          cxlio;

  virtual pcie_intf     pcie_pif;

  function new(string name="cxl_pcie_agent_drv", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual pcie_intf)::get(this, " ", "pcie_intf", pcie_pif))
      `uvm_fatal("DRV", "***** Could not get pcie_pif *****")

    tx_h = cxl_tx::type_id::create("tx_h");
    cxlio = cxl_io_mctp::type_id::create("cxl",this);
  endfunction:build_phase

  task run_phase(uvm_phase phase);
    forever
    begin
     	seq_item_port.get_next_item(tx_h);
       		drive_tx(tx_h);
     	seq_item_port.item_done();
    end

  endtask:run_phase

  task drive_tx(cxl_tx     tx_h);
     bit [191:0]   rsp_pkt;
     `uvm_info(get_type_name(),$sformatf("=============================================Driver CXL ======================================= \n %s",tx_h.sprint()),UVM_MEDIUM)
     cxlio.send_to_cxlio(tx_h);
     rsp_pkt =cxlio.get_response_cxlio;
     $display("Response Packet INFO - %h",rsp_pkt);
     tx_h.cxlio_mctp_rsp_pkt = rsp_pkt;
     drive_to_intf(tx_h);
     

  endtask:drive_tx

  task drive_to_intf(cxl_tx tx_h);
	@(pcie_pif.cxlio_drv);

	pcie_pif.cxlio_drv.cxlio_mctp_req_data  <= tx_h.cxlio_mctp_req_data;
	pcie_pif.cxlio_drv.cxlio_mctp_req_hdr   <= tx_h.cxlio_mctp_req_hdr;
	pcie_pif.cxlio_drv.cxlio_mctp_en        <= tx_h.cxlio_mctp_en;
	pcie_pif.cxlio_drv.cxlio_mctp_rsp_pkt   <= tx_h.cxlio_mctp_rsp_pkt;
	@(pcie_pif.cxlio_drv);

  endtask:drive_to_intf

endclass:cxl_pcie_agent_drv
