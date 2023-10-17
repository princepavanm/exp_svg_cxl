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

class req_to_axi_traffic_test extends cxl_base_test;
	`uvm_component_utils(req_to_axi_traffic_test)
cxl_virtual_sqr  cxl_virtual_sqr_h;
	virt_mem_wr_req virt_mem_wr_req_h;
	virt_reset_seq   v_rst_sq;


//----------------------constructor------------------------------------------
function new(string name="req_to_axi_traffic_test",uvm_component parent);
	super.new(name,parent);
endfunction

//---------------------build_phase----------------------------------
function void  build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

//--------------------------run_phase---------------------------
task run_phase(uvm_phase phase);
	phase.raise_objection(this);
	v_rst_sq=virt_reset_seq::type_id::create("v_rst_sq");
	virt_mem_wr_req_h=virt_mem_wr_req::type_id::create("virt_mem_wr_req_h");
	v_rst_sq.start(env_h.v_sqr_h);
	virt_mem_wr_req_h.start(env_h.v_sqr_h);
	#1000;
	phase.drop_objection(this);
endtask
endclass
