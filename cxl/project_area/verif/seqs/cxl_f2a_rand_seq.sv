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



class cxl_f2a_rand_seq extends cxl_base_seq;

	`uvm_object_utils(cxl_f2a_rand_seq)

         cxl_mem_f2a_tx req;

extern function new(string name = "cxl_f2a_rand_seq");
extern task body();
endclass

/******************** constructor*********************/
function cxl_f2a_rand_seq :: new(string name="cxl_f2a_rand_seq");
  super.new(name);	
endfunction

/********************* body task*******************/

task cxl_f2a_rand_seq ::body();
  	super.body();
	req=cxl_mem_f2a_tx::type_id::create("req");

`uvm_do_with(req,{	f2a_rxcon_ack == 1;
			f2a_rxdiscon_nack ==1; 
			f2a_rx_empty == 1;

			f2a_rsp_excrd_valid == 1;

					
		
		}) 

endtask	


