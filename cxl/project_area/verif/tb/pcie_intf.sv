//////////////////////////////////////////////////////////////////////////////////
// Company:  Expolog Technologies.
//           Copyright (c) 2023 by Expolog Technologies, Inc. All rights reserved.
//
// Engineer : 
// Revision tag :
// Module Name      :    
// Project Name      : 
// component name : 
// Description: 
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

//CXLIO Signals
logic [`TLP_DATA_WIDTH-1:0]               cxlio_mctp_req_data;
logic [`TLP_SEG_COUNT*`TLP_HDR_WIDTH-1:0] cxlio_mctp_req_hdr;
logic                                     cxlio_mctp_en;
logic [191:0]                             cxlio_mctp_rsp_pkt;

//Fabric Manager
//
//clk and reset
logic                            	fm_clk;
logic                                   fm_rst;


// CPI Interface Signals 
// Global layer Signals (A2F) Agent to fabric

logic                                        a2f_txcon_req;
logic                                        a2f_rxcon_ack;
logic                                        a2f_rxdiscon_nack;
logic                                        a2f_rx_empty;
logic                                        a2f_fatal;

// Global layer Signals (F2A) Fabric to Agent

 logic                                       f2a_txcon_req;
 logic                                       f2a_rxcon_ack;
 logic                                       f2a_rxdiscon_nack;
 logic                                       f2a_rx_empty;
 logic                                       f2a_fatal;

// Request layer Signals (A2F) Agent to fabric

logic                                        a2f_req_is_valid;
logic [3:0]                                    a2f_req_protocol_id;
logic [128:0]                                       a2f_req_header;


// Request layer Signals (F2A) Fabric to Agent

logic                                        f2a_req_is_valid;
logic  [3:0]                                      f2a_req_protocol_id;
logic   [127:0]                                     f2a_req_header;



// Response layer Signals (A2F) Agent to Fabric

 logic                                        a2f_rsp_is_valid;
 logic  [3:0]                                      a2f_rsp_protocol_id;
 logic  [127:0]                                      a2f_rsp_header;
 logic                                        a2f_rsp_excrd_valid;


// Response layer Signals (F2A) Fabric to Agent

logic                                          f2a_rsp_is_valid;
logic  [3:0]                                        f2a_rsp_protocol_id;
logic  [127:0]                                        f2a_rsp_header;
logic                                          f2a_rsp_excrd_valid;

// Data layer Signals (A2F) Agent to Fabric

logic                                         a2f_data_is_valid;             
logic   [3:0]                                      a2f_data_protocol_id;
logic   [127:0]                                      a2f_data_header;
logic   [127:0]                                      a2f_data_body;
logic    [3:0]                                     a2f_data_byte_en;
logic                                         a2f_data_poison;
logic                                         a2f_data_parity;
logic                                         a2f_data_eop;


// Data layer Signals (F2A) Fabric to Agent

logic                                        f2a_data_is_valid;                   
logic   [3:0]                                f2a_data_protocol_id;
logic   [127:0]                                     f2a_data_header;
logic   [127:0]                                     f2a_data_body;
logic    [3:0]                                    f2a_data_byte_en;
logic                                        f2a_data_poison;
logic                                        f2a_data_parity;
logic                                        f2a_data_eop;





//=====================================================================
//request driver clocking block
//=====================================================================
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


//=====================================================================
//completion  driver clocking block
//=====================================================================
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


//=====================================================================
//AXI driver clocking block
//=====================================================================
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

    	output     m_axi_wready;
    	output     m_axi_bid;
    	output     m_axi_bresp;
    	output     m_axi_bvalid;

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

    	output     m_axi_arready;
    	output     m_axi_rid;
    	output     m_axi_rdata;
    	output     m_axi_rresp;
    	output     m_axi_rlast;
    	output     m_axi_rvalid;

    	input      m_axi_rready;

  endclocking
  

//=====================================================================
//request Monitor clocking block
//=====================================================================
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

//=====================================================================
//Completion Monitor clocking block
//=====================================================================
clocking comp_mon@(posedge clk);
	default input #1 output #0;
	input tx_cpl_tlp_data; 
	input tx_cpl_tlp_strb; 
	input tx_cpl_tlp_hdr;
	input tx_cpl_tlp_valid;
	input tx_cpl_tlp_sop; 
	input tx_cpl_tlp_eop;
	input tx_cpl_tlp_ready;
endclocking 

//=====================================================================
//AXI Monitor clocking block
//=====================================================================
clocking axi_mon_cb@(posedge clk);
    	default input #1 output #1;
    	input      m_axi_awid;
    	input      m_axi_awaddr;
    	input      m_axi_awlen;
    	input      m_axi_awsize;
    	input      m_axi_awburst;
    	input      m_axi_awlock;
    	input      m_axi_awcache;
    	input      m_axi_awprot;
    	input      m_axi_awvalid;
    	input      m_axi_awready;

    	input      m_axi_wdata;
    	input      m_axi_wstrb;
    	input      m_axi_wlast;
    	input      m_axi_wvalid;

    	input      m_axi_wready;
    	input      m_axi_bid;
    	input      m_axi_bresp;
    	input      m_axi_bvalid;

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

    	input      m_axi_arready;
    	input      m_axi_rid;
    	input      m_axi_rdata;
    	input      m_axi_rresp;
    	input      m_axi_rlast;
    	input      m_axi_rvalid;

    	input      m_axi_rready;

endclocking


//=====================================================================
//CXLIO driver clocking block
//=====================================================================
 clocking cxlio_drv@(posedge clk);
  default input #0 output #0;
  output       cxlio_mctp_req_data;
  output       cxlio_mctp_req_hdr;
  output       cxlio_mctp_en;
  output       cxlio_mctp_rsp_pkt;
endclocking 


//=====================================================================
//CXLIO mon clocking block
//=====================================================================
 clocking cxlio_mon@(posedge clk);
  default input #0 output #0;
  input       cxlio_mctp_req_data;
  input       cxlio_mctp_req_hdr;
  input       cxlio_mctp_en;
  input       cxlio_mctp_rsp_pkt;
endclocking 


//=====================================================================
//cxl mem a2f driver clocking block
//=====================================================================

 clocking cxla2f_drv@(posedge clk);
  default input #0 output #0;

output      a2f_txcon_req;
input       a2f_rxcon_ack;
input       a2f_rxdiscon_nack;
input       a2f_rx_empty;
output      a2f_fatal;

output      a2f_req_is_valid;
output      a2f_req_protocol_id;
output      a2f_req_header;


output      a2f_rsp_is_valid;
output      a2f_rsp_protocol_id;
output      a2f_rsp_header;
input       a2f_rsp_excrd_valid;

output      a2f_data_is_valid;             
output      a2f_data_protocol_id;
output      a2f_data_header;
output      a2f_data_body;
output      a2f_data_byte_en;
output      a2f_data_poison;
output      a2f_data_parity;
output      a2f_data_eop;

 endclocking 






//=====================================================================
//cxl mem a2f mon clocking block
//=====================================================================
 clocking cxla2f_mon@(posedge clk);
  default input #0 output #0;
input     a2f_txcon_req;
input     a2f_rxcon_ack;
input     a2f_rxdiscon_nack;
input     a2f_rx_empty;
input     a2f_fatal;


input     a2f_req_is_valid;
input     a2f_req_protocol_id;
input     a2f_req_header;



input     a2f_rsp_is_valid;
input     a2f_rsp_protocol_id;
input     a2f_rsp_header;
input     a2f_rsp_excrd_valid;



input     a2f_data_is_valid;             
input     a2f_data_protocol_id;
input     a2f_data_header;
input     a2f_data_body;
input     a2f_data_byte_en;
input     a2f_data_poison;
input     a2f_data_parity;
input     a2f_data_eop;
  
endclocking 







//=====================================================================
//cxl mem f2a driver clocking block
//=====================================================================
 clocking cxlf2a_drv@(posedge clk);
  default input #0 output #0;


input    	f2a_txcon_req;
output     	f2a_rxcon_ack;
output     	f2a_rxdiscon_nack;
output     	f2a_rx_empty;
input    	f2a_fatal;

input   	f2a_req_is_valid;
input   	f2a_req_protocol_id;
input   	f2a_req_header;

input   	f2a_rsp_is_valid;
input   	f2a_rsp_protocol_id;
input   	f2a_rsp_header;
output    	f2a_rsp_excrd_valid;


input   	f2a_data_is_valid;                   
input   	f2a_data_protocol_id;
input   	f2a_data_header;
input   	f2a_data_body;
input   	f2a_data_byte_en;
input   	f2a_data_poison;
input   	f2a_data_parity;
input   	f2a_data_eop;

  
 endclocking 






//=====================================================================
//cxl mem f2a mon clocking block
//=====================================================================

 clocking cxlf2a_mon@(posedge clk);
  default input #0 output #0;


input       f2a_txcon_req;
input       f2a_rxcon_ack;
input       f2a_rxdiscon_nack;
input       f2a_rx_empty;
input       f2a_fatal;


input       f2a_req_is_valid;
input       f2a_req_protocol_id;
input       f2a_req_header;


input       f2a_rsp_is_valid;
input       f2a_rsp_protocol_id;
input       f2a_rsp_header;
input       f2a_rsp_excrd_valid;


input       f2a_data_is_valid;                   
input       f2a_data_protocol_id;
input       f2a_data_header;
input       f2a_data_body;
input       f2a_data_byte_en;
input       f2a_data_poison;
input       f2a_data_parity;
input       f2a_data_eop;
  
  endclocking 









//=====================================================================
//Modport's
//=====================================================================
 modport mon_mp(clocking mon_cb);
 modport dri_mp(clocking dri_cb);

 modport axi_drv_mp(clocking axi_drv_cb);
 modport comp_drv_mp(clocking comp_drv_cb);

 modport comp_mon_mp(clocking comp_mon);
 modport axi_mon_mp(clocking axi_mon_cb);

 modport cxlio_drv_mp(clocking cxlio_drv);
 modport cxlio_mon_mp(clocking cxlio_mon);

 modport cxla2f_drv_mp(clocking cxla2f_drv);
 modport cxla2f_mon_mp(clocking cxla2f_mon);

 modport cxlf2a_drv_mp(clocking cxlf2a_drv);
 modport cxlf2a_mon_mp(clocking cxlf2a_mon);
 endinterface:pcie_intf
