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
      

`define TLP_DATA_WIDTH  256
//`define TLP_STRB_WIDTH  (TLP_DATA_WIDTH/32)
`define TLP_STRB_WIDTH  8
`define TLP_HDR_WIDTH  128
`define TLP_SEG_COUNT  1
`define AXIL_DATA_WIDTH  32
`define AXIL_ADDR_WIDTH  64
`define AXIL_STRB_WIDTH  (AXIL_DATA_WIDTH/8)
`define TLP_FORCE_64_BIT_ADDR 0

`define TLP_HDR_WIDTH  128
`define TLP_SEG_COUNT  1
`define AXI_DATA_WIDTH  256
`define AXI_ADDR_WIDTH  64
//`define AXI_STRB_WIDTH  (AXI_DATA_WIDTH/8)
`define AXI_STRB_WIDTH  32
`define AXI_ID_WIDTH  8
`define AXI_MAX_BURST_LEN  256
