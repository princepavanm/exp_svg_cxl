//////////////////////////////////////////////////////////////////////////////////
// Company:  Expolog Technologies.
//           Copyright (c) 2023 by Expolog Technologies, Inc. All rights reserved.
//
// Engineer : 
// Revision tag :
// Module Name      :    
// Project Name      : 
// component name : 
// Description: 
//              
//
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


class axi_agent_drv extends uvm_driver#(axi_agent_tx);

  `uvm_component_utils(axi_agent_drv)

  axi_agent_tx               axi_agent_tx_h;

  virtual pcie_intf  pcie_pif;

  function new(string name="axi_agent_drv", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual pcie_intf)::get(this, " ", "pcie_intf", pcie_pif))
      `uvm_fatal("AXI DRV", "***** Could not get pcie_pif *****")
    axi_agent_tx_h = axi_agent_tx::type_id::create("axi_agent_tx_h");

  endfunction:build_phase

task run_phase(uvm_phase phase);
	forever
		begin
		seq_item_port.get_next_item(req);
              	send_to_dut_axi(req);
     		seq_item_port.item_done();
		end

endtask:run_phase

task send_to_dut_axi(axi_agent_tx axi_agent_tx_h);
begin 
	@((pcie_pif.clk) && pcie_pif.rst ==0)
	pcie_pif.axi_drv_cb.m_axi_awready      <=    axi_agent_tx_h.m_axi_awready ;
	pcie_pif.axi_drv_cb.m_axi_wready       <=    axi_agent_tx_h.m_axi_wready  ;
	pcie_pif.axi_drv_cb.m_axi_bid          <=    axi_agent_tx_h.m_axi_bid     ;
	pcie_pif.axi_drv_cb.m_axi_bresp        <=    axi_agent_tx_h.m_axi_bresp   ;
	pcie_pif.axi_drv_cb.m_axi_bvalid       <=    axi_agent_tx_h.m_axi_bvalid  ;
	pcie_pif.axi_drv_cb.m_axi_arready      <=    axi_agent_tx_h.m_axi_arready ;
	pcie_pif.axi_drv_cb.m_axi_rid          <=    axi_agent_tx_h.m_axi_rid     ;
        pcie_pif.axi_drv_cb.m_axi_rdata        <=    axi_agent_tx_h.m_axi_rdata   ;
        pcie_pif.axi_drv_cb.m_axi_rresp        <=    axi_agent_tx_h.m_axi_rresp   ;
        pcie_pif.axi_drv_cb.m_axi_rlast        <=    axi_agent_tx_h.m_axi_rlast   ;
        pcie_pif.axi_drv_cb.m_axi_rvalid       <=    axi_agent_tx_h.m_axi_rvalid  ;

	#100;// why this delay?
//	@(pcie_pif.clk)
end
      		//axi_agent_tx_h.print();
endtask

/*task send_to_dut_axi(axi_agent_tx   axi_agent_tx_h);
	fork
		send_write_addr_channel(   axi_agent_tx_h);
		send_write_data_channel( axi_agent_tx_h);
		send_write_resp_channel( axi_agent_tx_h);
		send_read_addr_channel( axi_agent_tx_h);
		send_read_data_channel( axi_agent_tx_h);

	join
send_to_dut_axi(axi_agent_tx_h);
endtask:send_to_dut_axi

task send_write_addr_channel(axi_agent_tx   axi_agent_tx_h);
	pcie_pif.m_axi_awready = 1; //axi_agent_tx_h.m_axi_awready;
endtask:send_write_addr_channel

task send_write_data_channel(axi_agent_tx   axi_agent_tx_h);
	pcie_pif.m_axi_wready = 1; //axi_agent_tx_h.m_axi_wready;
endtask:send_write_data_channel

task send_write_resp_channel(axi_agent_tx   axi_agent_tx_h);
	pcie_pif.m_axi_bid 	= 0; // axi_agent_tx_h.m_axi_bid;
	pcie_pif.m_axi_bresp 	= 0; //axi_agent_tx_h.m_axi_bresp;
	pcie_pif.m_axi_bvalid 	= 1; //axi_agent_tx_h.m_axi_bvalid;
endtask:send_write_resp_channel


task send_read_addr_channel(axi_agent_tx   axi_agent_tx_h);
	pcie_pif.m_axi_arready <=  1; //axi_agent_tx_h.m_axi_arready;
endtask:send_read_addr_channel


task send_read_data_channel(axi_agent_tx   axi_agent_tx_h);
	pcie_pif.m_axi_rid 	= 0; //axi_agent_tx_h.m_axi_rid;
	pcie_pif.m_axi_rdata 	= 256'h FFFF_FFFF_FFFF_FFFF; //axi_agent_tx_h.m_axi_rdata;
	pcie_pif.m_axi_rresp 	= 0; //axi_agent_tx_h.m_axi_rresp;
	pcie_pif.m_axi_rlast 	= 1; //axi_agent_tx_h.m_axi_rlast;
	pcie_pif.m_axi_rvalid 	= 1; //axi_agent_tx_h.m_axi_rvalid;
endtask:send_read_data_channel
*/

/*task send_to_dut_axi(axi_agent_tx   axi_agent_tx_h);
begin	
	pcie_pif.m_axi_awready  = 1; //axi_agent_tx_h.m_axi_awready;
	@(posedge pcie_pif.mon_axi_mp.clk)
	pcie_pif.m_axi_wready   = 1; //axi_agent_tx_h.m_axi_wready;
	@(posedge pcie_pif.mon_axi_mp.clk)
	
	pcie_pif.m_axi_bid 	= 0; // axi_agent_tx_h.m_axi_bid;
	@(posedge pcie_pif.mon_axi_mp.clk)
	pcie_pif.m_axi_bresp 	= 0; //axi_agent_tx_h.m_axi_bresp;
	pcie_pif.m_axi_bvalid 	= 1; //axi_agent_tx_h.m_axi_bvalid;
	@(posedge pcie_pif.mon_axi_mp.clk)
	@(posedge pcie_pif.mon_axi_mp.clk)
	pcie_pif.m_axi_arready  =  1; //axi_agent_tx_h.m_axi_arready;
	pcie_pif.m_axi_rid 	= 0; //axi_agent_tx_h.m_axi_rid;
	pcie_pif.m_axi_rdata 	<= 256'h FFFF_FFFF_FFFF_FFFF; //axi_agent_tx_h.m_axi_rdata;
	pcie_pif.m_axi_rresp 	<= 0; //axi_agent_tx_h.m_axi_rresp;
	pcie_pif.m_axi_rlast 	<= 1; //axi_agent_tx_h.m_axi_rlast;
	pcie_pif.m_axi_rvalid 	<= 1; //axi_agent_tx_h.m_axi_rvalid;
end
endtask:send_to_dut_axi*/

endclass:axi_agent_drv
