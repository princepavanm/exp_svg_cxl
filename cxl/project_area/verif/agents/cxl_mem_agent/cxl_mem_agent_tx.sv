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

class cxl_mem_tx extends uvm_sequence_item;
`uvm_object_utils(cxl_mem_tx)



//clk and reset
 bit                                                   fm_clk;
 bit                                                   fm_rst;


// CPI Interface Signals 
// Global layer Signals (A2F) Agent to fabric

bit                                                  a2f_txcon_req;
bit                                                 a2f_rxcon_ack;
bit                                                 a2f_rxdiscon_nack;
bit                                                 a2f_rx_empty;
bit                                                 a2f_fatal;

// Global layer Signals (F2A) Fabric to Agent

bit                                                f2a_txcon_req;
bit                                                f2a_rxcon_ack;
bit                                                f2a_rxdiscon_nack;
bit                                                f2a_rx_empty;
bit                                                f2a_fatal;

// Request layer Signals (A2F) Agent to fabric

bit                                                  a2f_req_is_valid;
bit[3:0]                                             a2f_req_protocol_id;
bit[128:0]                                           a2f_req_header;


// Request layer Signals (F2A) Fabric to Agent

bit                                                 f2a_req_is_valid;
bit[3:0]                                            f2a_req_protocol_id;
bit[128:0]                                          f2a_req_header;



// Response layer Signals (A2F) Agent to Fabric

bit                                                  a2f_rsp_is_valid;
bit[3:0]                                             a2f_rsp_protocol_id;
bit[128:0]                                           a2f_rsp_header;
bit                                                 a2f_rsp_excrd_valid;


// Response layer Signals (F2A) Fabric to Agent

bit                                                 f2a_rsp_is_valid;
bit[3:0]                                            f2a_rsp_protocol_id;
bit[128:0]                                          f2a_rsp_header;
bit                                                  f2a_rsp_excrd_valid;

// Data layer Signals (A2F) Agent to Fabric

bit                                                  a2f_data_is_valid;             
bit[3:0]                                             a2f_data_protocol_id;
bit[127:0]                                           a2f_data_header;
bit[127:0]                                           a2f_data_body;
bit[3:0]                                             a2f_data_byte_en;
bit                                                  a2f_data_poison;
bit                                                  a2f_data_parity;
bit                                                  a2f_data_eop;


// Data layer Signals (F2A) Fabric to Agent

bit                                                 f2a_data_is_valid;                   
bit[3:0]                                            f2a_data_protocol_id;
bit[127:0]                                          f2a_data_header;
bit[127:0]                                          f2a_data_body;
bit[3:0]                                            f2a_data_byte_en;
bit                                                 f2a_data_poison;
bit                                                 f2a_data_parity;
bit                                                 f2a_data_eop;




  function new(string name="cxl_mem_tx");
    super.new(name);
  endfunction


  function void do_print(uvm_printer printer);
    super.do_print(printer);
  endfunction
 
endclass
