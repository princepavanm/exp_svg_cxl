class cxl_env extends uvm_env;
  `uvm_component_utils(cxl_env)

  tl_cxl_agent	tl_cxl_agent_h;
  dl_cxl_agent	dl_cxl_agent_h;
  ph_cxl_agent	ph_cxl_agent_h;
  arb_cxl_agent	arb_cxl_agent_h;

  cxl_virtual_sqr 	 v_sqr_h;

  function new(string name="cxl_env", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    v_sqr_h = cxl_virtual_sqr::type_id::create("v_sqr_h", this);

    tl_cxl_agent_h = tl_cxl_agent::type_id::create("tl_cxl_agent_h", this);
    dl_cxl_agent_h = dl_cxl_agent::type_id::create("dl_cxl_agent_h", this);
    ph_cxl_agent_h = ph_cxl_agent::type_id::create("ph_cxl_agent_h", this);
    arb_cxl_agent_h = arb_cxl_agent::type_id::create("arb_cxl_agent_h", this);

  endfunction:build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    v_sqr_h.tl_cxl_agent_sqr_h = tl_cxl_agent_h.sqr_h;
    v_sqr_h.dl_cxl_agent_sqr_h = dl_cxl_agent_h.sqr_h;
    v_sqr_h.ph_cxl_agent_sqr_h = ph_cxl_agent_h.sqr_h;
    v_sqr_h.arb_cxl_agent_sqr_h = arb_cxl_agent_h.sqr_h;

  endfunction:connect_phase

  function void report();

    uvm_report_server reportserver=uvm_report_server::get_server();

    $display("**************************************************");
    $display("****************** TEST Summary ******************");
    $display("**************************************************");

    if((reportserver.get_severity_count(UVM_FATAL)==0)&&(reportserver.get_severity_count(UVM_WARNING)==0)&&(reportserver.get_severity_count(UVM_ERROR)==0))  begin
      $display("**************************************************");
      $display("****************** TEST  PASSED ******************");
      $display("**************************************************");
    end//if_end

    else begin
      $display("**************************************************");
      $display("                    \\ / ");
      $display("                    oVo ");
      $display("            \\___XXX___/ ");
      $display("                 __XXXXX__ ");
      $display("                /__XXXXX__\\ ");
      $display("                /   XXX   \\ ");
      $display("                     V ");
      $display("                TEST  FAILED          ");
      $display("**************************************************");
    end//else_end

  endfunction:report

endclass:cxl_env
