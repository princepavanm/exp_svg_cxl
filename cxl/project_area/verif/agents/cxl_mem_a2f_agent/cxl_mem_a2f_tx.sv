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

class cxl_mem_a2f_tx extends uvm_sequence_item;
`uvm_object_utils(cxl_mem_a2f_tx)
                               

// CPI Interface Signals 
// Global layer Signals (A2F) Agent to fabric

 rand bit	a2f_txcon_req;
  bit	a2f_rxcon_ack;
  bit	a2f_rxdiscon_nack;
  bit	a2f_rx_empty;
 rand bit	a2f_fatal;

// Request layer Signals (A2F) Agent to fabric
 rand bit        a2f_req_is_valid;
 rand bit[3:0]   a2f_req_protocol_id;
 rand bit[127:0] a2f_req_header;


// Response layer Signals (A2F) Agent to Fabric

 rand bit        a2f_rsp_is_valid;
 rand bit[3:0]   a2f_rsp_protocol_id;
 rand bit[127:0] a2f_rsp_header;
 bit        a2f_rsp_excrd_valid;


// Data layer Signals (A2F) Agent to Fabric
 rand bit              a2f_data_is_valid; 
 rand bit[3:0]         a2f_data_protocol_id;
 rand bit[127:0]       a2f_data_header;
 rand bit[127:0]  a2f_data_body;
 rand bit[3:0]         a2f_data_byte_en;
 rand bit              a2f_data_poison;
 rand bit              a2f_data_parity;
 rand bit              a2f_data_eop;


function new(string name="cxl_mem_a2f_tx");
 	super.new(name);
endfunction

 function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field("a2f_txcon_req", this.a2f_txcon_req, 1,   UVM_HEX);
    printer.print_field("a2f_rxcon_ack", this.a2f_rxcon_ack, 	   1,   UVM_HEX);
    printer.print_field("a2f_rxdiscon_nack", this.a2f_rxdiscon_nack,     1, UVM_HEX);
    printer.print_field("a2f_rx_empty",this.a2f_rx_empty,    1, UVM_HEX);
    printer.print_field("a2f_fatal", this.a2f_fatal,     1,   UVM_HEX);
    printer.print_field("a2f_req_is_valid", this.a2f_req_is_valid, 1,   UVM_HEX);
    printer.print_field("a2f_req_protocol_id", this.a2f_req_protocol_id, 4,   UVM_HEX);
    printer.print_field("a2f_req_header", this.a2f_req_header, 	   128,   UVM_HEX);
    printer.print_field("a2f_data_is_valid", this.a2f_data_is_valid,     1, UVM_HEX);
    printer.print_field("a2f_data_protocol_id",this.a2f_data_protocol_id,    4, UVM_HEX);
    printer.print_field("a2f_data_header", this.a2f_data_header,     128,   UVM_HEX);
    printer.print_field("a2f_data_body", this.a2f_data_body, 128,   UVM_HEX);
    printer.print_field("a2f_data_byte_en", this.a2f_data_byte_en, 	   4,   UVM_HEX);
    printer.print_field("a2f_data_poison", this.a2f_data_poison,     1, UVM_HEX);
    printer.print_field("a2f_data_parity",this.a2f_data_parity,    1, UVM_HEX);
    printer.print_field("a2f_data_eop", this.a2f_data_eop, 	   1,   UVM_HEX);
    printer.print_field("a2f_rsp_is_valid",this.a2f_rsp_is_valid,    1, UVM_HEX);
    printer.print_field("a2f_rsp_protocol_id",this.a2f_rsp_protocol_id,    4, UVM_HEX);
    printer.print_field("a2f_rsp_header",this.a2f_rsp_header,    128, UVM_HEX);
    printer.print_field("a2f_rsp_excrd_valid",this.a2f_rsp_excrd_valid,    1, UVM_HEX);
  endfunction
 
endclass
