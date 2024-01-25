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

class cxl_mem_a2f_sqr extends uvm_sequencer#(cxl_mem_a2f_tx);

  `uvm_component_utils(cxl_mem_a2f_sqr)

  function new(string name="cxl_mem_a2f_sqr", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

endclass:cxl_mem_a2f_sqr
