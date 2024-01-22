class virtual_sequence extends uvm_sequence#(uvm_sequence_item);
  `uvm_object_utils(virtual_sequence)
   cxl_virtual_sqr 	 v_sqr_h; 
  
  req_pcie_agent_sqr   req_pcie_agent_sqr_h;
  axi_agent_sqr 	 axi_agent_sqr_h;
  reset_pcie_agent_sqr   reset_pcie_agent_sqr_h;
  cxl_pcie_agent_sqr       cxl_pcie_agent_sqr_h;  
  cxl_mem_agent_sqr      cxl_mem_agent_sqr_h; 
  
  extern function new(string name="virtual_sequence");
  extern task body(); 
endclass  

/***************** constructor************************/
function virtual_sequence::new(string name="virtual_sequence");
  super.new(name);

endfunction  

/*********************** task body**********************/
task virtual_sequence::body();

  
  assert($cast(v_sqr_h,m_sequencer))
  else
    `uvm_fatal("virt sequence","casting failed")	  
  req_pcie_agent_sqr_h=v_sqr_h.req_pcie_agent_sqr_h;
  reset_pcie_agent_sqr_h=v_sqr_h.reset_pcie_agent_sqr_h;  
  axi_agent_sqr_h=v_sqr_h.axi_agent_sqr_h;
  cxl_pcie_agent_sqr_h = v_sqr_h.cxl_pcie_agent_sqr_h;
  cxl_mem_agent_sqr_h = v_sqr_h.cxl_mem_agent_sqr_h;

endtask	

/************************RESET SWQUENCE*************************************/

class virt_reset_seq extends virtual_sequence;
 `uvm_object_utils(virt_reset_seq)
  
  cxl_virtual_sqr v_sqr_h;

  reset_seq     rst_sq;

  extern function new(string name="virt_reset_seq");
  extern task body();
endclass

/************** constructor*******************/
function virt_reset_seq::new(string name="virt_reset_seq");
  super.new(name);
endfunction	

/****************** body**************************/
task virt_reset_seq:: body();
  super.body();
  rst_sq=reset_seq::type_id::create("rst_sq");
  rst_sq.start(reset_pcie_agent_sqr_h);
endtask 

/**********************memory write request sequence************************/

class virt_mem_wr_req extends virtual_sequence; 
  `uvm_object_utils(virt_mem_wr_req)
  
  cxl_virtual_sqr v_sqr_h;
  
  mem_wr_req mem_wr_req_h;
  

  extern function new(string name="virt_mem_wr_req");
  extern task body();

endclass

/************** constructor*******************/
function virt_mem_wr_req::new(string name="virt_mem_wr_req");
  super.new(name);
endfunction	

/****************** body**************************/
task virt_mem_wr_req:: body();
  super.body();
  mem_wr_req_h=mem_wr_req::type_id::create("mem_wr_req_h");
  mem_wr_req_h.start(req_pcie_agent_sqr_h);
endtask 

/**********************AXI to COMP sequence************************/

class virt_axi_to_comp_seq extends virtual_sequence; 
  `uvm_object_utils(virt_axi_to_comp_seq)
  
  cxl_virtual_sqr v_sqr_h;
  
  axi_to_comp_seq  a2c_sq;

  extern function new(string name="virt_axi_to_comp_seq");
  extern task body();

endclass

/************** constructor*******************/
function virt_axi_to_comp_seq::new(string name="virt_axi_to_comp_seq");
  super.new(name);
endfunction	

/****************** body**************************/
task virt_axi_to_comp_seq:: body();
  super.body();
  a2c_sq=axi_to_comp_seq::type_id::create("a2c_sq");
  a2c_sq.start(axi_agent_sqr_h);
endtask 


/**********************************************Req to CXL.io************************************/
class virt_req_to_cxlio_FD extends virtual_sequence; 
 `uvm_object_utils(virt_req_to_cxlio_FD)
  
  cxl_virtual_sqr v_sqr_h;
  
  req_to_cxlio_FD        req_to_cxlio_FD_h;

  

  extern function new(string name="virt_req_to_cxlio_FD");
  extern task body();

endclass

/************** constructor*******************/
function virt_req_to_cxlio_FD::new(string name="virt_req_to_cxlio_FD");
  super.new(name);
endfunction	

/****************** body**************************/
task virt_req_to_cxlio_FD:: body();
  super.body();
  req_to_cxlio_FD_h = req_to_cxlio_FD::type_id::create("req_to_cxlio_FD_h");
  req_to_cxlio_FD_h.start(cxl_pcie_agent_sqr_h);
endtask 



