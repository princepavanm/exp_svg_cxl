`timescale 1ns/1ns;
  `include "uvm_macros.svh"
  `include "pass_cxl_agent_intf.sv"
  import uvm_pkg::*;

  //include test library
  include "cxl_list.svh";

module top;

//Rst and clock declarations
  reg tl_clk, tl_reset_n;
  reg dl_clk, dl_reset_n;
  reg ph_clk, ph_reset_n;
  reg arb_clk, arb_reset_n;
  reg pass_clk, pass_reset_n;

//Interface instantation
  tl_intf tl_pif(tl_clk, tl_reset_n);
  dl_intf dl_pif(dl_clk, dl_reset_n);
  ph_intf ph_pif(ph_clk, ph_reset_n);
  arb_intf arb_pif(arb_clk, arb_reset_n);
  pass_intf pass_pif(pass_clk, pass_reset_n);

//Rst and Clock generation
  initial begin

    tl_clk = 0;
    dl_clk = 0;
    ph_clk = 0;
    arb_clk = 0;
    pass_clk = 0;

    tl_reset_n = 1;
    #7.0;	tl_reset_n = 0;
    dl_reset_n = 1;
    #7.0;	dl_reset_n = 0;
    ph_reset_n = 1;
    #7.0;	ph_reset_n = 0;
    arb_reset_n = 1;
    #7.0;	arb_reset_n = 0;
    pass_reset_n = 1;
    #7.0;	pass_reset_n = 0;

    #500us;
    $finish();
  end

  always #(10/2) tl_clk = ~tl_clk;
  always #(10/2) dl_clk = ~dl_clk;
  always #(10/2) ph_clk = ~ph_clk;
  always #(10/2) arb_clk = ~arb_clk;
  always #(10/2) pass_clk = ~pass_clk;

//DUT Instantiation
//  cxl dut();

//Register interfaces to config_db
  initial begin

    uvm_config_db#(virtual tl_intf)::set(null,"*","tl_pif",tl_pif);
    uvm_config_db#(virtual dl_intf)::set(null,"*","dl_pif",dl_pif);
    uvm_config_db#(virtual ph_intf)::set(null,"*","ph_pif",ph_pif);
    uvm_config_db#(virtual arb_intf)::set(null,"*","arb_pif",arb_pif);
    uvm_config_db#(virtual pass_intf)::set(null,"*","pass_pif",pass_pif);

  end

//Run test
  initial begin
    run_test();
  end

endmodule:top
