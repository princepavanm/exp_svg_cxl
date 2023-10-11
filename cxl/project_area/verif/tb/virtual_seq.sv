class virtual_sequence extends uvm_sequence#(uvm_sequence_item);
  `uvm_object_utils(virtual_sequence)
   cxl_virtual_sqr 	 v_sqr_h; 
  
  req_pcie_agent_sqr   req_pcie_agent_sqr_h;
  axi_agent_sqr 	 axi_agent_sqr_h;

  
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
