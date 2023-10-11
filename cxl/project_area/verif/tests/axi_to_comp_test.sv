class axi_to_comp_test extends cxl_base_test;
	`uvm_component_utils(axi_to_comp_test)
	cxl_virtual_sqr  cxl_virtual_sqr_h;
	virt_axi_to_comp_seq   v_a2c_sq;
	virt_reset_seq   v_rst_sq;

//----------------------constructor------------------------------------------
function new(string name="axi_to_comp_test",uvm_component parent);
	super.new(name,parent);
endfunction

//---------------------build_phase----------------------------------
function void  build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

//--------------------------run_phase---------------------------
task run_phase(uvm_phase phase);
	phase.raise_objection(this);
	v_a2c_sq=virt_axi_to_comp_seq::type_id::create("v_a2c_sq");
	v_rst_sq=virt_reset_seq::type_id::create("v_rst_sq");
	v_rst_sq.start(env_h.v_sqr_h); // 1st reset seq
	v_a2c_sq.start(env_h.v_sqr_h); // 2nd axi to comp seq
	phase.drop_objection(this);
endtask
endclass
