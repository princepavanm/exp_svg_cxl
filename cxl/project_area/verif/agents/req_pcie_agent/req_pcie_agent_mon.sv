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
/*
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
*/

class req_pcie_agent_mon extends uvm_monitor;

  `uvm_component_utils(req_pcie_agent_mon)

  req_tx   req;
 virtual pcie_intf     pcie_pif;

  uvm_analysis_port #(req_tx)       req_pcie_agent_mon_port;
//*************** constructor*************************
  function new(string name="req_pcie_agent_mon", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new
// ********************* build phase *******************
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

 //   req_pcie_agent_mon_port = new("req_pcie_agent_mon_port", this);
    if(!uvm_config_db#(virtual pcie_intf)::get(this, " ", "pcie_intf", pcie_pif))
      `uvm_fatal("DRV", "***** Could not get pcie_pif *****")
 //   req = req_tx::type_id::create("req");

  endfunction:build_phase
// ************************* connect phase ******************

function void  connect_phase(uvm_phase phase);
  super.connect_phase(phase);
 endfunction

// **************** run phase*********************
task run_phase(uvm_phase phase);
    super.run_phase(phase);
    req=req_tx::type_id::create("req");
    `uvm_info("req_pcie_agent_mon","Monitor Run Phase", UVM_LOW)
	forever	
  		begin
 			 collect_packet_intf;
    			 req.print();
    			//`uvm_info(get_type_name(),$sformatf("MONITOR collect data from dut \n %s",req.sprint()),UVM_MEDIUM)
   
  		end  	
endtask:run_phase
// ***** collect data from intf********************
task collect_packet_intf;
 
   @((pcie_pif.clk) && !pcie_pif.rst )
   	if(!pcie_pif.rst && pcie_pif.mon_cb.rx_req_tlp_valid )
        begin
		
 	@(pcie_pif.mon_cb);
  	   req.completer_id     = pcie_pif.mon_cb.completer_id ;	
 	   req.max_payload_size = pcie_pif.mon_cb.max_payload_size;
     	   req.rx_req_tlp_valid = pcie_pif.mon_cb.rx_req_tlp_valid;
       	   req.rx_req_tlp_sop   = pcie_pif.mon_cb.rx_req_tlp_sop;  
	   req.rx_req_tlp_hdr   = pcie_pif.mon_cb.rx_req_tlp_hdr;
	   req.rx_req_tlp_data  = pcie_pif.mon_cb.rx_req_tlp_data;
	   req.rx_req_tlp_eop   = pcie_pif.mon_cb.rx_req_tlp_eop;
	  
  
          // $display("MONITOR [T=%0t] pcie_pif.rx_req_tlp_sop=%0h  pcie_pif.rx_req_tlp_valid=%0h pcie_pif.rx_req_tlp_hdr =%0h  pcie_pif.rx_req_tlp_data=%0h  pcie_pif.rx_req_tlp_eop=%0h",$realtime,pcie_pif.mon_cb.rx_req_tlp_sop,  pcie_pif.mon_cb.rx_req_tlp_valid, pcie_pif.mon_cb.rx_req_tlp_hdr,  pcie_pif.mon_cb.rx_req_tlp_data,  pcie_pif.mon_cb.rx_req_tlp_eop  );

           //$display( "MONITOR [T=%0t] req.rx_req_tlp_sop=%0h  req.rx_req_tlp_valid=%0h req.rx_req_tlp_hdr =%0h  req.rx_req_tlp_data=%0h  req.rx_req_tlp_eop=%0h",$realtime,req.rx_req_tlp_sop,  req.rx_req_tlp_valid, req.rx_req_tlp_hdr,  req.rx_req_tlp_data,  req.rx_req_tlp_eop);
       end

endtask :collect_packet_intf

endclass:req_pcie_agent_mon
