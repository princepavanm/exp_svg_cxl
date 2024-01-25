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

class cxl_mem_a2f_drv extends uvm_driver#(cxl_mem_a2f_tx);

  `uvm_component_utils(cxl_mem_a2f_drv)
cxl_mem_a2f_tx  a2f_tx_h;
  virtual pcie_intf     pcie_pif;

//==============================constructor=====================================//
function new(string name="cxl_mem_a2f_drv", uvm_component parent=null);
    super.new(name, parent);
endfunction:new


//==============================build_phase====================================//
function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db#(virtual pcie_intf)::get(this, " ", "pcie_intf", pcie_pif))
      `uvm_fatal("DRV", "***** Could not get pcie_pif *****")

    a2f_tx_h = cxl_mem_a2f_tx::type_id::create("a2f_tx_h");
endfunction:build_phase

//==============================run_phase====================================//
task run_phase(uvm_phase phase);
	forever begin
		seq_item_port.get_next_item(a2f_tx_h);
	       		fork
				drive_a2f_global(a2f_tx_h);
	       			drive_req(a2f_tx_h);
				drive_data(a2f_tx_h);
 				drive_rsp(a2f_tx_h);
			join
       `uvm_info(get_type_name(),$sformatf("=============================================DRIVER REQ to dut ======================================= \n %s",a2f_tx_h.sprint()),UVM_MEDIUM)
 		 seq_item_port.item_done();
	end

endtask:run_phase

task drive_a2f_global(cxl_mem_a2f_tx a2f_tx_h);
begin
     @((pcie_pif.clk) && !pcie_pif.rst )
	begin
		pcie_pif.cxla2f_drv.a2f_txcon_req    <= a2f_tx_h.a2f_txcon_req;
		pcie_pif.cxla2f_drv.a2f_fatal <= a2f_tx_h.a2f_fatal;
	end

end	
endtask

task drive_req(cxl_mem_a2f_tx a2f_tx_h);
begin
     @((pcie_pif.clk) && !pcie_pif.rst )
	if(a2f_tx_h.a2f_req_is_valid)
	begin
		pcie_pif.cxla2f_drv.a2f_req_is_valid    <= a2f_tx_h.a2f_req_is_valid;
		pcie_pif.cxla2f_drv.a2f_req_protocol_id <= a2f_tx_h.a2f_req_protocol_id;
		pcie_pif.cxla2f_drv.a2f_req_header      <= a2f_tx_h.a2f_req_header;
	end

end	
endtask

task drive_data(cxl_mem_a2f_tx a2f_tx_h);
begin
     @((pcie_pif.clk) && !pcie_pif.rst )
	if(a2f_tx_h.a2f_data_is_valid)
	begin
		pcie_pif.cxla2f_drv.a2f_data_is_valid    <= a2f_tx_h.a2f_data_is_valid;
		pcie_pif.cxla2f_drv.a2f_data_protocol_id <= a2f_tx_h.a2f_data_protocol_id;
		pcie_pif.cxla2f_drv.a2f_data_header  <= a2f_tx_h.a2f_data_header;
		pcie_pif.cxla2f_drv.a2f_data_byte_en  <= a2f_tx_h.a2f_data_byte_en;
		pcie_pif.cxla2f_drv.a2f_data_body        <= a2f_tx_h.a2f_data_body;
		pcie_pif.cxla2f_drv.a2f_data_poison      <= a2f_tx_h.a2f_data_poison;
		pcie_pif.cxla2f_drv.a2f_data_parity      <= a2f_tx_h.a2f_data_parity;
		pcie_pif.cxla2f_drv.a2f_data_eop         <= a2f_tx_h.a2f_data_eop;
	end

end	
endtask

task drive_rsp(cxl_mem_a2f_tx a2f_tx_h);
begin
     @((pcie_pif.clk) && !pcie_pif.rst )
     if(a2f_tx_h.a2f_rsp_is_valid)begin
		pcie_pif.cxla2f_drv.a2f_rsp_is_valid    <= a2f_tx_h.a2f_rsp_is_valid;
		pcie_pif.cxla2f_drv.a2f_rsp_protocol_id <= a2f_tx_h.a2f_rsp_protocol_id;
		pcie_pif.cxla2f_drv.a2f_rsp_header      <= a2f_tx_h.a2f_rsp_header;
		a2f_tx_h.a2f_rsp_excrd_valid <= pcie_pif.cxla2f_drv.a2f_rsp_excrd_valid;

	end
end
endtask



endclass:cxl_mem_a2f_drv
