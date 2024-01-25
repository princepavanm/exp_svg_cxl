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

class cxl_mem_f2a_tx extends uvm_sequence_item;
`uvm_object_utils(cxl_mem_f2a_tx)
                               

// Global layer Signals (F2A) Fabric to Agent

  bit	f2a_txcon_req;
 rand bit	f2a_rxcon_ack;
 rand bit	f2a_rxdiscon_nack;
  rand bit	f2a_rx_empty;
  bit	f2a_fatal;

// Request layer Signals (F2A) Fabric to Agent

 bit                                                 f2a_req_is_valid;
 bit[3:0]                                            f2a_req_protocol_id;
 bit[127:0]                                          f2a_req_header;

// Response layer Signals (F2A) Fabric to Agent

 bit                                                 f2a_rsp_is_valid;
 bit[3:0]                                            f2a_rsp_protocol_id;
 bit[127:0]                                          f2a_rsp_header;
 rand bit                                                 f2a_rsp_excrd_valid;

// Data layer Signals (F2A) Fabric to Agent

 bit                                                 f2a_data_is_valid;                   
 bit[3:0]                                            f2a_data_protocol_id;
 bit[127:0]                                          f2a_data_header;
 bit[127:0]                                          f2a_data_body;
 bit[3:0]                                            f2a_data_byte_en;
 bit                                                 f2a_data_poison;
 bit                                                 f2a_data_parity;
 bit                                                 f2a_data_eop;



function new(string name="cxl_mem_f2a_tx");
	super.new(name);
endfunction

function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field("f2a_txcon_req", this.f2a_txcon_req, 1,   UVM_HEX);
    printer.print_field("f2a_rxcon_ack", this.f2a_rxcon_ack, 	   1,   UVM_HEX);
    printer.print_field("f2a_rxdiscon_nack", this.f2a_rxdiscon_nack,     1, UVM_HEX);
    printer.print_field("f2a_rx_empty",this.f2a_rx_empty,    1, UVM_HEX);
    printer.print_field("f2a_fatal", this.f2a_fatal,     1,   UVM_HEX);
    printer.print_field("f2a_req_is_valid", this.f2a_req_is_valid, 1,   UVM_HEX);
    printer.print_field("f2a_req_protocol_id", this.f2a_req_protocol_id, 4,   UVM_HEX);
    printer.print_field("f2a_req_header", this.f2a_req_header, 	   128,   UVM_HEX);
    printer.print_field("f2a_data_is_valid", this.f2a_data_is_valid,     1, UVM_HEX);
    printer.print_field("f2a_data_protocol_id",this.f2a_data_protocol_id,    4, UVM_HEX);
    printer.print_field("f2a_data_header", this.f2a_data_header,     128,   UVM_HEX);
    printer.print_field("f2a_data_body", this.f2a_data_body, 128,   UVM_HEX);
    printer.print_field("f2a_data_byte_en", this.f2a_data_byte_en, 	   4,   UVM_HEX);
    printer.print_field("f2a_data_poison", this.f2a_data_poison,     1, UVM_HEX);
    printer.print_field("f2a_data_parity",this.f2a_data_parity,    1, UVM_HEX);
    printer.print_field("f2a_data_eop", this.f2a_data_eop, 	   1,   UVM_HEX);
    printer.print_field("f2a_rsp_is_valid",this.f2a_rsp_is_valid,    1, UVM_HEX);
    printer.print_field("f2a_rsp_protocol_id",this.f2a_rsp_protocol_id,    4, UVM_HEX);
    printer.print_field("f2a_rsp_header",this.f2a_rsp_header,    128, UVM_HEX);
    printer.print_field("f2a_rsp_excrd_valid",this.f2a_rsp_excrd_valid,    1, UVM_HEX);
  endfunction

 
endclass
