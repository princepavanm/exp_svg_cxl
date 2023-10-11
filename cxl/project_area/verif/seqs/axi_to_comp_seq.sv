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


class axi_to_comp_seq extends cxl_base_seq;
	`uvm_object_utils(axi_to_comp_seq)
	axi_agent_tx req;

extern function new(string name = "axi_to_comp_seq");
extern task body();
endclass
/******************** constructor*********************/
function axi_to_comp_seq :: new(string name="axi_to_comp_seq");
  super.new(name);	
endfunction

/********************* body task*******************/

task axi_to_comp_seq ::body();
  	super.body();
	req=axi_agent_tx::type_id::create("req");
	
	`uvm_do_with(req,{m_axi_awready == 1 ;m_axi_wready == 1;m_axi_bid == 0;m_axi_bresp == 0;m_axi_bvalid == 1;m_axi_arready == 1;m_axi_rid == 0 ;m_axi_rdata == 256'h FFFF_FFFF_FFFF_FFFF;m_axi_rresp == 0;m_axi_rlast ==  1;m_axi_rvalid == 1;})

endtask	

