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

class comp_tx extends uvm_sequence_item;

 bit [`TLP_DATA_WIDTH-1:0]               tx_cpl_tlp_data;
 bit [`TLP_STRB_WIDTH-1:0]               tx_cpl_tlp_strb;
 bit [`TLP_SEG_COUNT*`TLP_HDR_WIDTH-1:0]  tx_cpl_tlp_hdr;
 bit [`TLP_SEG_COUNT-1:0]                tx_cpl_tlp_valid;
 bit [`TLP_SEG_COUNT-1:0]                tx_cpl_tlp_sop;
 bit [`TLP_SEG_COUNT-1:0]                tx_cpl_tlp_eop;
 bit                                    tx_cpl_tlp_ready;


  `uvm_object_utils_begin(comp_tx)
    `uvm_field_int(tx_cpl_tlp_data  , UVM_ALL_ON)
    `uvm_field_int(tx_cpl_tlp_strb, UVM_ALL_ON)
    `uvm_field_int(tx_cpl_tlp_hdr , UVM_ALL_ON)
    `uvm_field_int(tx_cpl_tlp_valid, UVM_ALL_ON)
    `uvm_field_int(tx_cpl_tlp_sop,UVM_ALL_ON)
    `uvm_field_int(tx_cpl_tlp_eop, UVM_ALL_ON)
    `uvm_field_int(tx_cpl_tlp_ready,UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name="comp_tx");
    super.new(name);
  endfunction

endclass
