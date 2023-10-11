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
  endfunction:build_phase

  task run_phase(uvm_phase phase);
	  forever 
	  begin
     seq_item_port.get_next_item(req);
       //tx_h.print();
       send_to_dut_request(req);
     seq_item_port.item_done();
	end
  endtask:run_phase

  task send_to_dut_request(req_tx tx_h);

		
`uvm_info("Driver",$sformatf("reset is high"),UVM_MEDIUM)
     @((pcie_pif.dri_mp.clk) && pcie_pif.rst ==0)
	if(pcie_pif.rst ==0 && tx_h.rx_req_tlp_valid ==1 )
	begin
	  pcie_pif.completer_id      = tx_h.completer_id;
	  pcie_pif.max_payload_size  = tx_h.max_payload_size;
	  pcie_pif.rx_req_tlp_valid  = tx_h.rx_req_tlp_valid;
	  pcie_pif.rx_req_tlp_sop    = tx_h.rx_req_tlp_sop;
	  pcie_pif.rx_req_tlp_hdr    = tx_h.rx_req_tlp_hdr;
	  pcie_pif.rx_req_tlp_data   = tx_h.rx_req_tlp_data;
	  @(pcie_pif.dri_mp.clk)
	  @(pcie_pif.dri_mp.clk)
	  pcie_pif.rx_req_tlp_eop    = 1;//tx_h.rx_req_tlp_eop;
  	end
     
  endtask:send_to_dut_request

endclass:req_pcie_agent_drv
