//////////////////////////////////////////////////////////////////////////////////
// Company:  Expolog Technologies.
//           Copyright (c) 2023 by Expolog Technologies, Inc. All rights reserved.
//
// Engineer : Shriharsh.S.Joshi
// Revision tag :
// Module Name      :    
// Project Name      : 
// component name : cxl_io_mctp
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
`define PREP_EP_DISCOV  2'b00
`define EP_DISCOV       2'b01
`define SET_EP_ID       2'b10
`define DISCOVERED      1'b1
`define UNDISCOVERED    1'b0
`define ERROR_RESPONSE  2'b11



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
  bit [31:0]    M_PL_DATA;
  bit [15:0]    PCIE_DEV_ID = 16'hCAFE;
  bit [191:0]   RESPONSE_PKT;
  bit           DISCOVERY_FLAG = `DISCOVERED;
  cxl_tx             tx_h;
  
 // DISCOVERY_FLAG = `DISCOVERED;

  function new(string name="cxl_io_mctp", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction:build_phase



  extern task send_to_cxlio(input cxl_tx tx_h);
  extern function bit[191:0] get_response_cxlio();
  extern task packet_parsing(bit [63:0]tlp_data,bit [`TLP_SEG_COUNT*`TLP_HDR_WIDTH-1:0]tlp_hdr);
  extern function int  packet_valid_check(bit[191:0] parsed_data) ; 
  extern function void  packet_operations(bit[191:0] parsed_data) ; 
  extern function void  generate_response_packet(bit[191:0] parsed_data,bit[1:0] status) ; 
  extern function void  print_packet_valid(); 
  extern function void  print_packet_invalid(); 
endclass:cxl_io_mctp


task cxl_io_mctp::send_to_cxlio(input cxl_tx tx_h);
	bit [63:0] data;
	bit [`TLP_SEG_COUNT*`TLP_HDR_WIDTH-1:0] header;

	$display("=============================================CXLIO COMPONENT =======================================  ");
	header = tx_h.cxlio_mctp_req_hdr;
	data   = tx_h.cxlio_mctp_req_data[255:191];

	packet_parsing(data,header);
endtask: send_to_cxlio

task cxl_io_mctp::packet_parsing(bit [63:0] tlp_data,bit [`TLP_SEG_COUNT*`TLP_HDR_WIDTH-1:0] tlp_hdr);

 
 bit [191:0]        parsed_data;
 int                var1;

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
 M_PL_IC          = tlp_data[63];
 M_PL_MSG_TYP     = tlp_data[62:56]; 
 M_PL_RQ          = tlp_data[55];
 M_PL_D           = tlp_data[54];
 M_PL_R1          = tlp_data[53];
 M_PL_INST_ID     = tlp_data[52:48];
 M_PL_COMM_CODE   = tlp_data[47:40];
 M_PL_COMPL_CODE  = tlp_data[39:32];
 M_PL_DATA        = tlp_data[31:0];


 $display("=============================================PACKET DETAILS =======================================  ");
 
 `uvm_info("R1",              	$sformatf("R1 = %b",P_R1),				UVM_LOW)
 `uvm_info("Fmt",             	$sformatf("Fmt = %b",P_FMT),				UVM_LOW)
 `uvm_info("Type",           	$sformatf("Type = %b",P_TYPE),				UVM_LOW)
 `uvm_info("R2",              	$sformatf("R2 = %b",P_R2),				UVM_LOW)
 `uvm_info("TC",              	$sformatf("TC = %b",P_TC),				UVM_LOW)
 `uvm_info("R3",              	$sformatf("R3 = %b",P_R3),				UVM_LOW)
 `uvm_info("TD",              	$sformatf("TD = %b",P_TD),				UVM_LOW)
 `uvm_info("EP",              	$sformatf("EP = %b",P_EP),				UVM_LOW)
 `uvm_info("Attr",		$sformatf("Attr = %b",P_ATTR),				UVM_LOW)
 `uvm_info("R4",		$sformatf("R4 = %b",P_R4),				UVM_LOW)
 `uvm_info("Len",		$sformatf("Len = %b",P_LEN),				UVM_LOW)
 `uvm_info("Req_ID",		$sformatf("Req_ID = %b",P_REQ_ID),			UVM_LOW)
 `uvm_info("R5",		$sformatf("R5 = %b",P_R5),				UVM_LOW)
 `uvm_info("Pad_len",		$sformatf("Pad_len = %b",P_PAD_LEN),			UVM_LOW)
 `uvm_info("Mctp_vdm_code",	$sformatf("Mctp_vdm_code = %b",P_MCTP_VDM_CODE),	UVM_LOW)
 `uvm_info("Msg_Code",		$sformatf("Msg_Code = %b",P_MESSAGE_CODE),		UVM_LOW)
 `uvm_info("Tgt_ID",		$sformatf("Tgt_ID = %b",P_TARGET_ID),			UVM_LOW)
 `uvm_info("Vendor_ID",		$sformatf("Vendor_ID = %b",P_VENDOR_ID),		UVM_LOW)
 `uvm_info("M_RI",		$sformatf("M_R1 = %b",M_R1),				UVM_LOW)
 `uvm_info("M_HDR_VER",		$sformatf("M_HDR_VER = %b",M_HDR_VER),			UVM_LOW)
 `uvm_info("Dest_EID",		$sformatf("Dest_EID = %b",M_DEST_EID),			UVM_LOW)
 `uvm_info("Source_EID",	$sformatf("Source_EID = %b",M_SOURCE_EID),		UVM_LOW)
 `uvm_info("SOM",		$sformatf("SOM = %b",M_SOM),				UVM_LOW)
 `uvm_info("EOM",		$sformatf("EOM = %b",M_EOM),				UVM_LOW)
 `uvm_info("Pkt_seq",		$sformatf("Pkt_seq = %b",M_PKT_SEQ),			UVM_LOW)
 `uvm_info("M_TO",		$sformatf("TO = %b",M_TO),				UVM_LOW)
 `uvm_info("Msg_Tag",		$sformatf("Msg_Tag = %b",M_MSG_TAG),			UVM_LOW)
 `uvm_info("IC",		$sformatf("IC = %b",M_PL_IC),				UVM_LOW)
 `uvm_info("PL_MSG_TYP",	$sformatf("PL_MSG_TYP = %b",M_PL_MSG_TYP),		UVM_LOW)
 `uvm_info("RQ",		$sformatf("RQ = %b",M_PL_RQ),				UVM_LOW)
 `uvm_info("D",			$sformatf("D = %b",M_PL_D),				UVM_LOW)
 `uvm_info("PL_R1",		$sformatf("PL_R1 = %b",M_PL_R1),			UVM_LOW)
 `uvm_info("INST_ID",		$sformatf("INST_ID = %b",M_PL_INST_ID),			UVM_LOW)
 `uvm_info("Command code"	,$sformatf("Command Code = %b",M_PL_COMM_CODE),		UVM_LOW)
 `uvm_info("Completion code",	$sformatf("Completion Code = %b",M_PL_COMPL_CODE),	UVM_LOW)
 `uvm_info("Data",		$sformatf("Data = %b",M_PL_DATA),			UVM_LOW)

 parsed_data = {P_R1,P_FMT,P_TYPE,P_R2,P_TC,P_R3,P_TD,P_EP,P_ATTR,P_R4,P_LEN,P_REQ_ID,P_R5,P_PAD_LEN,P_MCTP_VDM_CODE,P_MESSAGE_CODE,P_TARGET_ID,P_VENDOR_ID,M_R1,M_HDR_VER,M_DEST_EID,M_SOURCE_EID,M_SOM,M_EOM,M_PKT_SEQ,M_TO,M_MSG_TAG,M_PL_IC,M_PL_MSG_TYP,M_PL_RQ,M_PL_D,M_PL_R1,M_PL_INST_ID,M_PL_COMM_CODE,M_PL_COMPL_CODE,M_PL_DATA};
 
 var1 = packet_valid_check(parsed_data);
 if(var1 == 0)
 begin
	 //`uvm_fatal();
 end
 else
 begin
 	packet_operations(parsed_data);
 end
endtask:packet_parsing

function int cxl_io_mctp:: packet_valid_check(bit[191:0] parsed_data);

int error;
 {P_R1,P_FMT,P_TYPE,P_R2,P_TC,P_R3,P_TD,P_EP,P_ATTR,P_R4,P_LEN,P_REQ_ID,P_R5,P_PAD_LEN,P_MCTP_VDM_CODE,P_MESSAGE_CODE,P_TARGET_ID,P_VENDOR_ID,M_R1,M_HDR_VER,M_DEST_EID,M_SOURCE_EID,M_SOM,M_EOM,M_PKT_SEQ,M_TO,M_MSG_TAG,M_PL_IC,M_PL_MSG_TYP,M_PL_RQ,M_PL_D,M_PL_R1,M_PL_INST_ID,M_PL_COMM_CODE,M_PL_COMPL_CODE,M_PL_DATA} = parsed_data;

error = 0;
 //Rules
 if(P_FMT != 3)
 begin
	 `uvm_error(get_type_name (), $sformatf ("[MCTP] ERROR: Check Format field, should be equal to 0")); 
	  error++;
 end
 if(P_TYPE[4:3] != 2'b10) 
 begin
	 `uvm_error(get_type_name (), $sformatf ("[MCTP] ERROR: Check Type[4:3] field, should be equal to 2"));
	  error++;
  end
 if(P_TC != 3'b000) 
 begin
	 `uvm_error(get_type_name (), $sformatf ("[MCTP] ERROR: Check  TC field , should be equal to 0"));
	  error++;
  end
 if(P_TD != 0) 
 begin
	 `uvm_error(get_type_name (), $sformatf ("[MCTP] ERROR: Check TD field, should be equal to 0"));
	  error++;
  end
 if(P_EP != 0)  
 begin
	 `uvm_error(get_type_name (), $sformatf ("[MCTP] ERROR: Check EP field, should be equal to 0"));
	  error++;
  end
 if(!(P_ATTR == 0 || P_ATTR == 1)) 
 begin
	 `uvm_error(get_type_name (), $sformatf ("[MCTP] ERROR: Check Attr field, should be equal to 0 or 1"));
	  error++;
 end
 if(P_MCTP_VDM_CODE != 0) 
 begin
	 `uvm_error(get_type_name (), $sformatf ("[MCTP] ERROR: Check MCTP VDM CODE field, should be equal to 0"));
	  error++;
  end
 if(P_MESSAGE_CODE != 8'b0111_1111) 
 begin
	 `uvm_error(get_type_name (), $sformatf ("[MCTP] ERROR: Check Message Code Vendor Defined field, should be equal to 0"));
	  error++;
  end
 if(M_HDR_VER != 4'b0001) 
 begin
	 `uvm_error(get_type_name (), $sformatf ("[MCTP] ERROR: Check Header Version field, should be equal to 0"));
	  error++;
  end
 if(M_PL_IC != 0) 
 begin
	 `uvm_error(get_type_name (), $sformatf ("[MCTP] ERROR: Check MCTP Payload IC field, should be equal to 0"));
	  error++;
 end
 if(M_PL_MSG_TYP != 0) 
 begin
	 `uvm_error(get_type_name (), $sformatf ("[MCTP] ERROR: Check MCTP Payload MSG Type field, should be equal to 0"));
	  error++;
  end



 //Signature Print
 if(error == 0)
 begin	
	 $display("error = %d",error); 
	 print_packet_valid();
	 return 1;
 end
 else 
 begin
	$display("error = %d",error); 
	print_packet_invalid();
	return 0;
 end





endfunction


function void cxl_io_mctp:: packet_operations(bit[191:0] parsed_data);
bit[1:0] status;
{P_R1,P_FMT,P_TYPE,P_R2,P_TC,P_R3,P_TD,P_EP,P_ATTR,P_R4,P_LEN,P_REQ_ID,P_R5,P_PAD_LEN,P_MCTP_VDM_CODE,P_MESSAGE_CODE,P_TARGET_ID,P_VENDOR_ID,M_R1,M_HDR_VER,M_DEST_EID,M_SOURCE_EID,M_SOM,M_EOM,M_PKT_SEQ,M_TO,M_MSG_TAG,M_PL_IC,M_PL_MSG_TYP,M_PL_RQ,M_PL_D,M_PL_R1,M_PL_INST_ID,M_PL_COMM_CODE,M_PL_COMPL_CODE,M_PL_DATA} = parsed_data;

if(P_TYPE[2:0] == 3'b011 && M_DEST_EID == 8'hFF && M_TO == 1 && M_PL_RQ == 1 && M_PL_D == 0 && M_PL_COMM_CODE == 'h0B)
begin
	$display("|-------------------------------------------------------------------------------------------------------|");
	$display("|                                BROADCAST MESSAGE TYPE DETECTED                                        |");
	$display("|                        ===\"PREPARE FOR ENDPOINT DISCOVERY [COMMAND]\"===                               |");
	$display("|-------------------------------------------------------------------------------------------------------|");
	status = `PREP_EP_DISCOV;
	DISCOVERY_FLAG = `UNDISCOVERED;
	generate_response_packet(parsed_data,status);
end


else if(P_TYPE[2:0] == 3'b011 && M_DEST_EID == 8'hFF && M_TO == 1 && M_PL_RQ == 1 && M_PL_D == 0 && M_PL_COMM_CODE == 'h0C)
begin
	$display("|-------------------------------------------------------------------------------------------------------|");
	$display("|                                BROADCAST MESSAGE TYPE DETECTED                                        |");
	$display("|                              ===\"ENDPOINT DISCOVERY [COMMAND]\"===                                     |");
	$display("|-------------------------------------------------------------------------------------------------------|");
	status = `EP_DISCOV;
	generate_response_packet(parsed_data,status);
end

else if(P_TYPE[2:0] == 3'b010 && M_DEST_EID == 0 && M_TO == 1 && M_PL_RQ == 1 && M_PL_D == 0 && M_PL_COMM_CODE == 'h01 && P_TARGET_ID == PCIE_DEV_ID )
begin
	$display("|-------------------------------------------------------------------------------------------------------|");
	$display("|                                ROUTE BY ID MESSAGE TYPE DETECTED                                      |");
	$display("|                               ===\"SET ENDPOINT ID [COMMAND]\"===                                       |");
	$display("|-------------------------------------------------------------------------------------------------------|");
	status = `SET_EP_ID;
	DISCOVERY_FLAG = `DISCOVERED;
	generate_response_packet(parsed_data,status);
end

else
begin
	$display("|-------------------------------------------------------------------------------------------------------|");
	$display("|                                THIS FEATURE IS NOT YET IMPLEMENTED                                    |");
	$display("|                                ONLY FULL DISCOVERY IS IMPLEMENTED                                     |");
	$display("|-------------------------------------------------------------------------------------------------------|");
	status=`ERROR_RESPONSE;
	generate_response_packet(parsed_data,status);
end


endfunction

function void cxl_io_mctp:: generate_response_packet(bit[191:0] parsed_data,bit[1:0] status);
{P_R1,P_FMT,P_TYPE,P_R2,P_TC,P_R3,P_TD,P_EP,P_ATTR,P_R4,P_LEN,P_REQ_ID,P_R5,P_PAD_LEN,P_MCTP_VDM_CODE,P_MESSAGE_CODE,P_TARGET_ID,P_VENDOR_ID,M_R1,M_HDR_VER,M_DEST_EID,M_SOURCE_EID,M_SOM,M_EOM,M_PKT_SEQ,M_TO,M_MSG_TAG,M_PL_IC,M_PL_MSG_TYP,M_PL_RQ,M_PL_D,M_PL_R1,M_PL_INST_ID,M_PL_COMM_CODE,M_PL_COMPL_CODE,M_PL_DATA} = parsed_data;

if(status == `PREP_EP_DISCOV)
begin
	P_REQ_ID = PCIE_DEV_ID;
	M_DEST_EID = M_SOURCE_EID;
	M_SOURCE_EID = 'h00;
	M_TO =0;
	M_PL_RQ = 0;
	M_PL_D  = 0;
	M_PL_COMPL_CODE = 0;
	RESPONSE_PKT = {P_R1,P_FMT,P_TYPE,P_R2,P_TC,P_R3,P_TD,P_EP,P_ATTR,P_R4,P_LEN,P_REQ_ID,P_R5,P_PAD_LEN,P_MCTP_VDM_CODE,P_MESSAGE_CODE,P_TARGET_ID,P_VENDOR_ID,M_R1,M_HDR_VER,M_DEST_EID,M_SOURCE_EID,M_SOM,M_EOM,M_PKT_SEQ,M_TO,M_MSG_TAG,M_PL_IC,M_PL_MSG_TYP,M_PL_RQ,M_PL_D,M_PL_R1,M_PL_INST_ID,M_PL_COMM_CODE,M_PL_COMPL_CODE,M_PL_DATA};

end

else if(status == `EP_DISCOV)
begin
	P_REQ_ID = PCIE_DEV_ID;
	M_DEST_EID = M_SOURCE_EID;
	M_SOURCE_EID = 'h00;
	M_TO =0;
	M_PL_RQ = 0;
	M_PL_D  = 0;
	M_PL_COMPL_CODE = 0;
	RESPONSE_PKT = {P_R1,P_FMT,P_TYPE,P_R2,P_TC,P_R3,P_TD,P_EP,P_ATTR,P_R4,P_LEN,P_REQ_ID,P_R5,P_PAD_LEN,P_MCTP_VDM_CODE,P_MESSAGE_CODE,P_TARGET_ID,P_VENDOR_ID,M_R1,M_HDR_VER,M_DEST_EID,M_SOURCE_EID,M_SOM,M_EOM,M_PKT_SEQ,M_TO,M_MSG_TAG,M_PL_IC,M_PL_MSG_TYP,M_PL_RQ,M_PL_D,M_PL_R1,M_PL_INST_ID,M_PL_COMM_CODE,M_PL_COMPL_CODE,M_PL_DATA};

end


else if(status == `SET_EP_ID)
begin
	P_TARGET_ID =  P_REQ_ID;
        P_REQ_ID = PCIE_DEV_ID;
	M_DEST_EID = M_SOURCE_EID;
	M_SOURCE_EID = M_PL_DATA[23:16];
	M_TO =0;
	M_PL_RQ = 0;
	M_PL_D  = 0;
	M_PL_COMPL_CODE  = 0;
	M_PL_DATA[7:0]   = 0;
	M_PL_DATA[15:8]  = M_SOURCE_EID;
	M_PL_DATA[23:16] = 0;
	M_PL_DATA[31:24] = 0;
	RESPONSE_PKT = {P_R1,P_FMT,P_TYPE,P_R2,P_TC,P_R3,P_TD,P_EP,P_ATTR,P_R4,P_LEN,P_REQ_ID,P_R5,P_PAD_LEN,P_MCTP_VDM_CODE,P_MESSAGE_CODE,P_TARGET_ID,P_VENDOR_ID,M_R1,M_HDR_VER,M_DEST_EID,M_SOURCE_EID,M_SOM,M_EOM,M_PKT_SEQ,M_TO,M_MSG_TAG,M_PL_IC,M_PL_MSG_TYP,M_PL_RQ,M_PL_D,M_PL_R1,M_PL_INST_ID,M_PL_COMM_CODE,M_PL_COMPL_CODE,M_PL_DATA};

end

else if(status == `ERROR_RESPONSE)
begin
	P_REQ_ID = PCIE_DEV_ID;
	M_DEST_EID = M_SOURCE_EID;
	M_SOURCE_EID = 'h00;
	M_TO =0;
	M_PL_RQ = 0;
	M_PL_D  = 0;
	M_PL_COMPL_CODE = 1;
	RESPONSE_PKT = {P_R1,P_FMT,P_TYPE,P_R2,P_TC,P_R3,P_TD,P_EP,P_ATTR,P_R4,P_LEN,P_REQ_ID,P_R5,P_PAD_LEN,P_MCTP_VDM_CODE,P_MESSAGE_CODE,P_TARGET_ID,P_VENDOR_ID,M_R1,M_HDR_VER,M_DEST_EID,M_SOURCE_EID,M_SOM,M_EOM,M_PKT_SEQ,M_TO,M_MSG_TAG,M_PL_IC,M_PL_MSG_TYP,M_PL_RQ,M_PL_D,M_PL_R1,M_PL_INST_ID,M_PL_COMM_CODE,M_PL_COMPL_CODE,M_PL_DATA};
end


endfunction

function bit[191:0] cxl_io_mctp:: get_response_cxlio();
	return RESPONSE_PKT;
endfunction


function void cxl_io_mctp:: print_packet_valid();
	$display("|-------------------------------------------------------------------------------------------------------|");
	$display("|                                                                                                       |");
	$display("|                                   PACKET IS VALID                                                     |");
	$display("|                                                                                                       |");
	$display("|-------------------------------------------------------------------------------------------------------|");

endfunction





function void cxl_io_mctp:: print_packet_invalid();
	$display("|-------------------------------------------------------------------------------------------------------|");
	$display("|                                                                                                       |");
	$display("|                                   PACKET IS INVALID                                                   |");
	$display("|                                                                                                       |");
	$display("|-------------------------------------------------------------------------------------------------------|");

endfunction
