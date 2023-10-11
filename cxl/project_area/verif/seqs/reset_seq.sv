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


class reset_seq extends cxl_base_seq;
	`uvm_object_utils(reset_seq)
	reset_tx req;

extern function new(string name = "reset_seq");
extern task body();
endclass
/******************** constructor*********************/
function reset_seq :: new(string name="reset_seq");
  super.new(name);	
endfunction

/********************* body task*******************/

task reset_seq ::body();
  	super.body();
	req=reset_tx::type_id::create("req");
	
	`uvm_do_with(req,{state == 1; cycles == 2;})
        `uvm_do_with(req,{state == 0; cycles == 1;})

endtask	

