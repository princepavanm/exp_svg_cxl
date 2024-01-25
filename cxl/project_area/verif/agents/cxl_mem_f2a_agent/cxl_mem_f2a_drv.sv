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

class cxl_mem_f2a_drv extends uvm_driver#(cxl_mem_f2a_tx);

  `uvm_component_utils(cxl_mem_f2a_drv)

  cxl_mem_f2a_tx  f2a_tx_h;

  virtual pcie_intf     pcie_pif;


//==============================constructor=====================================//
 function new(string name="cxl_mem_f2a_drv", uvm_component parent=null);
    super.new(name, parent);
 endfunction:new

//==============================build_phase====================================//
 function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db#(virtual pcie_intf)::get(this, " ", "pcie_intf", pcie_pif))
      `uvm_fatal("DRV", "***** Could not get pcie_pif *****")

    f2a_tx_h = cxl_mem_f2a_tx::type_id::create("f2a_tx_h");

 endfunction:build_phase

//==============================run_phase====================================//
 task run_phase(uvm_phase phase);
  forever begin
		seq_item_port.get_next_item(f2a_tx_h);
	       		fork
				drive_f2a_global(f2a_tx_h);
	       			//drive_f2a_req(f2a_tx_h);
				//drive_f2a_data(f2a_tx_h);
 				drive_f2a_rsp(f2a_tx_h);
			join
       `uvm_info(get_type_name(),$sformatf("=============================================DRIVER REQ to dut ======================================= \n %s",f2a_tx_h.sprint()),UVM_MEDIUM)
 		 seq_item_port.item_done();
	end
 

 endtask:run_phase

task drive_f2a_global(cxl_mem_f2a_tx f2a_tx_h);
begin
     @((pcie_pif.clk) && !pcie_pif.rst )
	begin
		pcie_pif.cxlf2a_drv.f2a_rxcon_ack    	<= f2a_tx_h.f2a_rxcon_ack;
		pcie_pif.cxlf2a_drv.f2a_rxdiscon_nack   <= f2a_tx_h.f2a_rxdiscon_nack;
		pcie_pif.cxlf2a_drv.f2a_rx_empty 	<= f2a_tx_h.f2a_rx_empty;
	end
end	
endtask



/*task drive_f2a_data(cxl_mem_f2a_tx f2a_tx_h);
begin
     @((pcie_pif.clk) && !pcie_pif.rst )
	if(a2f_tx_h.a2f_data_is_valid)
	begin
		pcie_pif.cxlf2a_drv.a2f_data_is_valid    <= f2a_tx_h.a2f_data_is_valid;
		pcie_pif.cxlf2a_drv.a2f_data_protocol_id <= f2a_tx_h.a2f_data_protocol_id;
		pcie_pif.cxlf2a_drv.a2f_req_protocol_id  <= f2a_tx_h.a2f_data_header;
		pcie_pif.cxlf2a_drv.a2f_req_protocol_id  <= f2a_tx_h.a2f_req_protocol_id;
		pcie_pif.cxlf2a_drv.a2f_data_body        <= f2a_tx_h.a2f_data_body;
		pcie_pif.cxlf2a_drv.a2f_data_poison      <= f2a_tx_h.a2f_data_poison;
		pcie_pif.cxlf2a_drv.a2f_data_parity      <= f2a_tx_h.a2f_data_parity;
		pcie_pif.cxlf2a_drv.a2f_data_eop         <= f2a_tx_h.a2f_data_eop;
	end

end	
endtask*/

task drive_f2a_rsp(cxl_mem_f2a_tx f2a_tx_h);
begin
     @((pcie_pif.clk) && !pcie_pif.rst )
     begin
		pcie_pif.cxlf2a_drv.f2a_rsp_excrd_valid    <= f2a_tx_h.f2a_rsp_excrd_valid;


	end
end
endtask











endclass:cxl_mem_f2a_drv
