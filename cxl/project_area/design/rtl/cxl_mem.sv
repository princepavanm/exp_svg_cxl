`include "ram_rtl.v"

`timescale 1ns / 1ps

//Active low Reset
module fabric_manager(

//clk and reset

input bit                                                   fm_clk,
input bit                                                   fm_rst,


// CPI Interface Signals 
// Global layer Signals (A2F) Agent to fabric

input bit                                                  a2f_txcon_req,
output bit                                                 a2f_rxcon_ack,
output bit                                                 a2f_rxdiscon_nack,
output bit                                                 a2f_rx_empty,
input  bit                                                 a2f_fatal,

// Global layer Signals (F2A) Fabric to Agent

output  bit                                                f2a_txcon_req,
input   bit                                                f2a_rxcon_ack,
input   bit                                                f2a_rxdiscon_nack,
input   bit                                                f2a_rx_empty,
output  bit                                                f2a_fatal,

// Request layer Signals (A2F) Agent to fabric

input bit                                                  a2f_req_is_valid,
input bit[3:0]                                             a2f_req_protocol_id,
input bit[127:0]                                           a2f_req_header,


// Request layer Signals (F2A) Fabric to Agent

output bit                                                 f2a_req_is_valid,
output bit[3:0]                                            f2a_req_protocol_id,
output bit[127:0]                                          f2a_req_header,



// Response layer Signals (A2F) Agent to Fabric

input bit                                                  a2f_rsp_is_valid,
input bit[3:0]                                             a2f_rsp_protocol_id,
input bit[127:0]                                           a2f_rsp_header,
output bit                                                 a2f_rsp_excrd_valid,


// Response layer Signals (F2A) Fabric to Agent

output bit                                                 f2a_rsp_is_valid,
output bit[3:0]                                            f2a_rsp_protocol_id,
output bit[127:0]                                          f2a_rsp_header,
input bit                                                  f2a_rsp_excrd_valid,

// Data layer Signals (A2F) Agent to Fabric

input bit                                                  a2f_data_is_valid,             
input bit[3:0]                                             a2f_data_protocol_id,
input bit[127:0]                                           a2f_data_header,
input bit[127:0]                                           a2f_data_body,
input bit[3:0]                                             a2f_data_byte_en,
input bit                                                  a2f_data_poison,
input bit                                                  a2f_data_parity,
input bit                                                  a2f_data_eop,


// Data layer Signals (F2A) Fabric to Agent

output bit                                                 f2a_data_is_valid,                   
output bit[3:0]                                            f2a_data_protocol_id,
output bit[127:0]                                          f2a_data_header,
output bit[127:0]                                          f2a_data_body,
output bit[3:0]                                            f2a_data_byte_en,
output bit                                                 f2a_data_poison,
output bit                                                 f2a_data_parity,
output bit                                                 f2a_data_eop


); //assign the  sizes for each signals


//Declare Variables




//RAM RTL Instantiation
ram#(
		  .ADDR(10),
	  	  .DATA(8),
		  .DEPTH(1024)

		)
		device_mem(
		.clk(),
		.write_enable(),
		.write_address(),
		.data_in(),
		.data_out()
	);


always@(posedge fm_clk)
begin
	if(fm_rst == 0)
	begin
		fork
			a2f_connect_req();
			a2f_req_check();
			a2f_rsp_check();
			a2f_data_check();
		//	packet_parsing();
		join
	
	end
	else
	begin

	end
end

task a2f_connect_req();

		if($rose(a2f_txcon_req))
		begin
			a2f_rxcon_ack     = 1;
			a2f_rxdiscon_nack = 0;
		end
		else if($fell(a2f_txcon_req))
		begin
			a2f_rxcon_ack     = 0;
			a2f_rxdiscon_nack = 0;
		end

endtask

task a2f_req_check();
	if(a2f_req_is_valid == 1 && a2f_rxcon_ack == 1 && a2f_req_protocol_id == 4'b1001)
	begin
	end
endtask

task a2f_rsp_check();
	if(a2f_rsp_is_valid == 1 && a2f_rxcon_ack == 1 && a2f_rsp_protocol_id == 4'b1001)
	begin
	end
endtask

task a2f_data_check();
	if(a2f_data_is_valid == 1 && a2f_rxcon_ack == 1 && a2f_data_protocol_id == 4'b1001)
	begin
	end
endtask

task packet_parsing();

endtask



endmodule


