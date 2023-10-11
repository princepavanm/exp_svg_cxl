class req_to_axi_traffic_test extends cxl_base_test;
	`uvm_component_utils(req_to_axi_traffic_test)
cxl_virtual_sqr  cxl_virtual_sqr_h;
	virt_mem_wr_req virt_mem_wr_req_h;


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
	virt_mem_wr_req_h=virt_mem_wr_req::type_id::create("virt_mem_wr_req_h");
	virt_mem_wr_req_h.start(env_h.v_sqr_h);
//	#2000;
	phase.drop_objection(this);
endtask
endclass
