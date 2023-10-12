class axi_agent_cov extends uvm_subscriber#(axi_agent_tx);

  `uvm_component_utils(axi_agent_cov)

  uvm_analysis_imp#(axi_agent_tx, axi_agent_cov)       axi_agent_cov_port;

  axi_agent_tx   axi_agent_tx_h;

// functional coverage

  covergroup axi_cg;
   option.per_instance=1;

    // write address channel
  AWID:coverpoint axi_agent_tx_h.m_axi_awid
  {
    bins all[]={[0:7]};  // cover all the values of awid from 0 to 7
  }

  AWADDR:coverpoint axi_agent_tx_h.m_axi_awaddr
  {
    bins low={[0:500]};      // cover the values upto [63:0] because awaddr width is 64bit
    bins mid1={[500:1000]};
    bins mid2={[1000:2000]};
    bins mid3={[2000:3000]};
    bins high={[3000:4000]};
  }

  AWLEN:coverpoint axi_agent_tx_h.m_axi_awlen
  {
    bins all[]={0};        // cover all the values
  }

  AWSIZE:coverpoint axi_agent_tx_h.m_axi_awsize
  {
    bins all[]={1};
  }

  AWBURST:coverpoint axi_agent_tx_h.m_axi_awburst
  {
    bins one[]={0};
  }

  AWVALID:coverpoint axi_agent_tx_h.m_axi_awvalid
  {
    bins low={0};
    bins high={1};
  }

  AWREADY:coverpoint axi_agent_tx_h.m_axi_awready
  {
    bins low={0};
    bins high={1};
  }
// write data channel
  WID:coverpoint axi_agent_tx_h.m_axi_awid
  {
    bins all[]={[0:15]};
  }

  WRITE_DATA:coverpoint axi_agent_tx_h.m_axi_wdata //[256]
  {
    bins low1={[0:5000]};
    bins mid2={[5000:10000]};
    bins mid3={[10000:20000]};
    bins mid4={[20000:50000]};
    bins high={[50000:65535]};	
  }

  WSTRB:coverpoint axi_agent_tx_h.m_axi_wstrb
  {
    bins all[]={[0:31]};
    
  }

  WLAST:coverpoint axi_agent_tx_h.m_axi_wlast
  {
    bins low={0};
    bins high={1};
  }

  WVALID:coverpoint axi_agent_tx_h.m_axi_wvalid
  {
    bins low={0};
    bins high={1};
  }

  WREADY:coverpoint axi_agent_tx_h.m_axi_wready
  {
    bins low={0};
    bins high={1};
  }

    // write response channel
  BID:coverpoint axi_agent_tx_h.m_axi_bid
  {
    bins all[]={[0:7]};
  }
  
  BRESP:coverpoint axi_agent_tx_h.m_axi_bresp
  {
    bins ok={0};
  }

  BVALID:coverpoint axi_agent_tx_h.m_axi_bvalid
  {
    bins low={0};
    bins high={1};
  }

  BREADY:coverpoint axi_agent_tx_h.m_axi_bready
  {
    bins low={0};
    bins high={1};
  }


    // read address channel

  ARID:coverpoint axi_agent_tx_h.m_axi_arid
  {
    bins all[]={[0:7]};
  }


  ARADDR:coverpoint axi_agent_tx_h.m_axi_araddr//64
  {
    bins low={[0:500]};
    bins mid1={[500:1000]};
    bins mid2={[1000:2000]};
    bins mid3={[2000:3000]};
    bins high={[3000:4000]};
  }

  ARLEN:coverpoint axi_agent_tx_h.m_axi_arlen
  {
    bins all={0};
  }

  ARSIZE:coverpoint axi_agent_tx_h.m_axi_arsize
  {
    bins all={1};
  }

  ARBURST:coverpoint axi_agent_tx_h.m_axi_arburst
  {
    bins one={0};
  }

  ARVALID:coverpoint axi_agent_tx_h.m_axi_arvalid
  {
    bins low={0};
    bins high={1};
  }

  ARREADY:coverpoint axi_agent_tx_h.m_axi_arready
  {
    bins low={0};
    bins high={1};
  }

// read data channel 
  RID:coverpoint axi_agent_tx_h.m_axi_rid
  {
    bins all[]={[0:15]};
  }

  READ_DATA:coverpoint axi_agent_tx_h.m_axi_rdata
  {
    bins low1={[0:5000]};
    bins mid2={[5000:10000]};
    bins mid3={[10000:20000]};
    bins mid4={[20000:50000]};
    bins high={[50000:65535]};	
  }
  RRESP:coverpoint axi_agent_tx_h.m_axi_rresp
  {
    bins ok={0};
  }
  RLAST:coverpoint axi_agent_tx_h.m_axi_rlast
  {
    bins low={0};
    bins high={1};
  }

  RVALID:coverpoint axi_agent_tx_h.m_axi_rvalid
  {
    bins low={0};
    bins high={1};
  }

  RREADY:coverpoint axi_agent_tx_h.m_axi_rready
  {
    bins low={0};
    bins high={1};
  }


  AWADDR_WDATA:cross AWADDR,WRITE_DATA;
  ARADDR_RDATA:cross ARADDR,READ_DATA;

endgroup : axi_cg
  

function new(string name="axi_agent_cov", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   axi_agent_cov_port = new("axi_agent_cov_port", this);
    axi_agent_tx_h = axi_agent_tx::type_id::create("axi_agent_tx_h", this);
  endfunction:build_phase

  function void write(axi_agent_tx   t);

    `uvm_info("AXI_AGENT_COV", "From Coverage Write function", UVM_LOW)

  endfunction:write

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("AXI_AGENT_COV","From Coverage Run Phase", UVM_LOW)

  endtask:run_phase

endclass:axi_agent_cov
