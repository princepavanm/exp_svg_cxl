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



class cxl_mem_rand_seq extends cxl_base_seq;
	`uvm_object_utils(cxl_mem_rand_seq)
         cxl_mem_a2f_tx req;
extern function new(string name = "cxl_mem_rand_seq");
extern task body();
endclass
/******************** constructor*********************/
function cxl_mem_rand_seq :: new(string name="cxl_mem_rand_seq");
  super.new(name);	
endfunction

/********************* body task*******************/

task cxl_mem_rand_seq ::body();
  	super.body();
	req=cxl_mem_a2f_tx::type_id::create("req");

`uvm_do_with(req,{	a2f_txcon_req == 1;
			a2f_fatal ==0; 

			a2f_req_is_valid == 1;
			a2f_req_protocol_id == 4'h9;
			a2f_req_header ==128'hAAAAAAAA; 

			a2f_rsp_is_valid ==1; 
			a2f_rsp_protocol_id == 4'h9;
			a2f_rsp_header ==128'HCCCCCCCC;

			a2f_data_is_valid ==1; 
			a2f_data_protocol_id == 4'h9; 
			a2f_data_header ==128'HBBBBBBBB; 
			a2f_data_byte_en ==4'H6; 
			a2f_data_poison ==1; 
			a2f_data_parity ==1; 
			a2f_data_eop ==1; 
			a2f_data_body ==128'hcafef00d; 
			
		
		}) 

endtask	


