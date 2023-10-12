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

class req_pcie_agent_cov extends uvm_subscriber#(req_tx);

  `uvm_component_utils(req_pcie_agent_cov)

  uvm_analysis_imp#(req_tx, req_pcie_agent_cov)       req_pcie_agent_cov_port;

  req_tx   tx_h;

 covergroup req_cg();

     	option.per_instance=1;
	RX_TLP_DATA:coverpoint tx_h.rx_req_tlp_data
			{
		//FIXME		bins range[]={[0:$]};
				
			}
	
	RX_TLP_VALID:coverpoint tx_h.rx_req_tlp_valid
			{
				bins b1	=	{[0:1]};
			}

	RX_TLP_SOP:coverpoint tx_h.rx_req_tlp_sop
			{
				bins b1={[0:1]};
			}

	RX_TLP_EOP:coverpoint tx_h.rx_req_tlp_eop
			{
				bins b1={[0:1]};
			}

	RX_TLP_FMT:coverpoint tx_h.rx_fmt
			{
				bins MRd0	=	{000}; 	//memory read request with type=00000
				bins MRd1	=	{001}; 	//memory read request with type=00000
				bins MRdLK0	=	{000}; 	//memory read requeest-locked with type=00001
				bins MRdLK1	=	{001};	//memory read requeest-locked with type=00001
			        bins MWr1	=	{010};	//memory write request with type 000000
			        bins Mwr2	=	{011}; 	//memory write request with type 000000
			        bins IORd	=	{000}; 	//I/O read request 	
			        bins IOWr	=	{010}; 	//I/O write request 	
			        bins CfgRd0	=	{000}; 	//configuration read type 0 	
			        bins CfgWr0	=	{010}; 	//configuration write type 0 
			        bins CfgRd1	=	{000}; 	//configuration read type 1 	
			        bins CfgWr1	=	{010}; 	//configuration write type 1 
			        bins TCfgRd	=	{000}; 	//Deprecated TLP Type
			        bins TCfgWr	=	{010}; 	//Deprecated TLP Type
			        bins Msg	=	{001}; 	//Message Request 
			        bins MsgD	=	{011}; 	//Message Request with data payload
			        bins Cpl	=	{000}; 	//Completion without data		
			        bins CplD	=	{010}; 	//Completion with data		
			        bins CplDLK	=	{010}; 	//Completion for locked memory read 		
			        bins fetchAdd2	=	{010}; 	//Fetch and Add Atomicop request 		
			        bins fetchAdd3	=	{011}; 	//Fetch and Add Atomicop request 		
			        bins Swap2	=	{010}; 	//Unconditional swap Atomicop request		
			        bins Swap3	=	{011}; 	//Unconditional swap Atomicop request		
			        bins CAs2	=	{010}; 	//compare and swap Atomicop request		
			        bins CAs3	=	{011}; 	//compare and swap Atomicop request		
			        bins LPrfx	=	{100}; 	//Local TLP Prefix		
			        bins EPrfx	=	{100}; 	//End-End TLP Prefix		
				
		}

	RX_TLP_TYPE_MI:coverpoint tx_h.rx_type_mi
			{

				bins MRd0	=	{00000}; 	//memory read request with type=00000
				bins MRd1	=	{00000}; 	//memory read request with type=00000

				bins MRdLK0	=	{00001}; 	//memory read requeest-locked with type=00001
				bins MRdLK1	=	{00001};	//memory read requeest-locked with type=00001
			        
				bins MWr1	=	{00000};	//memory write request with type 000000
			        bins Mwr2	=	{00000}; 	//memory write request with type 000000
			       
			       	bins IORd	=	{00010}; 	//I/O read request 	
			        bins IOWr	=	{00010}; 	//I/O write request 	
			       
			       	bins CfgRd0	=	{00100}; 	//configuration read type 0 	
			        bins CfgWr0	=	{00100}; 	//configuration write type 0 
			        bins CfgRd1	=	{00101}; 	//configuration read type 1 	
			        bins CfgWr1	=	{00101}; 	//configuration write type 1 
			        
				bins TCfgRd	=	{11011}; 	//Deprecated TLP Type
			        bins TCfgWr	=	{11011}; 	//Deprecated TLP Type
	                       
			       	bins MsgRC	=	{10000}; 	//Message Request-routed to root complex 
	                        bins MsgA	=	{10001}; 	//Message Request-routed by address 
	                        bins MsgID	=	{10010}; 	//Message Request-routed by id 
	                        bins MsgBRC	=	{10011}; 	//Message Request-broadcast from root complex 
	                        bins MsgL	=	{10100}; 	//Message Request-local-terminate at reciver 
	                        bins MsgGR	=	{10101}; 	//Message Request-gathered and routed to root complex 
	                        bins MsgR	=	{[10110:10111]};//Message Request-reserved
			      
				bins MsgDRC	=	{10000}; 	//Message Request with data payload-routed to root complex 
	                        bins MsgDA	=	{10001}; 	//Message Request with data payload-routed by address 
	                        bins MsgDID	=	{10010}; 	//Message Request with data payload-routed by id 
	                        bins MsgDBRC	=	{10011}; 	//Message Request with data payload-broadcast from root complex 
	                        bins MsgDL	=	{10100}; 	//Message Request with data payload-local-terminate at reciver 
	                        bins MsgDGR	=	{10101}; 	//Message Request with data payload-gathered and routed to root complex 
	                        bins MsgDR	=	{[10110:10111]};//Message Request with data payload-reserved

			        bins Cpl	=	{01010}; 	//Completion without data		
			        bins CplD	=	{01010}; 	//Completion with data		
			        bins CplDLK	=	{01011}; 	//Completion for locked memory read 		
			       
			       	bins fetchAdd2	=	{01100};//Fetch and Add Atomicop request 		
			        bins fetchAdd3	=	{01100};//Fetch and Add Atomicop request 		
			       
			       	bins Swap2	=	{01101}; 	//Unconditional swap Atomicop request		
			        bins Swap3	=	{01101}; 	//Unconditional swap Atomicop request		
			       
			       	bins CAs2	=	{01110}; 	//compare and swap Atomicop request		
			        bins CAs3	=	{01110}; 	//compare and swap Atomicop request		
			      
				bins LPrfxMRIOV	=	{00000}; 	//Local TLP Prefix-MR-IOV TLP prefix		
				bins LPrfxVenPreL0	=	{01110}; 	//Local TLP Prefix-vendor defined local TLP prefix		
				bins LPrfxVenPreL1	=	{01111}; 	//Local TLP Prefix-vendor defined local TLP prefix
					
			        bins EPrfxTPH		=	{10000}; 	//End-End TLP Prefix-TPH		
			        bins EPrfxPASID		=	{10001}; 	//End-End TLP Prefix-PASID		
			        bins EPrfxVenPreE0	=	{11110}; 	//End-End TLP Prefix-Vendor defined End-End TLP Prefix	
			        bins EPrfxVenPreE1	=	{11111}; 	//End-End TLP Prefix-Vendor defined End-End TLP Prefix		
		}

	RX_T9:coverpoint tx_h.rx_t_9
			{
				bins t_9={[0:1]};
		}

	RX_TC:coverpoint tx_h.rx_tc
			{
				bins Tc0={000};                 //TC0: Best Effort service class (General Purpose I/O)
				bins Tc1to7={[0001:111]};         //TC1 toTC7: Differentiated service classes 
		}

	RX_T8:coverpoint tx_h.rx_t_8
			{
				bins t8={[0:1]};
		}

	RX_ATTR_2:coverpoint tx_h.rx_attr_1
			{
		//FIXME		bins b1={[0:1]};
		}

	RX_LN:coverpoint tx_h.rx_ln
			{
				bins   ln={[0:1]};
		}

	RX_TH:coverpoint tx_h.rx_th
			{
				bins th={[0:1]};
		}

	RX_TD:coverpoint tx_h.rx_td
			{
				bins td={[0:1]};
		}

	RX_EP:coverpoint tx_h.rx_ep
			{
				bins b1={[0:1]};
		}

	RX_ATTR_1:coverpoint tx_h.rx_attr_2
			{
		//FIXME		bins b1={[0:4]};
		}

	RX_AT:coverpoint tx_h.rx_at
			{
		//FIXME		bins rx_at={[0:1]};
		}

	RX_LENGTH:coverpoint tx_h.rx_length
			{
				bins dw_3={0000000011};
				bins dw_4={0000000100};	
		}

	RX_REQ_ID:coverpoint tx_h.rx_requester_id
			{
		//FIXME		bins b1={[0:65535]};
					
		}

	RX_TAG:coverpoint tx_h.rx_tag
			{
		//FIXME		bins b1={[0:255]};
					
		}

	RX_HDR_LAST:coverpoint tx_h.rx_last_be
			{
		//FIXME		bins b1={[0:3]};
			
		}

	RX_HDR_FIRST:coverpoint tx_h.rx_first_be
			{
		//FIXME		bins b1={[0:3]};
				
		}

	RX_ADDR:coverpoint tx_h.rx_addr
			{
		//FIXME		bins range[]={[0:$]};	
		}

  endgroup:req_cg


  
  function new(string name="req_pcie_agent_cov", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    req_pcie_agent_cov_port = new("req_pcie_agent_cov_port", this);
    tx_h = req_tx::type_id::create("tx_h", this);
  endfunction:build_phase

  function void write(req_tx   t);

    `uvm_info("req_pcie_agent_COV", "From Coverage Write function", UVM_LOW)

  endfunction:write

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("req_pcie_agent_COV","From Coverage Run Phase", UVM_LOW)

  endtask:run_phase

endclass:req_pcie_agent_cov
