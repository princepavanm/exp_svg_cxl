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

// CXL.io MCTP Full Discovery test

class cxlio_FD_test extends cxl_base_test;
	`uvm_component_utils(cxlio_FD_test)
	cxl_virtual_sqr  cxl_virtual_sqr_h;
	virt_req_to_cxlio_FD virt_req_to_cxlio_FD_h;


//----------------------constructor------------------------------------------
function new(string name= "cxlio_FD_test",uvm_component parent);
	super.new(name,parent);
endfunction

//---------------------build_phase----------------------------------
function void  build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

//--------------------------run_phase---------------------------
task run_phase(uvm_phase phase);
	phase.raise_objection(this);
	virt_req_to_cxlio_FD_h=virt_req_to_cxlio_FD::type_id::create("virt_req_to_cxlio_FD_h");
	virt_req_to_cxlio_FD_h.start(env_h.v_sqr_h);
	phase.drop_objection(this);
endtask
endclass
