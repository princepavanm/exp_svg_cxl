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

class req_pcie_agent_drv extends uvm_driver#(req_tx);

  `uvm_component_utils(req_pcie_agent_drv)

  req_tx               tx_h;

  virtual pcie_intf     pcie_pif;

  function new(string name="req_pcie_agent_drv", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual pcie_intf)::get(this, " ", "pcie_intf", pcie_pif))
      `uvm_fatal("REQ DRV", "***** Could not get pcie_pif *****")
    tx_h = req_tx::type_id::create("tx_h");
  endfunction:build_phase

  task run_phase(uvm_phase phase);
	  forever 
	  begin
     seq_item_port.get_next_item(tx_h);
       send_to_dut_request(tx_h);
     seq_item_port.item_done();
	end
  endtask:run_phase

  task send_to_dut_request(req_tx tx_h);
   `uvm_info("Driver","reset is high",UVM_MEDIUM)
   begin
     @((pcie_pif.clk) && !pcie_pif.rst )
	if(!pcie_pif.rst && tx_h.rx_req_tlp_valid)
	begin
	  pcie_pif.dri_cb.completer_id      <= tx_h.completer_id;
	  pcie_pif.dri_cb.max_payload_size  <= tx_h.max_payload_size;
	  pcie_pif.dri_cb.rx_req_tlp_valid  <= tx_h.rx_req_tlp_valid;
	  pcie_pif.dri_cb.rx_req_tlp_sop    <= tx_h.rx_req_tlp_sop;
	  pcie_pif.dri_cb.rx_req_tlp_hdr    <= tx_h.rx_req_tlp_hdr;
	  pcie_pif.dri_cb.rx_req_tlp_data   <= tx_h.rx_req_tlp_data;
//	  @(pcie_pif.dri_mp.clk)
//	  @(pcie_pif.dri_mp.clk)
	  pcie_pif.dri_cb.rx_req_tlp_eop    <= tx_h.rx_req_tlp_eop;
  	end
   end 
      // tx_h.print();
	  
       `uvm_info(get_type_name(),$sformatf("=============================================DRIVER REQ to dut ======================================= \n %s",tx_h.sprint()),UVM_MEDIUM)
       
  endtask:send_to_dut_request

endclass:req_pcie_agent_drv
