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



//FIXME need to add the switch in runcmd `timescale 1ns / 1ps
  `include "uvm_macros.svh"
  import uvm_pkg::*;

  //include test library
  `include "cxl_list.svh";

module top;

//Rst and clock declarations
  reg clk, rst;

//Interface instantation
  pcie_intf pcie_pif(clk);

//Rst and Clock generation
  initial begin

    clk = 0;

    //rst = 1;
    //#10;
    //rst = 0;

   // #500us;
    //$finish();
  end

  always #5 clk = ~clk;

//DUT Instantiation
pcie_axi_master dut(	.clk(clk),
			.rst(pcie_pif.rst),

     			// TLP input (request)
                        .rx_req_tlp_data(pcie_pif.rx_req_tlp_data),
                        .rx_req_tlp_hdr(pcie_pif.rx_req_tlp_hdr),
                        .rx_req_tlp_valid(pcie_pif.rx_req_tlp_valid),
                        .rx_req_tlp_sop(pcie_pif.rx_req_tlp_sop),
                        .rx_req_tlp_eop(pcie_pif.rx_req_tlp_eop),
                        .rx_req_tlp_ready(pcie_pif.rx_req_tlp_ready),
                        
     			// AXI Master output
                        .tx_cpl_tlp_data(pcie_pif.tx_cpl_tlp_data),
                        .tx_cpl_tlp_strb(pcie_pif.tx_cpl_tlp_strb),
                        .tx_cpl_tlp_hdr(pcie_pif.tx_cpl_tlp_hdr),
                        .tx_cpl_tlp_valid(pcie_pif.tx_cpl_tlp_valid),
                        .tx_cpl_tlp_sop(pcie_pif.tx_cpl_tlp_sop),
                        .tx_cpl_tlp_eop(pcie_pif.tx_cpl_tlp_eop),
                        .tx_cpl_tlp_ready(1),
 
     			// Configuration
                        .completer_id(pcie_pif.completer_id),
			.max_payload_size(pcie_pif.max_payload_size),

			//Status
                        .status_error_cor(pcie_pif.status_error_cor),
                        .status_error_uncor(pcie_pif.status_error_uncor),

     			// AXI Master output
                        .m_axi_awid(pcie_pif.m_axi_awid),
                        .m_axi_awaddr(pcie_pif.m_axi_awaddr),
                        .m_axi_awlen(pcie_pif.m_axi_awlen),
                        .m_axi_awsize(pcie_pif.m_axi_awsize),
                        .m_axi_awburst(pcie_pif.m_axi_awburst),
                        .m_axi_awlock(pcie_pif.m_axi_awlock),
                        .m_axi_awcache(pcie_pif.m_axi_awcache),
                        .m_axi_awprot(pcie_pif.m_axi_awprot),
                        .m_axi_awvalid(pcie_pif.m_axi_awvalid),
                        //.m_axi_awready(1),
                        .m_axi_awready(pcie_pif.m_axi_awready),

                        .m_axi_wdata(pcie_pif.m_axi_wdata),
                        .m_axi_wstrb(pcie_pif.m_axi_wstrb),
                        .m_axi_wlast(pcie_pif.m_axi_wlast),
                        .m_axi_wvalid(pcie_pif.m_axi_wvalid),
                        //.m_axi_wready(1),
                        .m_axi_wready(pcie_pif.m_axi_wready),

                        //.m_axi_bid(0),
                        .m_axi_bid(pcie_pif.m_axi_bid),

                       //.m_axi_bresp(0),
                         .m_axi_bresp(pcie_pif.m_axi_bresp),

                        //.m_axi_bvalid(1),
                        .m_axi_bvalid(pcie_pif.m_axi_bvalid),

                        .m_axi_bready(pcie_pif.m_axi_bready),
                        .m_axi_arid(pcie_pif.m_axi_arid),
                        .m_axi_araddr(pcie_pif.m_axi_araddr),
                        .m_axi_arlen(pcie_pif.m_axi_arlen),
                        .m_axi_arsize(pcie_pif.m_axi_arsize),
                        .m_axi_arburst(pcie_pif.m_axi_arburst),
                        .m_axi_arlock(pcie_pif.m_axi_arlock),
                        .m_axi_arcache(pcie_pif.m_axi_arcache),
                        .m_axi_arprot(pcie_pif.m_axi_arprot),
                        .m_axi_arvalid(pcie_pif.m_axi_arvalid),
                        //.m_axi_arready(1),
                        .m_axi_arready(pcie_pif.m_axi_arready),

                        //.m_axi_rid(0),
                        .m_axi_rid(pcie_pif.m_axi_rid),

                        //.m_axi_rdata(256'h FFFF_FFFF_FFFF_FFFF),
                        .m_axi_rdata(pcie_pif.m_axi_rdata),

                        //.m_axi_rresp(0),
                        .m_axi_rresp(pcie_pif.m_axi_rresp),

                        //.m_axi_rlast(1),
                        .m_axi_rlast(pcie_pif.m_axi_rlast),

                        //.m_axi_rvalid(1),
                        .m_axi_rvalid(pcie_pif.m_axi_rvalid),

                        .m_axi_rready(pcie_pif.m_axi_rready)

);

//Register interfaces to config_db
  initial begin

    uvm_config_db#(virtual pcie_intf)::set(null,"*","pcie_intf",pcie_pif);

  end

//Run test
  initial begin
    run_test();
  end

  initial begin
	  #10000;
  
$finish;
end
endmodule:top
