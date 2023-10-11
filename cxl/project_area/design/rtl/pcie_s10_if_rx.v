

`resetall
`timescale 1ns / 1ps
`default_nettype none

/*
 * Intel Stratix 10 H-Tile/L-Tile PCIe interface adapter (receive)
 */
module pcie_s10_if_rx #
(
    // H-Tile/L-Tile AVST segment count
    parameter SEG_COUNT = 1,
    // H-Tile/L-Tile AVST segment data width
    parameter SEG_DATA_WIDTH = 256,
    // H-Tile/L-Tile AVST segment empty signal width
    parameter SEG_EMPTY_WIDTH = $clog2(SEG_DATA_WIDTH/32),
    // TLP data width
    parameter TLP_DATA_WIDTH = SEG_COUNT*SEG_DATA_WIDTH,
    // TLP strobe width
    parameter TLP_STRB_WIDTH = TLP_DATA_WIDTH/32,
    // TLP header width
    parameter TLP_HDR_WIDTH = 128,
    // TLP segment count
    parameter TLP_SEG_COUNT = 1,
    // IO bar index
    // rx_st_bar_range = 6 is mapped to IO_BAR_INDEX on rx_req_tlp_bar_id
    parameter IO_BAR_INDEX = 5
)
(
    input  wire                                    clk,
    input  wire                                    rst,

    /*
     * H-Tile/L-Tile RX AVST interface
     */
    input  wire [SEG_COUNT*SEG_DATA_WIDTH-1:0]     rx_st_data,
    input  wire [SEG_COUNT*SEG_EMPTY_WIDTH-1:0]    rx_st_empty,
    input  wire [SEG_COUNT-1:0]                    rx_st_sop,
    input  wire [SEG_COUNT-1:0]                    rx_st_eop,
    input  wire [SEG_COUNT-1:0]                    rx_st_valid,
    output wire                                    rx_st_ready,
    input  wire [SEG_COUNT-1:0]                    rx_st_vf_active,
    input  wire [SEG_COUNT*2-1:0]                  rx_st_func_num,
    input  wire [SEG_COUNT*11-1:0]                 rx_st_vf_num,
    input  wire [SEG_COUNT*3-1:0]                  rx_st_bar_range,

    /*
     * TLP output (request to BAR)
     */
    output wire [TLP_DATA_WIDTH-1:0]               rx_req_tlp_data,
    output wire [TLP_STRB_WIDTH-1:0]               rx_req_tlp_strb,
    output wire [TLP_SEG_COUNT*TLP_HDR_WIDTH-1:0]  rx_req_tlp_hdr,
    output wire [TLP_SEG_COUNT*3-1:0]              rx_req_tlp_bar_id,
    output wire [TLP_SEG_COUNT*8-1:0]              rx_req_tlp_func_num,
    output wire [TLP_SEG_COUNT-1:0]                rx_req_tlp_valid,
    output wire [TLP_SEG_COUNT-1:0]                rx_req_tlp_sop,
    output wire [TLP_SEG_COUNT-1:0]                rx_req_tlp_eop,
    input  wire                                    rx_req_tlp_ready,

    /*
     * TLP output (completion to DMA)
     */
    output wire [TLP_DATA_WIDTH-1:0]               rx_cpl_tlp_data,
    output wire [TLP_STRB_WIDTH-1:0]               rx_cpl_tlp_strb,
    output wire [TLP_SEG_COUNT*TLP_HDR_WIDTH-1:0]  rx_cpl_tlp_hdr,
    output wire [TLP_SEG_COUNT*4-1:0]              rx_cpl_tlp_error,
    output wire [TLP_SEG_COUNT-1:0]                rx_cpl_tlp_valid,
    output wire [TLP_SEG_COUNT-1:0]                rx_cpl_tlp_sop,
    output wire [TLP_SEG_COUNT-1:0]                rx_cpl_tlp_eop,
    input  wire                                    rx_cpl_tlp_ready
);

parameter SEG_STRB_WIDTH = SEG_DATA_WIDTH/32;

parameter INT_TLP_SEG_COUNT = SEG_COUNT;
parameter INT_TLP_SEG_DATA_WIDTH = TLP_DATA_WIDTH / INT_TLP_SEG_COUNT;
parameter INT_TLP_SEG_STRB_WIDTH = TLP_STRB_WIDTH / INT_TLP_SEG_COUNT;

// bus width assertions
initial begin
    if (SEG_DATA_WIDTH != 256) begin
        $error("Error: segment data width must be 256 (instance %m)");
        $finish;        
    end

    if (TLP_DATA_WIDTH != SEG_COUNT*SEG_DATA_WIDTH) begin
        $error("Error: Interface widths must match (instance %m)");
        $finish;
    end

    if (TLP_HDR_WIDTH != 128) begin
        $error("Error: TLP segment header width must be 128 (instance %m)");
        $finish;
    end
end

reg [TLP_DATA_WIDTH-1:0] rx_tlp_data_reg = 0, rx_tlp_data_next;
reg [TLP_STRB_WIDTH-1:0] rx_tlp_strb_reg = 0, rx_tlp_strb_next;
reg [INT_TLP_SEG_COUNT*TLP_HDR_WIDTH-1:0] rx_tlp_hdr_reg = 0, rx_tlp_hdr_next;
reg [INT_TLP_SEG_COUNT*3-1:0] rx_tlp_bar_id_reg = 0, rx_tlp_bar_id_next;
reg [INT_TLP_SEG_COUNT*8-1:0] rx_tlp_func_num_reg = 0, rx_tlp_func_num_next;
reg [INT_TLP_SEG_COUNT-1:0] rx_tlp_valid_reg = 0, rx_tlp_valid_next;
reg [INT_TLP_SEG_COUNT-1:0] rx_tlp_sop_reg = 0, rx_tlp_sop_next;
reg [INT_TLP_SEG_COUNT-1:0] rx_tlp_eop_reg = 0, rx_tlp_eop_next;
reg tlp_hdr_4dw_reg = 0, tlp_hdr_4dw_next;

wire fifo_tlp_ready;
wire [1:0] fifo_watermark;

reg [TLP_STRB_WIDTH-1:0] rx_st_strb;
reg [TLP_STRB_WIDTH-1:0] rx_st_strb_sop;
reg [TLP_STRB_WIDTH-1:0] rx_st_strb_eop;

reg [TLP_DATA_WIDTH-1:0] rx_st_data_int_reg = 0, rx_st_data_int_next;
reg [TLP_STRB_WIDTH-1:0] rx_st_strb_int_reg = 0, rx_st_strb_int_next;
reg [SEG_COUNT-1:0] rx_st_sop_int_reg = 0, rx_st_sop_int_next;
reg [SEG_COUNT-1:0] rx_st_eop_int_reg = 0, rx_st_eop_int_next;
reg [SEG_COUNT-1:0] rx_st_valid_int_reg = 0, rx_st_valid_int_next;
reg [TLP_STRB_WIDTH-1:0] rx_st_strb_sop_int_reg = 0, rx_st_strb_sop_int_next;
reg [TLP_STRB_WIDTH-1:0] rx_st_strb_eop_int_reg = 0, rx_st_strb_eop_int_next;
reg [SEG_COUNT-1:0] rx_st_vf_active_int_reg = 0, rx_st_vf_active_int_next;
reg [SEG_COUNT*2-1:0] rx_st_func_num_int_reg = 0, rx_st_func_num_int_next;
reg [SEG_COUNT*11-1:0] rx_st_vf_num_int_reg = 0, rx_st_vf_num_int_next;
reg [SEG_COUNT*3-1:0] rx_st_bar_range_int_reg = 0, rx_st_bar_range_int_next;

wire [TLP_DATA_WIDTH*2-1:0] rx_st_data_full = {rx_st_data, rx_st_data_int_reg};
wire [TLP_STRB_WIDTH*2-1:0] rx_st_strb_full = {rx_st_strb, rx_st_strb_int_reg};
wire [SEG_COUNT*2-1:0] rx_st_sop_full = {rx_st_sop, rx_st_sop_int_reg};
wire [SEG_COUNT*2-1:0] rx_st_eop_full = {rx_st_eop, rx_st_eop_int_reg};
wire [SEG_COUNT*2-1:0] rx_st_valid_full = {rx_st_valid, rx_st_valid_int_reg};
wire [TLP_STRB_WIDTH*2-1:0] rx_st_strb_sop_full = {rx_st_strb_sop, rx_st_strb_sop_int_reg};
wire [TLP_STRB_WIDTH*2-1:0] rx_st_strb_eop_full = {rx_st_strb_eop, rx_st_strb_eop_int_reg};
wire [SEG_COUNT*2-1:0] rx_st_vf_active_full = {rx_st_vf_active, rx_st_vf_active_int_reg};
wire [SEG_COUNT*2*2-1:0] rx_st_func_num_full = {rx_st_func_num, rx_st_func_num_int_reg};
wire [SEG_COUNT*2*11-1:0] rx_st_vf_num_full = {rx_st_vf_num, rx_st_vf_num_int_reg};
wire [SEG_COUNT*2*3-1:0] rx_st_bar_range_full = {rx_st_bar_range, rx_st_bar_range_int_reg};

reg [INT_TLP_SEG_COUNT*128-1:0] tlp_hdr;
reg [INT_TLP_SEG_COUNT*3-1:0] tlp_bar_id;
reg [INT_TLP_SEG_COUNT*8-1:0] tlp_func_num;

assign rx_st_ready = !fifo_watermark;

// demux w/FIFOs
wire [INT_TLP_SEG_COUNT*128-1:0] demux_match_tlp_hdr;

wire [INT_TLP_SEG_COUNT-1:0] demux_drop = 0;
wire [2*INT_TLP_SEG_COUNT-1:0] demux_select;

generate

    genvar m, n;

    for (n = 0; n < INT_TLP_SEG_COUNT; n = n + 1) begin
        // send completions to port 1 (fmt/type 8'b0x0_0101x)
        assign demux_select[1*INT_TLP_SEG_COUNT+n] = demux_match_tlp_hdr[n*128+121 +: 5] == 5'b00101;
        assign demux_select[0*INT_TLP_SEG_COUNT+n] = !demux_select[1*INT_TLP_SEG_COUNT+n];
    end

endgenerate

wire [TLP_SEG_COUNT*3-1:0] rx_cpl_tlp_bar_id;
wire [TLP_SEG_COUNT*8-1:0] rx_cpl_tlp_func_num;

pcie_tlp_demux #(
    .PORTS(2),
    .TLP_DATA_WIDTH(TLP_DATA_WIDTH),
    .TLP_STRB_WIDTH(TLP_STRB_WIDTH),
    .TLP_HDR_WIDTH(TLP_HDR_WIDTH),
    .SEQ_NUM_WIDTH(1),
    .IN_TLP_SEG_COUNT(INT_TLP_SEG_COUNT),
    .OUT_TLP_SEG_COUNT(TLP_SEG_COUNT),
    .FIFO_ENABLE(1),
    .FIFO_DEPTH((1024/4)*2),
    .FIFO_WATERMARK((1024/4)*2-TLP_STRB_WIDTH*20)
)
pcie_tlp_demux_inst (
    .clk(clk),
    .rst(rst),

    /*
     * TLP input
     */
    .in_tlp_data(rx_tlp_data_reg),
    .in_tlp_strb(rx_tlp_strb_reg),
    .in_tlp_hdr(rx_tlp_hdr_reg),
    .in_tlp_seq(0),
    .in_tlp_bar_id(rx_tlp_bar_id_reg),
    .in_tlp_func_num(rx_tlp_func_num_reg),
    .in_tlp_error(0),
    .in_tlp_valid(rx_tlp_valid_reg),
    .in_tlp_sop(rx_tlp_sop_reg),
    .in_tlp_eop(rx_tlp_eop_reg),
    .in_tlp_ready(fifo_tlp_ready),

    /*
     * TLP output
     */
    .out_tlp_data({rx_cpl_tlp_data, rx_req_tlp_data}),
    .out_tlp_strb({rx_cpl_tlp_strb, rx_req_tlp_strb}),
    .out_tlp_hdr({rx_cpl_tlp_hdr, rx_req_tlp_hdr}),
    .out_tlp_seq(),
    .out_tlp_bar_id({rx_cpl_tlp_bar_id, rx_req_tlp_bar_id}),
    .out_tlp_func_num({rx_cpl_tlp_func_num, rx_req_tlp_func_num}),
    .out_tlp_error(),
    .out_tlp_valid({rx_cpl_tlp_valid, rx_req_tlp_valid}),
    .out_tlp_sop({rx_cpl_tlp_sop, rx_req_tlp_sop}),
    .out_tlp_eop({rx_cpl_tlp_eop, rx_req_tlp_eop}),
    .out_tlp_ready({rx_cpl_tlp_ready, rx_req_tlp_ready}),

    /*
     * Fields
     */
    .match_tlp_hdr(demux_match_tlp_hdr),
    .match_tlp_bar_id(),
    .match_tlp_func_num(),

    /*
     * Control
     */
    .enable(1'b1),
    .drop(demux_drop),
    .select(demux_select),

    /*
     * Status
     */
    .fifo_half_full(),
    .fifo_watermark(fifo_watermark)
);

assign rx_cpl_tlp_error = 0;

integer seg, lane;
reg valid;

always @* begin
    rx_tlp_data_next = rx_tlp_data_reg;
    rx_tlp_strb_next = rx_tlp_strb_reg;
    rx_tlp_hdr_next = rx_tlp_hdr_reg;
    rx_tlp_bar_id_next = rx_tlp_bar_id_reg;
    rx_tlp_func_num_next = rx_tlp_func_num_reg;
    rx_tlp_valid_next = fifo_tlp_ready ? 0 : rx_tlp_valid_reg;
    rx_tlp_sop_next = rx_tlp_sop_reg;
    rx_tlp_eop_next = rx_tlp_eop_reg;
    tlp_hdr_4dw_next = tlp_hdr_4dw_reg;

    rx_st_data_int_next = rx_st_data_int_reg;
    rx_st_strb_int_next = rx_st_strb_int_reg;
    rx_st_sop_int_next = rx_st_sop_int_reg;
    rx_st_eop_int_next = rx_st_eop_int_reg;
    rx_st_valid_int_next = rx_st_valid_int_reg;
    rx_st_strb_sop_int_next = rx_st_strb_sop_int_reg;
    rx_st_strb_eop_int_next = rx_st_strb_eop_int_reg;
    rx_st_vf_active_int_next = rx_st_vf_active_int_reg;
    rx_st_func_num_int_next = rx_st_func_num_int_reg;
    rx_st_vf_num_int_next = rx_st_vf_num_int_reg;
    rx_st_bar_range_int_next = rx_st_bar_range_int_reg;

    // decode framing
    for (seg = 0; seg < SEG_COUNT; seg = seg + 1) begin
        rx_st_strb[SEG_STRB_WIDTH*seg +: SEG_STRB_WIDTH] = {SEG_STRB_WIDTH{1'b1}};
        rx_st_strb_sop[SEG_STRB_WIDTH*seg +: SEG_STRB_WIDTH] = rx_st_sop[seg];
        rx_st_strb_eop[SEG_STRB_WIDTH*seg +: SEG_STRB_WIDTH] = 0;
        if (rx_st_eop[seg]) begin
            rx_st_strb[SEG_STRB_WIDTH*seg +: SEG_STRB_WIDTH] = {SEG_STRB_WIDTH{1'b1}} >> rx_st_empty[SEG_EMPTY_WIDTH*seg +: SEG_EMPTY_WIDTH];
            rx_st_strb_eop[SEG_STRB_WIDTH*seg +: SEG_STRB_WIDTH] = {1'b1, {SEG_STRB_WIDTH-1{1'b0}}} >> rx_st_empty[SEG_EMPTY_WIDTH*seg +: SEG_EMPTY_WIDTH];
        end
    end

    for (seg = 0; seg < INT_TLP_SEG_COUNT; seg = seg + 1) begin
        // extract header
        tlp_hdr[128*seg+96 +: 32] = rx_st_data_full[SEG_DATA_WIDTH*seg+0 +: 32];
        tlp_hdr[128*seg+64 +: 32] = rx_st_data_full[SEG_DATA_WIDTH*seg+32 +: 32];
        tlp_hdr[128*seg+32 +: 32] = rx_st_data_full[SEG_DATA_WIDTH*seg+64 +: 32];
        tlp_hdr[128*seg+0 +: 32] = rx_st_data_full[SEG_DATA_WIDTH*seg+96 +: 32];

        case (rx_st_bar_range_full[3*seg +: 3])
            3'd6: tlp_bar_id[3*seg +: 3] = IO_BAR_INDEX; // IO BAR
            3'd7: tlp_bar_id[3*seg +: 3] = 6; // expansion ROM BAR
            default: tlp_bar_id[3*seg +: 3] = rx_st_bar_range_full[3*seg +: 3]; // memory BAR
        endcase

        tlp_func_num[8*seg +: 8] = rx_st_func_num_full[2*seg +: 2];
    end

    if (fifo_tlp_ready) begin
        rx_tlp_strb_next = 0;
        rx_tlp_valid_next = 0;
        rx_tlp_sop_next = 0;
        rx_tlp_eop_next = 0;
        for (seg = 0; seg < INT_TLP_SEG_COUNT; seg = seg + 1) begin
            if (rx_st_valid_full[seg]) begin
                if (rx_st_sop_full[seg]) begin
                    rx_tlp_hdr_next[TLP_HDR_WIDTH*seg +: TLP_HDR_WIDTH] = tlp_hdr[128*seg +: 128];
                    rx_tlp_bar_id_next[3*seg +: 3] = tlp_bar_id[3*seg +: 3];
                    rx_tlp_func_num_next[8*seg +: 8] = tlp_func_num[8*seg +: 8];
                    tlp_hdr_4dw_next = tlp_hdr[128*seg+125];
                end
                rx_tlp_sop_next[seg] = rx_st_sop_full[seg];
                rx_tlp_data_next[INT_TLP_SEG_DATA_WIDTH*seg +: INT_TLP_SEG_DATA_WIDTH] = rx_st_data_full >> (INT_TLP_SEG_DATA_WIDTH*seg + (32*(3+tlp_hdr_4dw_next)));
                if (rx_st_eop_full[seg]) begin
                    rx_tlp_strb_next[INT_TLP_SEG_STRB_WIDTH*seg +: INT_TLP_SEG_STRB_WIDTH] = rx_st_strb_full[INT_TLP_SEG_STRB_WIDTH*seg +: INT_TLP_SEG_STRB_WIDTH] >> (3+tlp_hdr_4dw_next);
                    if (rx_st_sop_full[seg] || rx_st_strb_eop_full[INT_TLP_SEG_STRB_WIDTH*seg +: INT_TLP_SEG_STRB_WIDTH] >> (3+tlp_hdr_4dw_next)) begin
                        rx_tlp_eop_next[seg] = 1'b1;
                        rx_tlp_valid_next[seg] = 1'b1;
                    end
                    rx_st_valid_int_next[seg] = 1'b0;
                end else begin
                    rx_tlp_strb_next[INT_TLP_SEG_STRB_WIDTH*seg +: INT_TLP_SEG_STRB_WIDTH] = rx_st_strb_full >> ((3+tlp_hdr_4dw_next) + INT_TLP_SEG_STRB_WIDTH*seg);
                    if (rx_st_valid_full[seg+1]) begin
                        rx_tlp_eop_next[seg] = (rx_st_strb_eop_full[INT_TLP_SEG_STRB_WIDTH*(seg+1) +: INT_TLP_SEG_STRB_WIDTH] & (tlp_hdr_4dw_next ? 4'hF : 4'h7)) != 0;
                        rx_tlp_valid_next[seg] = 1'b1;
                        rx_st_valid_int_next[seg] = 1'b0;
                    end
                end
            end
        end
    end

    if (rx_st_valid) begin
        rx_st_data_int_next = rx_st_data;
        rx_st_strb_int_next = rx_st_strb;
        rx_st_sop_int_next = rx_st_sop;
        rx_st_eop_int_next = rx_st_eop;
        rx_st_valid_int_next = rx_st_valid;
        rx_st_strb_sop_int_next = rx_st_strb_sop;
        rx_st_strb_eop_int_next = rx_st_strb_eop;
        rx_st_vf_active_int_next = rx_st_vf_active;
        rx_st_func_num_int_next = rx_st_func_num;
        rx_st_vf_num_int_next = rx_st_vf_num;
        rx_st_bar_range_int_next = rx_st_bar_range;
    end
end

always @(posedge clk) begin
    rx_tlp_data_reg <= rx_tlp_data_next;
    rx_tlp_strb_reg <= rx_tlp_strb_next;
    rx_tlp_hdr_reg <= rx_tlp_hdr_next;
    rx_tlp_bar_id_reg <= rx_tlp_bar_id_next;
    rx_tlp_func_num_reg <= rx_tlp_func_num_next;
    rx_tlp_valid_reg <= rx_tlp_valid_next;
    rx_tlp_sop_reg <= rx_tlp_sop_next;
    rx_tlp_eop_reg <= rx_tlp_eop_next;
    tlp_hdr_4dw_reg <= tlp_hdr_4dw_next;

    rx_st_data_int_reg <= rx_st_data_int_next;
    rx_st_strb_int_reg <= rx_st_strb_int_next;
    rx_st_sop_int_reg <= rx_st_sop_int_next;
    rx_st_eop_int_reg <= rx_st_eop_int_next;
    rx_st_valid_int_reg <= rx_st_valid_int_next;
    rx_st_strb_sop_int_reg <= rx_st_strb_sop_int_next;
    rx_st_strb_eop_int_reg <= rx_st_strb_eop_int_next;
    rx_st_vf_active_int_reg <= rx_st_vf_active_int_next;
    rx_st_func_num_int_reg <= rx_st_func_num_int_next;
    rx_st_vf_num_int_reg <= rx_st_vf_num_int_next;
    rx_st_bar_range_int_reg <= rx_st_bar_range_int_next;

    if (rst) begin
        rx_tlp_valid_reg <= 0;

        rx_st_valid_int_reg <= 0;
    end
end

endmodule

`resetall
