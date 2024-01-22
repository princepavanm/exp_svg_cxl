`include "ram_rtl.v"







module fabric_manager#()(

//clk and reset

input bit                                                   fm_clk;
input bit                                                   fm_rst;


// CPI Interface Signals 
// Global layer Signals (A2F) Agent to fabric

input bit                                                  a2f_txcon_req;
output bit                                                 a2f_rxcon_ack;
output bit                                                 a2f_rxdiscon_nack;
output bit                                                 a2f_rx_empty;
input  bit                                                 a2f_fatal;

// Global layer Signals (F2A) Fabric to Agent

output  bit                                                f2a_txcon_req;
input   bit                                                f2a_rxcon_ack;
input   bit                                                f2a_rxdiscon_nack;
input   bit                                                f2a_rx_empty;
output  bit                                                f2a_fatal;

// Request layer Signals (A2F) Agent to fabric

input bit                                                  a2f_req_is_valid;
input bit[3:0]                                             a2f_req_protocol_id;
input bit[128:0]                                           a2f_req_header;


// Request layer Signals (F2A) Fabric to Agent

output bit                                                 f2a_req_is_valid;
output bit[3:0]                                            f2a_req_protocol_id;
output bit[128:0]                                          f2a_req_header;



// Response layer Signals (A2F) Agent to Fabric

input bit                                                  a2f_rsp_is_valid;
input bit[3:0]                                             a2f_rsp_protocol_id;
input bit[128:0]                                           a2f_rsp_header;
output bit                                                 a2f_rsp_excrd_valid;


// Response layer Signals (F2A) Fabric to Agent

output bit                                                 f2a_rsp_is_valid;
output bit[3:0]                                            f2a_rsp_protocol_id;
output bit[128:0]                                          f2a_rsp_header;
input bit                                                  f2a_rsp_excrd_valid;

// Data layer Signals (A2F) Agent to Fabric

input bit                                                  a2f_data_is_valid;             
input bit[3:0]                                             a2f_data_protocol_id;
input bit[127:0]                                           a2f_data_header;
input bit[127:0]                                           a2f_data_body;
input bit[3:0]                                             a2f_data_byte_en;
input bit                                                  a2f_data_poison;
input bit                                                  a2f_data_parity;
input bit                                                  a2f_data_eop;


// Data layer Signals (F2A) Fabric to Agent

output bit                                                 f2a_data_is_valid;                   
output bit[3:0]                                            f2a_data_protocol_id;
output bit[127:0]                                          f2a_data_header;
output bit[127:0]                                          f2a_data_body;
output bit[3:0]                                            f2a_data_byte_en;
output bit                                                 f2a_data_poison;
output bit                                                 f2a_data_parity;
output bit                                                 f2a_data_eop;


); //assign the  sizes for each signals


//Declare Variables





//RAM RTL Instantiation
ram device_mem#(
		  ADDR = ;
	  	  DATA = ;
		  DEPTH = ;

		)
		(
		.clk(),
		.write_enable(),
		.address(),
		.data_in(),
		.data_out()
	);

endmodule
