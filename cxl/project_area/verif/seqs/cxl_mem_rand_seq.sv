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


class cxl_mem_rand_seq extends cxl_base_seq;
	`uvm_object_utils(cxl_mem_rand_seq)
         cxl_mem_tx req;
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
	req=cxl_mem_tx::type_id::create("req");

endtask	


