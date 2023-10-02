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
`include "define.sv"

interface pcie_intf(input logic clk, rst);
logic [`TLP_DATA_WIDTH-1:0]                rx_req_tlp_data;
logic [`TLP_SEG_COUNT*`TLP_HDR_WIDTH-1:0]  rx_req_tlp_hdr;
logic [`TLP_SEG_COUNT-1:0]                 rx_req_tlp_valid;
logic [`TLP_SEG_COUNT-1:0]                 rx_req_tlp_sop;
logic [`TLP_SEG_COUNT-1:0]                 rx_req_tlp_eop;
logic                                      rx_req_tlp_ready;

logic [`TLP_DATA_WIDTH-1:0]                 tx_cpl_tlp_data;
logic [`TLP_STRB_WIDTH-1:0]                 tx_cpl_tlp_strb;
logic [`TLP_SEG_COUNT* `TLP_HDR_WIDTH-1:0]  tx_cpl_tlp_hdr;
logic [`TLP_SEG_COUNT-1:0]                  tx_cpl_tlp_valid;
logic [`TLP_SEG_COUNT-1:0]                  tx_cpl_tlp_sop;
logic [`TLP_SEG_COUNT-1:0]                  tx_cpl_tlp_eop;
logic                                       tx_cpl_tlp_ready;

logic  [15:0]                               completer_id;
logic                                       status_error_cor;
logic                                       status_error_uncor;
logic [`AXI_ID_WIDTH-1:0]                   m_axi_awid;
logic [`AXI_ADDR_WIDTH-1:0]                 m_axi_awaddr;
logic [7:0]                                 m_axi_awlen;
logic [2:0]                                 m_axi_awsize;
logic [1:0]                                 m_axi_awburst;
logic                                       m_axi_awlock;
logic [3:0]                                 m_axi_awcache;
logic [2:0]                                 m_axi_awprot;
logic                                       m_axi_awvalid;
logic                                       m_axi_awready;
logic [`AXI_DATA_WIDTH-1:0]                 m_axi_wdata;
logic [`AXI_STRB_WIDTH-1:0]                 m_axi_wstrb;
logic                                       m_axi_wlast;
logic                                       m_axi_wvalid;
logic                                       m_axi_wready;
logic [`AXI_ID_WIDTH-1:0]                   m_axi_bid;
logic [1:0]                                 m_axi_bresp;
logic                                       m_axi_bvalid;
logic                                       m_axi_bready;
logic [`AXI_ID_WIDTH-1:0]                   m_axi_arid;
logic [`AXI_ADDR_WIDTH-1:0]                 m_axi_araddr;
logic [7:0]                                 m_axi_arlen;
logic [2:0]                                 m_axi_arsize;
logic [1:0]                                 m_axi_arburst;
logic                                       m_axi_arlock;
logic [3:0]                                 m_axi_arcache;
logic [2:0]                                 m_axi_arprot;
logic                                       m_axi_arvalid;
logic                                       m_axi_arready;
logic [`AXI_ID_WIDTH-1:0]                   m_axi_rid;
logic [`AXI_DATA_WIDTH-1:0]                 m_axi_rdata;
logic [1:0]                                 m_axi_rresp;
logic                                       m_axi_rlast;
logic                                       m_axi_rvalid;
logic                                       m_axi_rready;

endinterface:pcie_intf
