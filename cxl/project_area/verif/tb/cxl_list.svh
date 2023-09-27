//List of Include Files

  `include "tl_cxl_agent_intf.sv"
  `include "dl_cxl_agent_intf.sv"
  `include "ph_cxl_agent_intf.sv"
  `include "arb_cxl_agent_intf.sv"

  `include "tl_cxl_agent_tx.sv"
  `include "tl_cxl_agent_drv.sv"
  `include "tl_cxl_agent_sqr.sv"
  `include "tl_cxl_agent_cov.sv"
  `include "tl_cxl_agent_mon.sv"
  `include "tl_cxl_agent.sv"

  `include "dl_cxl_agent_tx.sv"
  `include "dl_cxl_agent_drv.sv"
  `include "dl_cxl_agent_sqr.sv"
  `include "dl_cxl_agent_cov.sv"
  `include "dl_cxl_agent_mon.sv"
  `include "dl_cxl_agent.sv"

  `include "ph_cxl_agent_tx.sv"
  `include "ph_cxl_agent_drv.sv"
  `include "ph_cxl_agent_sqr.sv"
  `include "ph_cxl_agent_cov.sv"
  `include "ph_cxl_agent_mon.sv"
  `include "ph_cxl_agent.sv"

  `include "arb_cxl_agent_tx.sv"
  `include "arb_cxl_agent_drv.sv"
  `include "arb_cxl_agent_sqr.sv"
  `include "arb_cxl_agent_cov.sv"
  `include "arb_cxl_agent_mon.sv"
  `include "arb_cxl_agent.sv"

  `include "pass_cxl_agent_mon.sv"
  `include "pass_cxl_agent.sv"

  `include "virtual_sqr.sv"

// Sequence List
  `include "../seqs/sequence_list.sv"
  `include "env.sv"

// Test List
  `include "../tests/test_list.sv"
