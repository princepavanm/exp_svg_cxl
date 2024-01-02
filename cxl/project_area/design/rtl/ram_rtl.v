//1 kilo byte Random Access Memory

`timescale 1ns / 1ps
module ram #(

	parameter ADDR = 8,
	parameter DATA = 8,
	parameter DEPTH = 1024

     )
     (


input  wire clk,
input wire write_enable,
input wire [ADDR-1:0]address,
input wire[DATA-1:0]data_in,
output  reg [DATA-1:0]data_out
);

//reg data_out;
//Declration of memory
reg [DATA-1:0]ram_block[DEPTH-1:0];

always @(posedge clk) begin
        if(write_enable)
            ram_block[address] <= data_in;
        else
            data_out <= ram_block[address];
end

endmodule


