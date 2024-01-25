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
//`include "cxl_sbd.sv"


class cxl_env extends uvm_env;
  `uvm_component_utils(cxl_env)

   cxl_sbd		cxl_sbd_h;
   
  req_pcie_agent	req_pcie_agent_h;
  comp_pcie_agent	comp_pcie_agent_h;
  reset_pcie_agent	reset_pcie_agent_h;
  cxl_pcie_agent	cxl_pcie_agent_h;
  axi_agent             axi_agent_h;
  cxl_io_mctp           cxl_io_mctp_h;
  cxl_mem_a2f_agent           cxl_mem_a2f_agent_h;
  cxl_mem_f2a_agent           cxl_mem_f2a_agent_h;
  
  
  cxl_virtual_sqr 	 v_sqr_h;

/*********************** constructor***********************/
function new(string name="cxl_env", uvm_component parent=null);
	super.new(name, parent);
endfunction:new

/******************* build phase*****************************/
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
    v_sqr_h = cxl_virtual_sqr::type_id::create("v_sqr_h", this);

    req_pcie_agent_h = req_pcie_agent::type_id::create("req_pcie_agent_h", this);
    comp_pcie_agent_h = comp_pcie_agent::type_id::create("comp_pcie_agent_h", this);
    reset_pcie_agent_h = reset_pcie_agent::type_id::create("reset_pcie_agent_h", this);
    cxl_pcie_agent_h = cxl_pcie_agent::type_id::create("cxl_pcie_agent_h", this);
    axi_agent_h = axi_agent::type_id::create("axi_agent_h", this);
    cxl_sbd_h = cxl_sbd::type_id::create("cxl_sbd_h", this);
    cxl_io_mctp_h = cxl_io_mctp::type_id::create("cxl_io_mctp_h",this);
   cxl_mem_a2f_agent_h = cxl_mem_a2f_agent::type_id::create("cxl_mem_a2f_agent_h",this);
   cxl_mem_f2a_agent_h = cxl_mem_f2a_agent::type_id::create("cxl_mem_f2a_agent_h",this);

  endfunction:build_phase

/***************** connect phase**********************/
 function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    v_sqr_h.req_pcie_agent_sqr_h = req_pcie_agent_h.sqr_h;
    v_sqr_h.comp_pcie_agent_sqr_h = comp_pcie_agent_h.sqr_h;
    v_sqr_h.reset_pcie_agent_sqr_h = reset_pcie_agent_h.sqr_h;
    v_sqr_h.cxl_pcie_agent_sqr_h = cxl_pcie_agent_h.sqr_h;
    v_sqr_h.axi_agent_sqr_h = axi_agent_h.sqr_h;
    v_sqr_h.cxl_mem_a2f_sqr_h = cxl_mem_a2f_agent_h.sqr_h;
    v_sqr_h.cxl_mem_f2a_sqr_h = cxl_mem_f2a_agent_h.sqr_h;

//req_pcie_agent_h.mon_h.req_pcie_agent_mon_port.connect(cxl_sbd_h.imp_req_tx);
// axi_agent_h.mon_h.axi_agent_mon_port.connect(cxl_sbd_h.imp_axi_agent_tx);
  req_pcie_agent_h.mon_h.req_pcie_agent_mon_port.connect(cxl_sbd_h.req_txfifo.analysis_export);
    axi_agent_h.mon_h.axi_agent_mon_port.connect(cxl_sbd_h.axi_agent_txfifo.analysis_export);
cxl_pcie_agent_h.mon_h.cxl_pcie_agent_mon_port.connect(cxl_sbd_h.cxlio_txfifo.analysis_export);
//cxl_mem_agent_h.mon_h.cxl_mem_agent_mon_port.connect(cxl_sbd_h.cxlio_txfifo.analysis_export);
endfunction:connect_phase

//*********************************Report for checking error************************************************
  
function void report();

    uvm_report_server reportserver=uvm_report_server::get_server();

    $display("**************************************************");
    $display("****************** TEST Summary ******************");
    $display("**************************************************");

    if((reportserver.get_severity_count(UVM_FATAL)==0)&&(reportserver.get_severity_count(UVM_WARNING)==0)&&(reportserver.get_severity_count(UVM_ERROR)==0))  begin
      $display("**************************************************");
      $display("****************** TEST  PASSED ******************");
      $display("**************************************************");
      $display("");
      $display("");
      $display("******  ******  ****** ******         ****** 	******  ******  ******              ");
      $display("   *	  *       *        *            *    * 	*    *  *       *                   ");
      $display("   *	  *       *        *            *    * 	*    *  *       *                   ");
      $display("   *	  ******  ******   *            ****** 	******  ******  ******              ");
      $display("   *	  *            *   *            *       *    *       *       *              ");
      $display("   *	  *            *   *            *       *    *       *       *              ");
      $display("   *	  ******  ******   *            *       *    *  ******  ******              ");
      $display("");
      $display("");
      $display("============================================================================================================");
      
    end//if_end

    else 
    begin
      $display("**************************************************");
      $display("                    \\ / ");
      $display("                    oVo ");
      $display("                \\___XXX___/ ");
      $display("                 __XXXXX__ ");
      $display("                /__XXXXX__\\ ");
      $display("                /   XXX   \\ ");
      $display("                     V ");
      $display("                TEST  FAILED          ");
      $display("**************************************************");
    end//else_end

  endfunction:report

endclass:cxl_env
