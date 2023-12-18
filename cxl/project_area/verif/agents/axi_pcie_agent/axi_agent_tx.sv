class axi_agent_tx extends uvm_sequence_item;


 /*** write address channel signals ***/	
bit [`AXI_ID_WIDTH-1:0]                   m_axi_awid;
bit [`AXI_ADDR_WIDTH-1:0]                 m_axi_awaddr;
bit [7:0]                                 m_axi_awlen;
bit [2:0]                                 m_axi_awsize;
bit [1:0]                                 m_axi_awburst;
bit                                       m_axi_awlock;
bit [3:0]                                 m_axi_awcache;
bit [2:0]                                 m_axi_awprot;
bit                                       m_axi_awvalid;
rand bit                                  m_axi_awready;


/*** write data channel signals ***/

bit [`AXI_DATA_WIDTH-1:0]                 m_axi_wdata;
bit [`AXI_STRB_WIDTH-1:0]                 m_axi_wstrb;
bit                                       m_axi_wlast;
bit                                       m_axi_wvalid;
rand bit                                  m_axi_wready;

 /*** write response channel signals ***/
rand bit [`AXI_ID_WIDTH-1:0]              m_axi_bid;
rand bit [1:0]                            m_axi_bresp;
rand bit                                  m_axi_bvalid;
bit                                       m_axi_bready;

/*** read address cahnnel signals ***/
bit [`AXI_ID_WIDTH-1:0]                   m_axi_arid;
bit [`AXI_ADDR_WIDTH-1:0]                 m_axi_araddr;
bit [7:0]                                 m_axi_arlen;
bit [2:0]                                 m_axi_arsize;
bit [1:0]                                 m_axi_arburst;
bit                                       m_axi_arlock;
bit [3:0]                                 m_axi_arcache;
bit [2:0]                                 m_axi_arprot;
bit                                       m_axi_arvalid;
rand bit                                  m_axi_arready;

 /*** read data channel signals ***/
rand bit [`AXI_ID_WIDTH-1:0]              m_axi_rid;
rand bit [`AXI_DATA_WIDTH-1:0]            m_axi_rdata;
rand bit [1:0]                            m_axi_rresp;
rand bit                                  m_axi_rlast;
rand bit                                  m_axi_rvalid;
bit                                       m_axi_rready;

  `uvm_object_utils_begin(axi_agent_tx)
    `uvm_field_int(m_axi_awid  , UVM_ALL_ON)
    `uvm_field_int(m_axi_awaddr, UVM_ALL_ON)
    `uvm_field_int(m_axi_awlen , UVM_ALL_ON)
    `uvm_field_int(m_axi_awsize, UVM_ALL_ON)
    `uvm_field_int(m_axi_awburst,UVM_ALL_ON)
    `uvm_field_int(m_axi_awlock, UVM_ALL_ON)
    `uvm_field_int(m_axi_awcache,UVM_ALL_ON)
    `uvm_field_int(m_axi_awprot, UVM_ALL_ON)
    `uvm_field_int(m_axi_awvalid,UVM_ALL_ON)
    `uvm_field_int(m_axi_awready,UVM_ALL_ON)
    `uvm_field_int(m_axi_wdata , UVM_ALL_ON)
    `uvm_field_int(m_axi_wstrb , UVM_ALL_ON)
    `uvm_field_int(m_axi_wlast , UVM_ALL_ON)
    `uvm_field_int(m_axi_wvalid, UVM_ALL_ON)
    `uvm_field_int(m_axi_wready, UVM_ALL_ON)
    `uvm_field_int(m_axi_bid   , UVM_ALL_ON)
    `uvm_field_int(m_axi_bresp , UVM_ALL_ON)
    `uvm_field_int(m_axi_bvalid, UVM_ALL_ON)
    `uvm_field_int(m_axi_bready, UVM_ALL_ON)
    `uvm_field_int(m_axi_arid  , UVM_ALL_ON)
    `uvm_field_int(m_axi_araddr, UVM_ALL_ON)
    `uvm_field_int(m_axi_arlen , UVM_ALL_ON)
    `uvm_field_int(m_axi_arsize, UVM_ALL_ON)
    `uvm_field_int(m_axi_arburst,UVM_ALL_ON)
    `uvm_field_int(m_axi_arlock, UVM_ALL_ON)
    `uvm_field_int(m_axi_arcache,UVM_ALL_ON)
    `uvm_field_int(m_axi_arprot, UVM_ALL_ON)
    `uvm_field_int(m_axi_arvalid,UVM_ALL_ON)
    `uvm_field_int(m_axi_arready,UVM_ALL_ON)
    `uvm_field_int(m_axi_rid   , UVM_ALL_ON)
    `uvm_field_int(m_axi_rdata , UVM_ALL_ON)
    `uvm_field_int(m_axi_rresp , UVM_ALL_ON)
    `uvm_field_int(m_axi_rlast , UVM_ALL_ON)
    `uvm_field_int(m_axi_rvalid, UVM_ALL_ON)
    `uvm_field_int(m_axi_rready, UVM_ALL_ON)
      `uvm_object_utils_end

  function new(string name="axi_agent_tx");
    super.new(name);
  endfunction

endclass
