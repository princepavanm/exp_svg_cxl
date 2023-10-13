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
//`include "define.sv"

interface pcie_intf(input logic clk);
//RESET
logic                                       rst;
//REQUEST
logic [`TLP_DATA_WIDTH-1:0]                 rx_req_tlp_data;
logic [`TLP_SEG_COUNT*`TLP_HDR_WIDTH-1:0]   rx_req_tlp_hdr;
logic [`TLP_SEG_COUNT-1:0]                  rx_req_tlp_valid;
logic [`TLP_SEG_COUNT-1:0]                  rx_req_tlp_sop;
logic [`TLP_SEG_COUNT-1:0]                  rx_req_tlp_eop;
logic                                       rx_req_tlp_ready;

//COMPLETION
logic [`TLP_DATA_WIDTH-1:0]                 tx_cpl_tlp_data;
logic [`TLP_STRB_WIDTH-1:0]                 tx_cpl_tlp_strb;
logic [`TLP_SEG_COUNT* `TLP_HDR_WIDTH-1:0]  tx_cpl_tlp_hdr;
logic [`TLP_SEG_COUNT-1:0]                  tx_cpl_tlp_valid;
logic [`TLP_SEG_COUNT-1:0]                  tx_cpl_tlp_sop;
logic [`TLP_SEG_COUNT-1:0]                  tx_cpl_tlp_eop;
logic                                       tx_cpl_tlp_ready;

//CONGIGURATION
logic [15:0]                                completer_id;
logic [2:0]                                 max_payload_size;

//STATUS
logic                                       status_error_cor;
logic                                       status_error_uncor;

//AXI
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

clocking dri_cb@(posedge clk);
    default input #1 output #0;
output completer_id;
output max_payload_size;
output rx_req_tlp_data;
output rx_req_tlp_hdr;
output rx_req_tlp_valid;
output rx_req_tlp_sop;
output rx_req_tlp_eop;
input rx_req_tlp_ready;

  endclocking


clocking comp_drv_cb@(posedge clk);
    default input #1 output #1;
 input tx_cpl_tlp_data;
input tx_cpl_tlp_strb;
input tx_cpl_tlp_hdr;   
input tx_cpl_tlp_valid;
input tx_cpl_tlp_sop;
input tx_cpl_tlp_eop;
output tx_cpl_tlp_ready;
endclocking


clocking axi_drv_cb@(posedge clk);
    default input #1 output #0;
    input      m_axi_awid;
    input      m_axi_awaddr;
    input      m_axi_awlen;
    input      m_axi_awsize;
    input      m_axi_awburst;
    input      m_axi_awlock;
    input      m_axi_awcache;
    input      m_axi_awprot;
    input      m_axi_awvalid;
    output     m_axi_awready;

    input      m_axi_wdata;
    input      m_axi_wstrb;
    input      m_axi_wlast;
    input      m_axi_wvalid;

    output       m_axi_wready;
    output       m_axi_bid;
    output       m_axi_bresp;
    output       m_axi_bvalid;

    input      m_axi_bready;
    input      m_axi_arid;
    input      m_axi_araddr;
    input      m_axi_arlen;
    input      m_axi_arsize;
    input      m_axi_arburst;
    input      m_axi_arlock;
    input      m_axi_arcache;
    input      m_axi_arprot;
    input      m_axi_arvalid;

    output       m_axi_arready;
    output       m_axi_rid;
    output       m_axi_rdata;
    output       m_axi_rresp;
    output       m_axi_rlast;
    output       m_axi_rvalid;

    input      m_axi_rready;

  endclocking
  
 modport dri_mp(clocking dri_cb);
 modport axi_drv_mp(clocking axi_drv_cb);
 modport comp_drv_mp(clocking comp_drv_cb);

 clocking mon_cb@(posedge clk);
    default input #1 output #1;
    
input completer_id; 
input max_payload_size;
input rx_req_tlp_data;
input rx_req_tlp_hdr;
input rx_req_tlp_valid;
input rx_req_tlp_sop;
input rx_req_tlp_eop;
input rx_req_tlp_ready;

  endclocking

 
  modport mon_mp(clocking mon_cb);


endinterface:pcie_intf
