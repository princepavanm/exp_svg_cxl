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

  axi_agent_tx   axi_agent_tx_h;

  virtual pcie_intf     pcie_pif;

  uvm_analysis_port #(axi_agent_tx)       axi_agent_mon_port;
  
//*************** constructor*************************

  function new(string name="axi_agent_mon", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  // ********************* build phase *******************

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

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
collect_packet_axi_intf();
// axi_agent_tx_h.print();
    `uvm_info(get_type_name(),$sformatf("MONITOR collect data from dut \n %s",axi_agent_tx_h.sprint()),UVM_MEDIUM)
   
  endtask:run_phase
// ***** collect data from intf********************
task collect_packet_axi_intf();
    axi_agent_tx_h = axi_agent_tx::type_id::create("axi_agent_tx_h", this);
    
    if(pcie_pif.rx_req_tlp_valid)

  // @(pcie_pif.req_mon_cb);
     begin
   
axi_agent_tx_h.m_axi_awid	<= pcie_pif.m_axi_awid;    
axi_agent_tx_h.m_axi_awaddr	<= pcie_pif.m_axi_awaddr;
axi_agent_tx_h.m_axi_awlen	<= pcie_pif.m_axi_awlen;
axi_agent_tx_h.m_axi_awsize	<= pcie_pif.m_axi_awsize;
axi_agent_tx_h.m_axi_awburst	<= pcie_pif.m_axi_awburst;
axi_agent_tx_h.m_axi_awlock	<= pcie_pif.m_axi_awlock;   
axi_agent_tx_h.m_axi_awcache	<= pcie_pif.m_axi_awcache;  
axi_agent_tx_h.m_axi_awprot	<= pcie_pif.m_axi_awprot;   
axi_agent_tx_h.m_axi_awvalid	<= pcie_pif.m_axi_awvalid;  
axi_agent_tx_h.m_axi_awready	<= pcie_pif.m_axi_awready;
axi_agent_tx_h.m_axi_wdata	<= pcie_pif.m_axi_wdata;
axi_agent_tx_h.m_axi_wstrb	<= pcie_pif.m_axi_wstrb;
axi_agent_tx_h.m_axi_wlast	<= pcie_pif.m_axi_wlast;
axi_agent_tx_h.m_axi_wvalid	<= pcie_pif.m_axi_wvalid;
axi_agent_tx_h.m_axi_wready	<= pcie_pif.m_axi_wready;
axi_agent_tx_h.m_axi_bid	<= pcie_pif.m_axi_bid;
axi_agent_tx_h.m_axi_bresp	<= pcie_pif.m_axi_bresp;
axi_agent_tx_h.m_axi_bvalid	<= pcie_pif.m_axi_bvalid;
axi_agent_tx_h.m_axi_bready	<= pcie_pif.m_axi_bready;
axi_agent_tx_h.m_axi_arid	<= pcie_pif.m_axi_arid;
axi_agent_tx_h.m_axi_araddr	<= pcie_pif.m_axi_araddr;
axi_agent_tx_h.m_axi_arlen	<= pcie_pif.m_axi_arlen;
axi_agent_tx_h.m_axi_arsize	<= pcie_pif.m_axi_arsize;
axi_agent_tx_h.m_axi_arburst	<= pcie_pif.m_axi_arburst;
axi_agent_tx_h.m_axi_arlock	<= pcie_pif.m_axi_arlock;
axi_agent_tx_h.m_axi_arcache	<= pcie_pif.m_axi_arcache;
axi_agent_tx_h.m_axi_arprot	<= pcie_pif.m_axi_arprot;   
axi_agent_tx_h.m_axi_arvalid	<= pcie_pif.m_axi_arvalid;  
axi_agent_tx_h.m_axi_arready	<= pcie_pif.m_axi_arready;
axi_agent_tx_h.m_axi_rid	<= pcie_pif.m_axi_rid;      
axi_agent_tx_h.m_axi_rdata	<= pcie_pif.m_axi_rdata;    
axi_agent_tx_h.m_axi_rresp	<= pcie_pif.m_axi_rresp;    
axi_agent_tx_h.m_axi_rlast	<= pcie_pif.m_axi_rlast;
axi_agent_tx_h.m_axi_rvalid	<= pcie_pif.m_axi_rvalid;
axi_agent_tx_h.m_axi_rready	<= pcie_pif.m_axi_rready;

end
endtask :collect_packet_axi_intf
endclass:axi_agent_mon
