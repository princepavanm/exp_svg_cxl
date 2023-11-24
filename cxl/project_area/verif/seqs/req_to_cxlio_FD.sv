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


/**********************memory write request sequence************************/


class req_to_cxlio_FD extends cxl_base_seq;
	`uvm_object_utils(req_to_cxlio_FD)

extern function new(string name = "req_to_cxlio_FD");
extern task body();
endclass
/******************** constructor*********************/
function req_to_cxlio_FD :: new(string name="req_to_cxlio_FD");
  super.new(name);	
endfunction

/********************* body task*******************/

task req_to_cxlio_FD ::body();
  	super.body();
	req=req_tx::type_id::create("req");

	`uvm_do_with(req,{req.cxlio_mctp_en == 1'b1;req.rx_req_tlp_hdr == 128'b01110101110100110010000000001111000000000000111100111100000011110000000000000000000011110000111100110001001111000000111111111010;})

endtask	


