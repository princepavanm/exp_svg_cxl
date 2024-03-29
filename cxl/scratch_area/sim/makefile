#TEST_NAME=axi_to_comp_test
#TEST_NAME=req_to_axi_traffic_test
REQ_TO_AXI_TRAFFIC_TEST= req_to_axi_traffic_test
RESET_TEST = reset_test
A2C_TEST = axi_to_comp_test
CXL_MCTP_FD = cxlio_FD_test
CXL_MEM = cxl_mem_rand_test
CXL_MEM_F2A = cxl_f2a_rand_test

MODULE_PATH=../../../cxl

SEED=10
DUMP_OPTS=DUMP_ON

DUT_DIR=$(MODULE_PATH)/project_area/design/rtl

DUT_FILE=$(DUT_DIR)/pcie_axi_master.v
CXL_MEM_FILE=$(DUT_DIR)/cxl_mem.sv

TB_DIR=$(MODULE_PATH)/project_area/verif/tb
AGENT_DIR=$(MODULE_PATH)/project_area/verif/agents
SEQ_DIR=$(MODULE_PATH)/project_area/verif/seqs
TEST_DIR=$(MODULE_PATH)/project_area/verif/tests
REG_DIR=$(MODULE_PATH)/project_area/verif/reg

TOP_FILE=$(TB_DIR)/top.sv

LOG_DIR=$(MODULE_PATH)/scratch_area/log
SIM_DIR=$(MODULE_PATH)/scratch_area/sim

INC_DIR=+incdir+$(DUT_DIR) +incdir+$(AGENT_DIR) +incdir+$(AGENT_DIR)/req_pcie_agent +incdir+$(AGENT_DIR)/comp_pcie_agent +incdir+$(AGENT_DIR)/reset_pcie_agent +incdir+$(AGENT_DIR)/cxl_pcie_agent +incdir+$(AGENT_DIR)/cxl_mem_a2f_agent+incdir+$(AGENT_DIR)/cxl_mem_f2a_agent  +incdir+$(AGENT_DIR)/output_pcie_agent +incdir+$(AGENT_DIR)/cxlio_mctp +incdir+$(TEST_DIR) +incdir+$(SEQ_DIR) +incdir+$(TB_DIR) +incdir+$(LOG_DIR) +incdir+$(SIM_DIR)

help:
	@echo =============================================================================================================
	@echo "======================================== COMMANDS==========================================================" 
	@echo "! comp           =>  Create library and compile the code.                                                 !"
	@echo "! vsim           =>  run the simulation.                                                                  !"
	@echo "! run_reset_test =>  compile & run the simulation for RESET TEST.                                         !"
	@echo "! run_r2a_test   =>  compile & run the simulation for REQ_TO_AXI_TRAFFIC_TEST.                            !"
	@echo "! run_a2c_test   =>  compile & run the simulation for AXI_TO_COMP_TEST                                    !"
	@echo "! run_sanity     =>  To be used to run the sanity test cases                                              !"
	@echo "! run_regression =>  Python script will be used to run the regression, make sure test_list.txt is updated !"
	@echo "! run_cxliomctpFD_test => compile and run cxl mctp test                                                   !"
	@echo ====================================================================================================================

comp:
	vlog -coveropt 3 +cover -L $(QUESTA_HOME)/uvm-1.2 +define+$(DUMP_OPTS) $(INC_DIR) $(DUT_FILE) $(TOP_FILE)

comp_cxl:
	vlog -coveropt 3 +cover -L $(QUESTA_HOME)/uvm-1.2 +define+CXL_MEM +define+$(DUMP_OPTS) $(INC_DIR) $(CXL_MEM_FILE) $(TOP_FILE)

vsim:
	rm -rf $(LOG_DIR)/$(TEST_NAME)_$(SEED)
	rm -rf $(TEST_NAME)_$(SEED).ucdb
	mkdir $(LOG_DIR)/$(TEST_NAME)_$(SEED)
	vsim -c -debugDB  -sv_seed $(SEED) -cvgperinstance -voptargs=+acc -coverage -voptargs="+cover=all"  +UVM_VERBOSITY=UVM_FULL +UVM_TESTNAME=$(TEST_NAME) -l $(LOG_DIR)/$(TEST_NAME)_$(SEED)/$(TEST_NAME)_$(SEED).log -do "coverage save -onexit $(LOG_DIR)/$(TEST_NAME)_$(SEED)/$(TEST_NAME)_$(SEED).ucdb;" work.top

run:	comp vsim
#-cvgperinstance -voptargs=+acc -coverage -voptargs="+cover=none"-assertdebug -voptargs="+ASSERTION_ON"

run_reset_test: comp
	rm -rf $(LOG_DIR)/$(RESET_TEST)_$(SEED)
	rm -rf $(RESET_TEST)_$(SEED).ucdb
	mkdir $(LOG_DIR)/$(RESET_TEST)_$(SEED)
	vsim -c -debugDB  -sv_seed $(SEED) -cvgperinstance -voptargs=+acc -coverage -voptargs="+cover=all"  +UVM_VERBOSITY=UVM_FULL +UVM_TESTNAME=$(RESET_TEST) -l $(LOG_DIR)/$(RESET_TEST)_$(SEED)/$(RESET_TEST)_$(SEED).log -do "coverage save -onexit $(LOG_DIR)/$(RESET_TEST)_$(SEED)/$(RESET_TEST)_$(SEED).ucdb; run -all;exit" work.top

run_r2a_test: comp
	rm -rf $(LOG_DIR)/$(REQ_TO_AXI_TRAFFIC_TEST)_$(SEED)
	rm -rf $(REQ_TO_AXI_TRAFFIC_TEST)_$(SEED).ucdb
	mkdir $(LOG_DIR)/$(REQ_TO_AXI_TRAFFIC_TEST)_$(SEED)
	vsim -c -debugDB  -sv_seed $(SEED) -cvgperinstance -voptargs=+acc -coverage -voptargs="+cover=all"  +UVM_VERBOSITY=UVM_FULL +UVM_TESTNAME=$(REQ_TO_AXI_TRAFFIC_TEST) -l $(LOG_DIR)/$(REQ_TO_AXI_TRAFFIC_TEST)_$(SEED)/$(REQ_TO_AXI_TRAFFIC_TEST)_$(SEED).log -do "coverage save -onexit $(LOG_DIR)/$(REQ_TO_AXI_TRAFFIC_TEST)_$(SEED)/$(REQ_TO_AXI_TRAFFIC_TEST)_$(SEED).ucdb;  run -all;exit" work.top

run_a2c_test: comp
	rm -rf $(LOG_DIR)/$(A2C_TEST)_$(SEED)
	rm -rf $(A2C_TEST)_$(SEED).ucdb
	mkdir $(LOG_DIR)/$(A2C_TEST)_$(SEED)
	vsim -c -debugDB  -sv_seed $(SEED) -cvgperinstance -voptargs=+acc -coverage -voptargs="+cover=all"  +UVM_VERBOSITY=UVM_FULL +UVM_TESTNAME=$(A2C_TEST) -l $(LOG_DIR)/$(A2C_TEST)_$(SEED)/$(A2C_TEST)_$(SEED).log -do "coverage save -onexit $(LOG_DIR)/$(A2C_TEST)_$(SEED)/$(A2C_TEST)_$(SEED).ucdb; run -all;exit" work.top

run_cxliomctpFD_test: comp
	rm -rf $(LOG_DIR)/$(CXL_MCTP_FD)_$(SEED)
	rm -rf $(CXL_MCTP_FD)_$(SEED).ucdb
	mkdir $(LOG_DIR)/$(CXL_MCTP_FD)_$(SEED)
	vsim -c -debugDB  -sv_seed $(SEED) -cvgperinstance -voptargs=+acc -coverage -voptargs="+cover=all"  +UVM_VERBOSITY=UVM_MEDIUM +UVM_TESTNAME=$(CXL_MCTP_FD) -l $(LOG_DIR)/$(CXL_MCTP_FD)_$(SEED)/$(CXL_MCTP_FD)_$(SEED).log -do "coverage save -onexit $(LOG_DIR)/$(CXL_MCTP_FD)_$(SEED)/$(CXL_MCTP_FD)_$(SEED).ucdb;  run -all;exit" work.top

run_cxlmem_test: comp_cxl
	rm -rf $(LOG_DIR)/$(CXL_MEM)_$(SEED)
	rm -rf $(CXL_MEM)_$(SEED).ucdb
	mkdir $(LOG_DIR)/$(CXL_MEM)_$(SEED)
	vsim -c -debugDB  -sv_seed $(SEED) -cvgperinstance -voptargs=+acc -coverage -voptargs="+cover=all"  +UVM_VERBOSITY=UVM_MEDIUM +UVM_TESTNAME=$(CXL_MEM) -l $(LOG_DIR)/$(CXL_MEM)_$(SEED)/$(CXL_MEM)_$(SEED).log -do "coverage save -onexit $(LOG_DIR)/$(CXL_MEM)_$(SEED)/$(CXL_MEM)_$(SEED).ucdb;  run -all;exit" work.top

run_cxlf2a_test: comp_cxl
	rm -rf $(LOG_DIR)/$(CXL_MEM_F2A)_$(SEED)
	rm -rf $(CXL_MEM_F2A)_$(SEED).ucdb
	mkdir $(LOG_DIR)/$(CXL_MEM_F2A)_$(SEED)
	vsim -c -debugDB  -sv_seed $(SEED) -cvgperinstance -voptargs=+acc -coverage -voptargs="+cover=all"  +UVM_VERBOSITY=UVM_MEDIUM +UVM_TESTNAME=$(CXL_MEM_F2A) -l $(LOG_DIR)/$(CXL_MEM_F2A)_$(SEED)/$(CXL_MEM_F2A)_$(SEED).log -do "coverage save -onexit $(LOG_DIR)/$(CXL_MEM_F2A)_$(SEED)/$(CXL_MEM_F2A)_$(SEED).ucdb;  run -all;exit" work.top

run_sanity: run_reset_test run_r2a_test  run_a2c_test


run_regression:
	python regression.py
	python log_parser.py
