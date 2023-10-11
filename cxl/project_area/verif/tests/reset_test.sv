class reset_test extends cxl_base_test;
	`uvm_component_utils(reset_test)
	cxl_virtual_sqr  cxl_virtual_sqr_h;
	virt_reset_seq   v_rst_sq;


//----------------------constructor------------------------------------------
function new(string name="reset_test",uvm_component parent);
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
	v_rst_sq.start(env_h.v_sqr_h);
	phase.drop_objection(this);
endtask
endclass
