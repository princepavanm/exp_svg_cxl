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
// P_XX - Represents PCIE Header fields             
// M_XX - Represents MCTP Header fields
// M_PL_XX - Represents MCTP Payload fields
//
//
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////





class cxl_io_mctp extends uvm_component;

  `uvm_component_utils(cxl_io_mctp)
	

  //HEADER VARIABLES/BITFIELDS
  bit           P_R1;
  bit [1:0]     P_FMT;
  bit [4:0]     P_TYPE;
  bit           P_R2;
  bit [2:0]     P_TC;
  bit [3:0]     P_R3;
  bit           P_TD;
  bit           P_EP;
  bit [1:0]     P_ATTR;
  bit [1:0]     P_R4;
  bit [9:0]     P_LEN;
  bit [15:0]    P_REQ_ID;
  bit [1:0]     P_R5;
  bit [1:0]     P_PAD_LEN;
  bit [3:0]     P_MCTP_VDM_CODE;
  bit [7:0]     P_MESSAGE_CODE;
  bit [15:0]    P_TARGET_ID;
  bit [15:0]    P_VENDOR_ID;
  bit [3:0]     M_R1;
  bit [3:0]     M_HDR_VER;
  bit [7:0]     M_DEST_EID;
  bit [7:0]     M_SOURCE_EID;
  bit           M_SOM;
  bit           M_EOM;
  bit [1:0]     M_PKT_SEQ;
  bit           M_TO;
  bit [2:0]     M_MSG_TAG;
  bit           M_PL_IC;
  bit [6:0]     M_PL_MSG_TYP;
  bit           M_PL_RQ;
  bit           M_PL_D;
  bit           M_PL_R1;
  bit [4:0]     M_PL_INST_ID;
  bit [7:0]     M_PL_COMM_CODE;
  bit [7:0]     M_PL_COMPL_CODE;

  req_tx             tx_h;

  function new(string name="cxl_io_mctp", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction:build_phase



  extern task send_to_cxlio(input req_tx tx_h);
  extern task packet_parsing(bit [127:0]tlp_data,bit [`TLP_SEG_COUNT*`TLP_HDR_WIDTH-1:0]tlp_hdr);
  extern function void  packet_valid_check(bit[127:0] parsed_data) ; 
  extern function void  print_packet_valid(); 
  extern function void  print_packet_invalid(); 
endclass:cxl_io_mctp


task cxl_io_mctp::send_to_cxlio(input req_tx tx_h);
	bit [127:0] data;
	bit [`TLP_SEG_COUNT*`TLP_HDR_WIDTH-1:0] header;

	$display("==================IN CXL.io COMPONENT====================");
	tx_h.print();
	header = tx_h.rx_req_tlp_hdr;
	data   = tx_h.rx_req_tlp_data[255:128];

	packet_parsing(data,header);
endtask: send_to_cxlio

task cxl_io_mctp::packet_parsing(bit [127:0] tlp_data,bit [`TLP_SEG_COUNT*`TLP_HDR_WIDTH-1:0] tlp_hdr);

 
 bit [127:0]        parsed_data;


 P_R1             = tlp_hdr[127];
 P_FMT            = tlp_hdr[126:125];
 P_TYPE           = tlp_hdr[124:120];
 P_R2             = tlp_hdr[119];
 P_TC             = tlp_hdr[118:116]; 
 P_R3             = tlp_hdr[115:112];
 P_TD             = tlp_hdr[111];
 P_EP             = tlp_hdr[110];
 P_ATTR           = tlp_hdr[109:108];
 P_R4             = tlp_hdr[107:106];
 P_LEN            = tlp_hdr[105:96];
 P_REQ_ID         = tlp_hdr[95:80];
 P_R5             = tlp_hdr[79:78];
 P_PAD_LEN        = tlp_hdr[77:76];
 P_MCTP_VDM_CODE  = tlp_hdr[75:72];
 P_MESSAGE_CODE   = tlp_hdr[71:64];
 P_TARGET_ID      = tlp_hdr[63:48];
 P_VENDOR_ID      = tlp_hdr[47:32];
 M_R1             = tlp_hdr[31:28];
 M_HDR_VER        = tlp_hdr[27:24];
 M_DEST_EID       = tlp_hdr[23:16];
 M_SOURCE_EID     = tlp_hdr[15:8];
 M_SOM            = tlp_hdr[7];
 M_EOM            = tlp_hdr[6];
 M_PKT_SEQ        = tlp_hdr[5:4];
 M_TO             = tlp_hdr[3];
 M_MSG_TAG        = tlp_hdr[2:0];


 $display("=============================PACKET DETAILS================================="); 
 $display("R1 = %d",P_R1);
 $display("Fmt = %d",P_FMT);
 $display("Type = %d",P_TYPE);
 $display("R2 = %d",P_R2);
 $display("TC = %d",P_TC);
 $display("R3 = %d",P_R3);
 $display("TD = %d",P_TD);
 $display("EP = %d",P_EP);
 $display("Attr = %d",P_ATTR);
 $display("R4 = %d",P_R4);
 $display("Len = %d",P_LEN);
 $display("Req_ID = %d",P_REQ_ID);
 $display("R5 = %d",P_R5);
 $display("Pad_len = %d",P_PAD_LEN);
 $display("Mctp_vdm_code = %d",P_MCTP_VDM_CODE);
 $display("Msg_Code = %d",P_MESSAGE_CODE);
 $display("Tgt_ID = %d",P_TARGET_ID);
 $display("Vendor_ID = %d",P_VENDOR_ID);
 $display("M_R1 = %d",M_R1);
 $display("M_HDR_VER = %d",M_HDR_VER);
 $display("Dest_EID = %d",M_DEST_EID);
 $display("Source_EID = %d",M_SOURCE_EID);
 $display("SOM = %d",M_SOM);
 $display("EOM = %d",M_EOM);
 $display("Pkt_seq = %d",M_PKT_SEQ);
 $display("TO = %d",M_TO);
 $display("Msg_Tag = %d",M_MSG_TAG);

 parsed_data = {P_R1,P_FMT,P_TYPE,P_R2,P_TC,P_R3,P_TD,P_EP,P_ATTR,P_R4,P_LEN,P_REQ_ID,P_R5,P_PAD_LEN,P_MCTP_VDM_CODE,P_MESSAGE_CODE,P_TARGET_ID,P_VENDOR_ID,M_R1,M_HDR_VER,M_DEST_EID,M_SOURCE_EID,M_SOM,M_EOM,M_PKT_SEQ,M_TO,M_MSG_TAG};
 
 packet_valid_check(parsed_data);
 print_packet_invalid();
 print_packet_valid();
endtask:packet_parsing

function void cxl_io_mctp:: packet_valid_check(bit[127:0] parsed_data);
 {P_R1,P_FMT,P_TYPE,P_R2,P_TC,P_R3,P_TD,P_EP,P_ATTR,P_R4,P_LEN,P_REQ_ID,P_R5,P_PAD_LEN,P_MCTP_VDM_CODE,P_MESSAGE_CODE,P_TARGET_ID,P_VENDOR_ID,M_R1,M_HDR_VER,M_DEST_EID,M_SOURCE_EID,M_SOM,M_EOM,M_PKT_SEQ,M_TO,M_MSG_TAG} = parsed_data;


 //Rules
 if(P_FMT != 0)
 begin

 end





endfunction




function void cxl_io_mctp:: print_packet_valid();
	$display("|-----------------------------------------------------------|");
	$display("|                                                           |");
	$display("|                                                           |");
	$display("|                                                           |");
	$display("|                 PACKET IS VALID                           |");
	$display("|                                                           |");
	$display("|                                                           |");
	$display("|                                                           |");
	$display("|-----------------------------------------------------------|");
endfunction





function void cxl_io_mctp:: print_packet_invalid();
	$display("|-----------------------------------------------------------|");
	$display("|                                                           |");
	$display("|                                                           |");
	$display("|                                                           |");
	$display("|                 PACKET IS INVALID                         |");
	$display("|                                                           |");
	$display("|                                                           |");
	$display("|                                                           |");
	$display("|-----------------------------------------------------------|");

endfunction
