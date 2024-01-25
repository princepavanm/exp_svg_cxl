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


class cxl_f2a_rand_test extends cxl_base_test;
	`uvm_component_utils(cxl_f2a_rand_test)

	cxl_virtual_sqr  cxl_virtual_sqr_h;
	
	virt_cxl_mem_f2a virt_cxl_mem_f2a_h;


//----------------------constructor------------------------------------------
function new(string name= "cxl_f2a_rand_test",uvm_component parent);
	super.new(name,parent);
endfunction

//---------------------build_phase----------------------------------
function void  build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

//--------------------------run_phase---------------------------
task run_phase(uvm_phase phase);
	phase.raise_objection(this);
	virt_cxl_mem_f2a_h=virt_cxl_mem_f2a::type_id::create("virt_cxl_mem_f2a_h");

	virt_cxl_mem_f2a_h.start(env_h.v_sqr_h);

	phase.drop_objection(this);
endtask
endclass
