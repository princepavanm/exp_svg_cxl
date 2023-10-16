//////////////////////////////////////////////////////////////////////////////////
// Company:  Expolog Technologies.
//  Copyright (c) 2023 by Expolog Technologies, Inc. All rights reserved.
//
// Engineer : 
// Revision tag :
// Module Name  :  
// Project Name  : 
// component name : 
// Description: This module provides a test to generate clocks

//
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

class cxl_sbd extends uvm_scoreboard;

	`uvm_component_utils(cxl_sbd)
  req_pcie_agent	req_pcie_agent_h;

	req_tx                req_tx_scb_h;
	axi_agent_tx	     axi_agent_tx_scb_h;

 // uvm_analysis_imp #(req_tx, cxl_sbd) imp_req_tx;
 // uvm_analysis_imp #(axi_agent_tx, cxl_sbd) imp_axi_agent_tx;
 
  function new(string name="cxl_sbd", uvm_component parent=null);
    super.new(name, parent);
 //   imp_req_tx = new("imp_req_tx", this);
  //  imp_axi_agent_tx = new("imp_axi_agent_tx", this);
   

  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
 
  endfunction:build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
     
  endfunction:connect_phase


  function void write(axi_agent_tx axi_agent_tx_scb_h);
 	  `uvm_info( get_name(), $psprintf( "Received from_req_pcie_agent packet" ), UVM_FULL )
 `uvm_info( get_name(), $psprintf( "Received from_axi_agent packet" ), UVM_FULL )


//req_tx_scb_h.print();
//axi_agent_tx_scb_h.print();


 /*if(req_tx_scb_h.rx_req_tlp_data==axi_agent_tx_scb_h.m_axi_wdata)

	`uvm_info( get_name(), $psprintf( "DATA IS MATCHED" ), UVM_LOW )
else
	`uvm_error( get_name(), $psprintf( "DATA IS MISS_MATCHED" ))
	
 $display( "SCOREBOARD [T=%0t]   axi_agent_tx_scb_h.m_axi_wdata=%0h",$realtime,  axi_agent_tx_scb_h.m_axi_wdata);

 $display( "SCOREBOARD [T=%0t] req_tx_scb_h.rx_req_tlp_sop=%0h  req_tx_scb_h.rx_req_tlp_valid=%0h req_tx_scb_h.rx_req_tlp_hdr =%0h  req_tx_scb_h.rx_req_tlp_data=%0h  req_tx_scb_h.rx_req_tlp_eop=%0h",$realtime,req_tx_scb_h.rx_req_tlp_sop,  req_tx_scb_h.rx_req_tlp_valid, req_tx_scb_h.rx_req_tlp_hdr,  req_tx_scb_h.rx_req_tlp_data,  req_tx_scb_h.rx_req_tlp_eop);
 */

endfunction

   

/* virtual function void write axi_agent_tx(axi_agent_tx   axi_agent_tx_h);
 	  `uvm_info( get_name(), $psprintf( "Received from_axi_agent packet" ), UVM_FULL )
	  	axi_agent_tx_queue.push_back(axi_agent_tx_h);

      endfunction
*/
/*
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("SBD","Comparition Logic : Run_phase", UVM_LOW)

  endtask:run_phase

  virtual function check_phase(uvm_phase phase);
    super.check_phase(phase);

    `uvm_info("SBD","Comparition Logic : Check_phase", UVM_LOW)

  endfunction:check_phase

  virtual function report_phase(uvm_phase phase);
    super.report_phase(phase);

    `uvm_info("SBD","Passed and Failed ", UVM_LOW)

  endfunction:report_phase*/

endclass:cxl_sbd
