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
//`include "pcie_axi_master.v"
`include "define.sv"
module top;

    /*
     * TLP input (request)
     */
   // reg [`TLP_DATA_WIDTH-1:0]                rx_req_tlp_data;
   // reg [`TLP_SEG_COUNT*`TLP_HDR_WIDTH-1:0]  rx_req_tlp_hdr;
   // reg [`TLP_SEG_COUNT-1:0]                 rx_req_tlp_valid;
   // reg [`TLP_SEG_COUNT-1:0]                 rx_req_tlp_sop;
   // reg [`TLP_SEG_COUNT-1:0]                 rx_req_tlp_eop;
   // wire                                     rx_req_tlp_ready;

   // /*
   //  * TLP output (completion)
   //  */
   //  wire [`TLP_DATA_WIDTH-1:0]                 tx_cpl_tlp_data;
   //  wire [`TLP_STRB_WIDTH-1:0]                 tx_cpl_tlp_strb;
   //  wire [`TLP_SEG_COUNT* `TLP_HDR_WIDTH-1:0]  tx_cpl_tlp_hdr;
   //  wire [`TLP_SEG_COUNT-1:0]                  tx_cpl_tlp_valid;
   //  wire [`TLP_SEG_COUNT-1:0]                  tx_cpl_tlp_sop;
   //  wire [`TLP_SEG_COUNT-1:0]                  tx_cpl_tlp_eop;
   //  reg                                        tx_cpl_tlp_ready;


   //     /*
   //  * Configuration
   //  */
   //  reg [15:0]                                 completer_id;

   // /*
   //  * Status
   //  */
   //  wire                                       status_error_cor;
   //  wire                                       status_error_uncor;

   //  wire [`AXI_ID_WIDTH-1:0]                   m_axi_awid;
   //  wire [`AXI_ADDR_WIDTH-1:0]                 m_axi_awaddr;
   //  wire [7:0]                                 m_axi_awlen;
   //  wire [2:0]                                 m_axi_awsize;
   //  wire [1:0]                                 m_axi_awburst;
   //  wire                                       m_axi_awlock;
   //  wire [3:0]                                 m_axi_awcache;
   //  wire [2:0]                                 m_axi_awprot;
   //  wire                                       m_axi_awvalid;
   //  reg                                        m_axi_awready;
   //  wire [`AXI_DATA_WIDTH-1:0]                 m_axi_wdata;
   //  wire [`AXI_STRB_WIDTH-1:0]                 m_axi_wstrb;
   //  wire                                       m_axi_wlast;
   //  wire                                       m_axi_wvalid;
   //  reg                                        m_axi_wready;
   //  reg [`AXI_ID_WIDTH-1:0]                    m_axi_bid;
   //  reg [1:0]                                  m_axi_bresp;
   //  reg                                        m_axi_bvalid;
   //  wire                                       m_axi_bready;
   //  wire [`AXI_ID_WIDTH-1:0]                   m_axi_arid;
   //  wire [`AXI_ADDR_WIDTH-1:0]                 m_axi_araddr;
   //  wire [7:0]                                 m_axi_arlen;
   //  wire [2:0]                                 m_axi_arsize;
   //  wire [1:0]                                 m_axi_arburst;
   //  wire                                       m_axi_arlock;
   //  wire [3:0]                                 m_axi_arcache;
   //  wire [2:0]                                 m_axi_arprot;
   //  wire                                       m_axi_arvalid;
   //  reg                                        m_axi_arready;
   //  reg [`AXI_ID_WIDTH-1:0]                    m_axi_rid;
   //  reg [`AXI_DATA_WIDTH-1:0]                  m_axi_rdata;
   //  reg [1:0]                                  m_axi_rresp;
   //  reg                                        m_axi_rlast;
   //  reg                                        m_axi_rvalid;
   //  wire                                       m_axi_rready;




     

//Rst and clock declarations
  reg clk, rst;

//Interface instantation
  pcie_intf pcie_pif(clk, rst);

//Rst and Clock generation
  initial begin

    clk = 0;

    rst = 1;
    #7.0;	rst = 0;

    #500us;
    $finish();
  end

  always #(10/2) clk = ~clk;

//DUT Instantiation
/*pcie_axi_master dut(.clk(clk),
			.rst(rst),
                        .rx_req_tlp_data(rx_req_tlp_data),
                        .rx_req_tlp_hdr(rx_req_tlp_hdr),
                        .rx_req_tlp_valid(rx_req_tlp_valid),
                        .rx_req_tlp_sop(rx_req_tlp_sop),
                        .rx_req_tlp_eop(rx_req_tlp_eop),
                        .rx_req_tlp_ready(rx_req_tlp_ready),
                        
                        .tx_cpl_tlp_data(tx_cpl_tlp_data),
                        .tx_cpl_tlp_strb(tx_cpl_tlp_strb),
                        .tx_cpl_tlp_hdr(tx_cpl_tlp_hdr),
                        .tx_cpl_tlp_valid(tx_cpl_tlp_valid),
                        .tx_cpl_tlp_sop(tx_cpl_tlp_sop),
                        .tx_cpl_tlp_eop(tx_cpl_tlp_eop),
                        .tx_cpl_tlp_ready(tx_cpl_tlp_ready),
 
                        .completer_id(completer_id),
                        .status_error_cor(status_error_cor),
                        .status_error_uncor(status_error_uncor),

                        .m_axi_awid(m_axi_awid),
                        .m_axi_awaddr(m_axi_awaddr),
                        .m_axi_awlen(m_axi_awlen),
                        .m_axi_awsize(m_axi_awsize),
                        .m_axi_awburst(m_axi_awburst),
                        .m_axi_awlock(m_axi_awlock),
                        .m_axi_awcache(m_axi_awcache),
                        .m_axi_awprot(m_axi_awprot),
                        .m_axi_awvalid(m_axi_awvalid),
                        .m_axi_awready(m_axi_awready),
                        .m_axi_wdata(m_axi_wdata),
                        .m_axi_wstrb(m_axi_wstrb),
                        .m_axi_wlast(m_axi_wlast),
                        .m_axi_wvalid(m_axi_wvalid),
                        .m_axi_wready(m_axi_wready),
                        .m_axi_bid(m_axi_bid),
                        .m_axi_bresp(m_axi_bresp),
                        .m_axi_bvalid(m_axi_bvalid),
                        .m_axi_bready(m_axi_bready),
                        .m_axi_arid(m_axi_arid),
                        .m_axi_araddr(m_axi_araddr),
                        .m_axi_arlen(m_axi_arlen),
                        .m_axi_arsize(m_axi_arsize),
                        .m_axi_arburst(m_axi_arburst),
                        .m_axi_arlock(m_axi_arlock),
                        .m_axi_arcache(m_axi_arcache),
                        .m_axi_arprot(m_axi_arprot),
                        .m_axi_arvalid(m_axi_arvalid),
                        .m_axi_arready(m_axi_arready),
                        .m_axi_rid(m_axi_rid),
                        .m_axi_rdata(m_axi_rdata),
                        .m_axi_rresp(m_axi_rresp),
                        .m_axi_rlast(m_axi_rlast),
                        .m_axi_rvalid(m_axi_rvalid),
                        .m_axi_rready(m_axi_rready)

);*/


//DUT Instantiation
pcie_axi_master dut(.clk(pcie_pif.clk),
			.rst(pcie_pif.rst),
                        .rx_req_tlp_data(pcie_pif.rx_req_tlp_data),
                        .rx_req_tlp_hdr(pcie_pif.rx_req_tlp_hdr),
                        .rx_req_tlp_valid(pcie_pif.rx_req_tlp_valid),
                        .rx_req_tlp_sop(pcie_pif.rx_req_tlp_sop),
                        .rx_req_tlp_eop(pcie_pif.rx_req_tlp_eop),
                        .rx_req_tlp_ready(pcie_pif.rx_req_tlp_ready),
                        
                        .tx_cpl_tlp_data(pcie_pif.tx_cpl_tlp_data),
                        .tx_cpl_tlp_strb(pcie_pif.tx_cpl_tlp_strb),
                        .tx_cpl_tlp_hdr(pcie_pif.tx_cpl_tlp_hdr),
                        .tx_cpl_tlp_valid(pcie_pif.tx_cpl_tlp_valid),
                        .tx_cpl_tlp_sop(pcie_pif.tx_cpl_tlp_sop),
                        .tx_cpl_tlp_eop(pcie_pif.tx_cpl_tlp_eop),
                        .tx_cpl_tlp_ready(pcie_pif.tx_cpl_tlp_ready),
 
                        .completer_id(pcie_pif.completer_id),
                        .status_error_cor(pcie_pif.status_error_cor),
                        .status_error_uncor(pcie_pif.status_error_uncor),

                        .m_axi_awid(pcie_pif.m_axi_awid),
                        .m_axi_awaddr(pcie_pif.m_axi_awaddr),
                        .m_axi_awlen(pcie_pif.m_axi_awlen),
                        .m_axi_awsize(pcie_pif.m_axi_awsize),
                        .m_axi_awburst(pcie_pif.m_axi_awburst),
                        .m_axi_awlock(pcie_pif.m_axi_awlock),
                        .m_axi_awcache(pcie_pif.m_axi_awcache),
                        .m_axi_awprot(pcie_pif.m_axi_awprot),
                        .m_axi_awvalid(pcie_pif.m_axi_awvalid),
                        .m_axi_awready(pcie_pif.m_axi_awready),
                        .m_axi_wdata(pcie_pif.m_axi_wdata),
                        .m_axi_wstrb(pcie_pif.m_axi_wstrb),
                        .m_axi_wlast(pcie_pif.m_axi_wlast),
                        .m_axi_wvalid(pcie_pif.m_axi_wvalid),
                        .m_axi_wready(pcie_pif.m_axi_wready),
                        .m_axi_bid(pcie_pif.m_axi_bid),
                        .m_axi_bresp(pcie_pif.m_axi_bresp),
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
                        .m_axi_arready(pcie_pif.m_axi_arready),
                        .m_axi_rid(pcie_pif.m_axi_rid),
                        .m_axi_rdata(pcie_pif.m_axi_rdata),
                        .m_axi_rresp(pcie_pif.m_axi_rresp),
                        .m_axi_rlast(pcie_pif.m_axi_rlast),
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

  /*initial begin
	  #1000;
  
$finish;
end*/
endmodule:top
