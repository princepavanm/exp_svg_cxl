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

class axi_agent_mon extends uvm_monitor;

  `uvm_component_utils(axi_agent_mon)

  axi_agent_tx   req;

  virtual pcie_intf     pcie_pif;

  uvm_analysis_port #(axi_agent_tx)       axi_agent_mon_port;
  
//*************** constructor*************************

  function new(string name="axi_agent_mon", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  // ********************* build phase *******************

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    req = axi_agent_tx::type_id::create("req", this);
    axi_agent_mon_port = new("axi_agent_mon_port", this);

    if(!uvm_config_db#(virtual pcie_intf)::get(this, " ", "pcie_intf", pcie_pif))
      `uvm_fatal("DRV", "***** Could not get pcie_pif *****")
  endfunction:build_phase

  // ************************* connect phase ******************

function void  connect_phase(uvm_phase phase);
  super.connect_phase(phase);
 endfunction

// **************** run phase*********************

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("AXI_AGENT_MON","Monitor Run Phase", UVM_LOW)
     
    forever
    begin
	    collect_packet_axi_intf(req);
	  axi_agent_mon_port.write(req); 
//	`uvm_info(get_type_name(),$sformatf("=============================================AXI MONITOR TO SCB======================================= \n %s",req.sprint()),UVM_MEDIUM)
    end
   
  endtask:run_phase
// ***** collect data from intf********************
task collect_packet_axi_intf(axi_agent_tx req);
   
   @((pcie_pif.clk) && pcie_pif.rst ==0)
  // if(pcie_pif.axi_mon_cb.m_axi_awready || pcie_pif.axi_mon_cb.m_axi_wready || pcie_pif.axi_mon_cb.m_axi_wready)
   begin
   	req.m_axi_awid	              = pcie_pif.axi_mon_cb.m_axi_awid;    
   	req.m_axi_awaddr	      = pcie_pif.axi_mon_cb.m_axi_awaddr;
   	req.m_axi_awlen	              = pcie_pif.axi_mon_cb.m_axi_awlen;
   	req.m_axi_awsize	      = pcie_pif.axi_mon_cb.m_axi_awsize;
   	req.m_axi_awburst             = pcie_pif.axi_mon_cb.m_axi_awburst;
   	req.m_axi_awlock	      = pcie_pif.axi_mon_cb.m_axi_awlock;   
   	req.m_axi_awcache	      = pcie_pif.axi_mon_cb.m_axi_awcache;  
   	req.m_axi_awprot	      = pcie_pif.axi_mon_cb.m_axi_awprot;   
   	req.m_axi_awvalid	      = pcie_pif.axi_mon_cb.m_axi_awvalid;  
   	req.m_axi_awready	      = pcie_pif.axi_mon_cb.m_axi_awready;
   	req.m_axi_wdata	              = pcie_pif.axi_mon_cb.m_axi_wdata;
   	req.m_axi_wstrb	              = pcie_pif.axi_mon_cb.m_axi_wstrb;
   	req.m_axi_wlast	              = pcie_pif.axi_mon_cb.m_axi_wlast;
   	req.m_axi_wvalid	      = pcie_pif.axi_mon_cb.m_axi_wvalid;
   	req.m_axi_wready	      = pcie_pif.axi_mon_cb.m_axi_wready;
   	req.m_axi_bid	              = pcie_pif.axi_mon_cb.m_axi_bid;
   	req.m_axi_bresp	              = pcie_pif.axi_mon_cb.m_axi_bresp;
   	req.m_axi_bvalid	      = pcie_pif.axi_mon_cb.m_axi_bvalid;
   	req.m_axi_bready	      = pcie_pif.axi_mon_cb.m_axi_bready;
   	req.m_axi_arid	              = pcie_pif.axi_mon_cb.m_axi_arid;
   	req.m_axi_araddr	      = pcie_pif.axi_mon_cb.m_axi_araddr;
   	req.m_axi_arlen	              = pcie_pif.axi_mon_cb.m_axi_arlen;
   	req.m_axi_arsize	      = pcie_pif.axi_mon_cb.m_axi_arsize;
   	req.m_axi_arburst	      = pcie_pif.axi_mon_cb.m_axi_arburst;
   	req.m_axi_arlock	      = pcie_pif.axi_mon_cb.m_axi_arlock;
   	req.m_axi_arcache	      = pcie_pif.axi_mon_cb.m_axi_arcache;
   	req.m_axi_arprot	      = pcie_pif.axi_mon_cb.m_axi_arprot;   
   	req.m_axi_arvalid	      = pcie_pif.axi_mon_cb.m_axi_arvalid;  
   	req.m_axi_arready	      = pcie_pif.axi_mon_cb.m_axi_arready;
   	req.m_axi_rid	              = pcie_pif.axi_mon_cb.m_axi_rid;      
   	req.m_axi_rdata	              = pcie_pif.axi_mon_cb.m_axi_rdata;    
   	req.m_axi_rresp	              = pcie_pif.axi_mon_cb.m_axi_rresp;    
   	req.m_axi_rlast	              = pcie_pif.axi_mon_cb.m_axi_rlast;
   	req.m_axi_rvalid	      = pcie_pif.axi_mon_cb.m_axi_rvalid;
   	req.m_axi_rready	      = pcie_pif.axi_mon_cb.m_axi_rready;

//	`uvm_info(get_type_name(),$sformatf("=============================================AXI MONITOR from dut======================================= \n %s",req.sprint()),UVM_MEDIUM)
   end

 endtask :collect_packet_axi_intf
endclass:axi_agent_mon
