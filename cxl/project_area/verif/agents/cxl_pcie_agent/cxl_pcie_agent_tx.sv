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

class cxl_tx extends uvm_sequence_item;
`uvm_object_utils(cxl_tx)
  rand bit [`TLP_DATA_WIDTH-1:0]               cxlio_mctp_req_data;
  rand bit [`TLP_SEG_COUNT*`TLP_HDR_WIDTH-1:0] cxlio_mctp_req_hdr;
  rand bit                                     cxlio_mctp_en;
  bit [191:0]                                  cxlio_mctp_rsp_pkt;

  function new(string name="cxl_tx");
    super.new(name);
  endfunction


  function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field("cxlio_mctp_req_data", this.cxlio_mctp_req_data, 256,   UVM_HEX);
    printer.print_field("cxlio_mctp_req_hdr", this.cxlio_mctp_req_hdr,128,   UVM_HEX);
    printer.print_field("cxlio_mctp_en", this.cxlio_mctp_en,1, UVM_HEX);
    printer.print_field("cxlio_mctp_rsp_pkt",this.cxlio_mctp_rsp_pkt, 192, UVM_HEX);
  endfunction
 
endclass
