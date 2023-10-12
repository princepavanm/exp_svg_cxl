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


/**********************memory write request sequence************************/


class mem_wr_req extends cxl_base_seq;
	`uvm_object_utils(mem_wr_req)

extern function new(string name = "mem_wr_req");
extern task body();
endclass
/******************** constructor*********************/
function mem_wr_req :: new(string name="mem_wr_req");
  super.new(name);	
endfunction

/********************* body task*******************/

task mem_wr_req ::body();
  	super.body();
	req=req_tx::type_id::create("req");
//req.rx_req_tlp_hdr = 'h40062804fffff0ffffdeadbeef0;
//req.rx_req_tlp_hdr = 'h4000_0001_0000_0000_ffff_ffff0_0000_0000;
//PM req.rx_req_tlp_hdr = 'h4003_1404_ffff_fff0_dead_bee0_0000_0000;


//{req.rx_fmt, req.rx_type_mi, req.rx_t_9, req.rx_tc, req.rx_t_8,  req.rx_attr_1, req.rx_ln, req.rx_th, req.rx_td, req.rx_ep, req.rx_attr_2, req.rx_at, req.rx_length, req.rx_requester_id, req.rx_tag, req.rx_last_be, req.rx_first_be, req.rx_addr, req.rx_ph };
		begin
  			start_item(req);
				req.completer_id = $random;
				req.max_payload_size=111;
				req.rx_req_tlp_hdr = 'h4003_1404_ffff_fff0_dead_bee0_0000_0000;
				req.rx_req_tlp_data = 256'h F00DF00D_CAFECAFE_DEADBEEF_B00CB00C; 
				req.rx_req_tlp_valid = 1; 
				req.rx_req_tlp_sop =1;
			//FIXME	req.rx_req_tlp_eop =0; 
  			finish_item(req);
		#10;
 			start_item(req);
				req.completer_id = $random;
				req.max_payload_size=$random;
				req.rx_req_tlp_hdr = 'h4003_1404_ffff_fff0_cafe_cafe_0000_0000;
				req.rx_req_tlp_data = $random; 
				req.rx_req_tlp_valid = 1; 
				req.rx_req_tlp_sop =1;
			//FIXME	req.rx_req_tlp_eop =0; 
  			finish_item(req);
		end

endtask	
//DW0
//PM req.rx_fmt = 010; 
//PM req.rx_type_mi = 00000;
//PM req.rx_t_9 =0;
//PM req.rx_tc = 000;
//PM req.rx_t_8 = 0;
//PM 
//PM req.rx_attr_1 = 0;
//PM req.rx_ln = 1; 
//PM req.rx_th = 1; 
//PM req.rx_td =0;
//PM req.rx_ep =0;
//PM req.rx_attr_2 = 01;
//PM req.rx_at = 01;
//PM req.rx_length = 00000000100;
//PM 
//PM //DW1
//PM req.rx_requester_id = 'habcd;
//PM req.rx_tag = 11110000;
//PM req.rx_last_be = 1111; 
//PM req.rx_first_be = 0000;
//PM 
//PM //DW2
//PM req.rx_addr = 64'h abcddd;
//PM req.rx_ph = 0;
//=================================================================================================
//// TLP header parsing
    // DW 0
    //PM rx_req_tlp_hdr_fmt = rx_req_tlp_hdr[127:125]; // fmt
    //PM rx_req_tlp_hdr_type = rx_req_tlp_hdr[124:120]; // type
    //PM rx_req_tlp_hdr_tag[9] = rx_req_tlp_hdr[119]; // T9
    //PM rx_req_tlp_hdr_tc = rx_req_tlp_hdr[118:116]; // TC
    //PM rx_req_tlp_hdr_tag[8] = rx_req_tlp_hdr[115]; // T8
    //PM rx_req_tlp_hdr_attr[2] = rx_req_tlp_hdr[114]; // attr
    //PM rx_req_tlp_hdr_ln = rx_req_tlp_hdr[113]; // LN
    //PM rx_req_tlp_hdr_th = rx_req_tlp_hdr[112]; // TH
    //PM rx_req_tlp_hdr_td = rx_req_tlp_hdr[111]; // TD
    //PM rx_req_tlp_hdr_ep = rx_req_tlp_hdr[110]; // EP
    //PM rx_req_tlp_hdr_attr[1:0] = rx_req_tlp_hdr[109:108]; // attr
    //PM rx_req_tlp_hdr_at = rx_req_tlp_hdr[107:106]; // AT
    //PM rx_req_tlp_hdr_length = {rx_req_tlp_hdr[105:96] == 0, rx_req_tlp_hdr[105:96]}; // length
    //PM // DW 1
    //PM rx_req_tlp_hdr_requester_id = rx_req_tlp_hdr[95:80]; // requester ID
    //PM rx_req_tlp_hdr_tag[7:0] = rx_req_tlp_hdr[79:72]; // tag
    //PM rx_req_tlp_hdr_last_be = rx_req_tlp_hdr[71:68]; // last BE
    //PM rx_req_tlp_hdr_first_be = rx_req_tlp_hdr[67:64]; // first BE
    //PM if (rx_req_tlp_hdr_fmt[0] || TLP_FORCE_64_BIT_ADDR) begin
    //PM     // 4 DW (64-bit address)
    //PM     // DW 2+3
    //PM     rx_req_tlp_hdr_addr = {rx_req_tlp_hdr[63:2], 2'b00}; // addr
    //PM     rx_req_tlp_hdr_ph = rx_req_tlp_hdr[1:0]; // PH
    //PM end else begin
    //PM     // 3 DW (32-bit address)
    //PM     // DW 2
    //PM     rx_req_tlp_hdr_addr = {rx_req_tlp_hdr[63:34], 2'b00}; // addr
    //PM     rx_req_tlp_hdr_ph = rx_req_tlp_hdr[33:32]; // PH
    //PM end


//=================================================================================================
//

//	assert(req.randomize() with { req.rx_req_tlp_valid == 1; req.rx_req_tlp_sop == 1; req.rx_fmt == 010; req.rx_type_mi == 00000; req.rx_tc == 000; req.rx_attr_1 == 0; req.rx_ln == 1; req.rx_th == 1; req.rx_td ==0; req.rx_ep ==0; req.rx_attr_2 == 01; req.rx_at == 01; req.rx_length == 00000000100; req.rx_req_tlp_eop == 0; req.rx_last_be == 1111; req.rx_first_be == 0000; }) 


