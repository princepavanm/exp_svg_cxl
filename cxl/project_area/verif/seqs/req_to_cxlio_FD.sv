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
         cxl_tx req;
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
	req=cxl_tx::type_id::create("req");

	`uvm_do_with(req,{req.cxlio_mctp_en == 1'b1;req.cxlio_mctp_req_hdr == 128'b0_11_10011_0_000_0000_0_0_00_00_0000000100_1111000011110000_00000000_01111111_0000000000000000_0001101010110100_0000_0001_11111111_10101011_1_1_10_1_001;req.cxlio_mctp_req_data[255:191] == 64'b0_0000000_1_0_0_00000_00001011_00000000_0000000000000000_0000000000000000;})

	`uvm_do_with(req,{req.cxlio_mctp_en == 1'b1;req.cxlio_mctp_req_hdr == 128'b0_11_10011_0_000_0000_0_0_00_00_0000000100_1111000011110000_00000000_01111111_0000000000000000_0001101010110100_0000_0001_11111111_10101011_1_1_10_1_001;req.cxlio_mctp_req_data[255:191] == 64'b0_0000000_1_0_0_00000_00001100_00000000_0000000000000000_0000000000000000;})

	`uvm_do_with(req,{req.cxlio_mctp_en == 1'b1;req.cxlio_mctp_req_hdr == 128'b0_11_10010_0_000_0000_0_0_00_00_0000000100_1111000011110000_00000000_01111111_1100101011111110_0001101010110100_0000_0001_00000000_10101011_1_1_10_1_001;req.cxlio_mctp_req_data[255:191] == 64'b0_0000000_1_0_0_00000_00000001_00000000_0000000010101011_0000000000000000;})

endtask	


