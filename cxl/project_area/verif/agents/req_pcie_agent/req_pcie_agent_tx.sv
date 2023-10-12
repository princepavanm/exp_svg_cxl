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

class req_tx extends uvm_sequence_item;

  


 bit clk;
		bit rst;
	rand bit [`TLP_DATA_WIDTH-1:0]               rx_req_tlp_data;
    	     bit [`TLP_SEG_COUNT*`TLP_HDR_WIDTH-1:0]  rx_req_tlp_hdr;
    	rand bit [`TLP_SEG_COUNT-1:0]                rx_req_tlp_valid;
    	rand bit [`TLP_SEG_COUNT-1:0]                rx_req_tlp_sop;
    	rand bit [`TLP_SEG_COUNT-1:0]                rx_req_tlp_eop;
    	     bit                                     rx_req_tlp_ready;
	rand bit [15:0]                                completer_id;
	rand bit [2:0]                                 max_payload_size;
	
	reg [2:0] rx_fmt;
	reg [4:0] rx_type_mi;
	reg [2:0] rx_tc;
	reg rx_t_9;
	reg rx_t_8;
	reg rx_ln;
	reg rx_th;
	reg rx_td;
	reg rx_ep;
	reg [2] rx_attr_1;
	reg [1:0] rx_attr_2;
	reg [1:0] rx_at;
	reg [10:0] rx_length;
	reg [15:0] rx_requester_id;
	reg [9:0] rx_tag;
	reg [7:0] rx_last_be;
	reg [7:0] rx_first_be;
	reg [63:0] rx_addr;
	reg [1:0] rx_ph;




	
	`uvm_object_utils_begin(req_tx)
    `uvm_field_int(rx_req_tlp_data  , UVM_ALL_ON)
    `uvm_field_int(rx_req_tlp_hdr, UVM_ALL_ON)
    `uvm_field_int(rx_req_tlp_valid , UVM_ALL_ON)
    `uvm_field_int(rx_req_tlp_sop, UVM_ALL_ON)
    `uvm_field_int(rx_req_tlp_eop,UVM_ALL_ON)
    `uvm_field_int(rx_req_tlp_ready, UVM_ALL_ON)
  `uvm_object_utils_end


  function new(string name="req_tx");
    super.new(name);
  endfunction

endclass
