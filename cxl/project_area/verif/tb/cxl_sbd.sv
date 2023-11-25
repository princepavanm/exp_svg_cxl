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
  
  	req_tx               req_tx_scb_h;
	axi_agent_tx	     axi_agent_tx_scb_h;

	req_tx          req_tx_queue[$];
	axi_agent_tx    axi_agent_tx_queue[$];

//	int pass,fail,check_req_tx,check_axi_agent_tx,check_tx,total;

 virtual pcie_intf     pcie_pif;

uvm_tlm_analysis_fifo#(req_tx) req_txfifo;
uvm_tlm_analysis_fifo#(axi_agent_tx) axi_agent_txfifo;


  function new(string name="cxl_sbd", uvm_component parent);
    super.new(name, parent);
   req_txfifo = new("req_txfifo",this);
   axi_agent_txfifo = new("axi_agent_txfifo",this);
 
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
req_tx_scb_h  = req_tx::type_id::create("req_tx_scb_h",  this);
axi_agent_tx_scb_h  = axi_agent_tx::type_id::create("axi_agent_tx_scb_h",  this);
    
    if(!uvm_config_db#(virtual pcie_intf)::get(this, " ", "pcie_intf", pcie_pif))
      `uvm_fatal("SCB", "***** Could not get pcie_pif *****")
  
        
  endfunction:build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction:connect_phase

virtual task run_phase(uvm_phase phase);
	forever
	begin
		fork
                        begin
		 	//	#100;
	  		//	`uvm_info(get_type_name(),$sformatf(" Before calling req_txfifo get method"),UVM_LOW)
        			req_txfifo.get(req_tx_scb_h);
			//	req_tx_queue.push_front(req_tx_scb_h);
   		      	//	`uvm_info(get_type_name(),$sformatf(" After  calling req_txfifo get method"),UVM_LOW)
            	//		`uvm_info(get_type_name(),$sformatf(" Printing req_tx_scb_h, \n  %s",req_tx_scb_h.sprint()),UVM_LOW)
      				`uvm_info(get_type_name(),$sformatf("=============================================req MONITOR SCBD ======================================= \n %s",req_tx_scb_h.sprint()),UVM_MEDIUM)
        		end
//	#100;
	//aaaa 
    			begin
     			//	`uvm_info(get_type_name(),$sformatf(" Before calling axi_agent_txfifo get method"),UVM_LOW)
       				axi_agent_txfifo.get(axi_agent_tx_scb_h); 
			//	axi_agent_tx_queue.push_front(axi_agent_tx_scb_h); 
       			    //    $display("Size of the req_txfifo Queue = %d", req_tx_queue.size);   
   			//	`uvm_info(get_type_name(),$sformatf(" After  calling axi_agent_txfifo get method"),UVM_LOW)
  			     // `uvm_info(get_type_name(),$sformatf(" Printing axi_agent_tx_scb_h, \n %s",axi_agent_tx_scb_h.sprint()),UVM_LOW)
       				`uvm_info(get_type_name(),$sformatf("=============================================AXI MONITOR SCBD ======================================= \n %s",axi_agent_tx_scb_h.sprint()),UVM_MEDIUM)
       	      		end 
       		 join_any
compare_logic();
end

//PAVAN /*
//PAVAN  foreach(axi_agent_txfifo[i])
//PAVAN         begin
//PAVAN                 axi_agent_txfifo[i] = new($sformatf("axi_agent_txfifo[%0d]",i),this);
//PAVAN         end
//PAVAN 	*/

endtask:run_phase

// *************** compare_logic************
task compare_logic();
//if(req_tx_queue.size() && axi_agent_tx_queue.size())
//	begin
	req_tx_scb_h=req_tx_queue.pop_back();
//            			`uvm_info(get_type_name(),$sformatf(" REQ SCBD COMPARE req_tx_scb_h, \n  %s",req_tx_scb_h.sprint()),UVM_LOW)
	axi_agent_tx_scb_h=axi_agent_tx_queue.pop_back();
// 			      `uvm_info(get_type_name(),$sformatf(" AXI SCBD COMPARE axi_agent_tx_scb_h, \n %s",axi_agent_tx_scb_h.sprint()),UVM_LOW)
//	end
//else			      
//	begin
	//	if(req_tx_scb_h.rx_req_tlp_data == axi_agent_tx_scb_h.m_axi_wdata)
	//	if(req_txfifo.rx_req_tlp_data == axi_agent_txfifo.m_axi_wdata)
      	//		begin // data_match_begin 
       		 
//		`uvm_info(get_type_name(),$sformatf("=============================================REQ SCBD COMPARE MATCHED ======================================= \n %s",req_tx_scb_h.sprint()),UVM_MEDIUM)

//		`uvm_info(get_type_name(),$sformatf("=============================================AXI SCBD COMPARE MATCHED ======================================= \n %s",axi_agent_tx_scb_h.sprint()),UVM_MEDIUM)

  			//      `uvm_info(get_type_name(),$sformatf(" DATA IS MATCHED",),UVM_LOW)
	
//			  $display("\n--------------------------------------------------------------");
//       		 	$display($time,,"AXI SCB :: rx_req_tlp_data = %0h, m_axi_wdata = %0h",req_tx_scb_h.rx_req_tlp_data,axi_agent_tx_scb_h.m_axi_wdata);
 //      		 	$display($time,,"AXI SCB ---> Data matched");
       		 			//	pass++;total++;
       		 //	$display($time,,"AXI SCB  ---> No. Of Match   =%0d",pass);
 //      		 	$display("--------------------------------------------------------------\n");
			
//      			end // data_match_end
  //    		else
  			     
 //     			begin //data_mismatch_begin
  			  
	    //   	`uvm_info(get_type_name(),$sformatf("=============================================REQ SCBD COMPARE MISMATCHED ======================================= \n %s",req_tx_scb_h.sprint()),UVM_MEDIUM)

	//	`uvm_info(get_type_name(),$sformatf("=============================================AXI SCBD COMPARE MISMATCHED ======================================= \n %s",axi_agent_tx_scb_h.sprint()),UVM_MEDIUM)
	
	     //	`uvm_info(get_type_name(),$sformatf(" DATA IS MISMATCHED",),UVM_LOW)
//        		$display("\n--------------------------------------------------------------");
//        		$display($time,,"AXI SCB :: rx_req_tlp_data = %0h, m_axi_wdata = %0h",req_tx_scb_h.rx_req_tlp_data,axi_agent_tx_scb_h.m_axi_wdata);
 //       		$display($time,,"AXI SCB ---> Data mismatched");
					//	fail++;total++;
        	//	$display($time,,"AXI SCB ---> No. Of Mismatch=%0d",fail);
        		$display("--------------------------------------------------------------\n");
  //    			end // data_mismatch_end
//	end
//end
  
endtask
endclass:cxl_sbd



















  /* function void write(req_tx req_tx_scb_h, axi_agent_tx axi_agent_tx_scb_h);
  // `uvm_info( get_name(), $psprintf( "Received from_req_pcie_agent packet" ), UVM_FULL )
 
 `uvm_info(get_type_name(),$sformatf("=============================================SCOREBOARD ======================================= \n %s",req_tx_scb_h.sprint()),UVM_MEDIUM)
 `uvm_info(get_type_name(),$sformatf("=============================================SCOREBOARD ======================================= \n %s",axi_agent_tx_scb_h.sprint()),UVM_MEDIUM)

 $display( "SCOREBOARD [T=%0t]   axi_agent_tx_scb_h.m_axi_wdata=%0h",$realtime,  axi_agent_tx_scb_h.m_axi_wdata);


 if(req_tx_scb_h.rx_req_tlp_data==axi_agent_tx_scb_h.m_axi_wdata)
 
 `uvm_info( get_name(), $psprintf( "DATA IS MATCHED" ), UVM_LOW )
 else
 `uvm_error( get_name(), $psprintf( "DATA IS MISS_MATCHED" ))
 
 endfunction
*/
//FIXME   function void write(axi_agent_tx axi_agent_tx_scb_h);
//FIXME   `uvm_info( get_name(), $psprintf( "Received from_axi_agent packet" ), UVM_FULL )
//FIXME   `uvm_info(get_type_name(),$sformatf("=============================================SCOREBOARD ======================================= \n %s",axi_agent_tx_scb_h.sprint()),UVM_MEDIUM)
//FIXME   $display( "SCOREBOARD [T=%0t]   axi_agent_tx_scb_h.m_axi_wdata=%0h",$realtime,  axi_agent_tx_scb_h.m_axi_wdata);
//FIXME   endfunction
 /*	
 $display( "SCOREBOARD [T=%0t]   axi_agent_tx_scb_h.m_axi_wdata=%0h",$realtime,  axi_agent_tx_scb_h.m_axi_wdata);

 $display( "SCOREBOARD [T=%0t] req_tx_scb_h.rx_req_tlp_sop=%0h  req_tx_scb_h.rx_req_tlp_valid=%0h req_tx_scb_h.rx_req_tlp_hdr =%0h  req_tx_scb_h.rx_req_tlp_data=%0h  req_tx_scb_h.rx_req_tlp_eop=%0h",$realtime,req_tx_scb_h.rx_req_tlp_sop,  req_tx_scb_h.rx_req_tlp_valid, req_tx_scb_h.rx_req_tlp_hdr,  req_tx_scb_h.rx_req_tlp_data,  req_tx_scb_h.rx_req_tlp_eop);
 */


   

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


