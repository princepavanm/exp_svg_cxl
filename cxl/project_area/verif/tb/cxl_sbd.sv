class cxl_sbd extends uvm_scoreboard;

  `uvm_analysis_imp_decl(_tl)
  `uvm_analysis_imp_decl(_dl)
  `uvm_analysis_imp_decl(_ph)
  `uvm_analysis_imp_decl(_arb)
  `uvm_analysis_imp_decl(_pass)

  uvm_analysis_imp_tl#(tl_tx, cxl_sbd) imp_tl_h;
  uvm_analysis_imp_dl#(dl_tx, cxl_sbd) imp_dl_h;
  uvm_analysis_imp_ph#(ph_tx, cxl_sbd) imp_ph_h;
  uvm_analysis_imp_arb#(arb_tx, cxl_sbd) imp_arb_h;
  uvm_analysis_imp_pass#(pass_tx, cxl_sbd) imp_pass_h;

  function new(string name="cxl_sbd", uvm_component parent=null);
    super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    imp_tl_h = new("imp_tl_h", this);
    imp_dl_h = new("imp_dl_h", this);
    imp_ph_h = new("imp_ph_h", this);
    imp_arb_h = new("imp_arb_h", this);
    imp_pass_h = new("imp_pass_h", this);

  endfunction:build_phase

  function void write_tl(tl_tx tx);

    `uvm_info("SBD", "Gettting tx from tl Interface", UVM_LOW)

  endfunction

  function void write_dl(dl_tx tx);

    `uvm_info("SBD", "Gettting tx from dl Interface", UVM_LOW)

  endfunction

  function void write_ph(ph_tx tx);

    `uvm_info("SBD", "Gettting tx from ph Interface", UVM_LOW)

  endfunction

  function void write_arb(arb_tx tx);

    `uvm_info("SBD", "Gettting tx from arb Interface", UVM_LOW)

  endfunction

  function void write_pass(pass_tx tx);

    `uvm_info("SBD", "Gettting tx from pass Interface", UVM_LOW)

  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("SBD","Comparition Logic : Run_phase", UVM_LOW)

  endtask:run_phase

  virtual function check_phase(uvm_phase phase);
    super.check_phase(phase);

    `uvm_info("SBD","Comparition Logic : Check_phase", UVM_LOW)

  endfunction:check_phase

  virtual function report_phase(uvm_phase phase);
    super.report_phase(phase);

    `uvm_info("SBD","Passed and Failed ", UVM_LOW)

  endfunction:report_phase

endclass:cxl_sbd
