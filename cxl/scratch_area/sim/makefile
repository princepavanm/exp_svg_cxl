#TEST_NAME=cxl_base_test
TEST_NAME=req_to_axi_traffic_test
RESET_TEST = reset_test
A2C_TEST = axi_to_comp_test
MODULE_PATH=../../../cxl

SEED=10
DUMP_OPTS=DUMP_ON

DUT_DIR=$(MODULE_PATH)/project_area/design/rtl

DUT_FILE=$(DUT_DIR)/pcie_axi_master.v

TB_DIR=$(MODULE_PATH)/project_area/verif/tb
AGENT_DIR=$(MODULE_PATH)/project_area/verif/agents
SEQ_DIR=$(MODULE_PATH)/project_area/verif/seqs
TEST_DIR=$(MODULE_PATH)/project_area/verif/tests
REG_DIR=$(MODULE_PATH)/project_area/verif/reg

TOP_FILE=$(TB_DIR)/top.sv

LOG_DIR=$(MODULE_PATH)/scratch_area/log
SIM_DIR=$(MODULE_PATH)/scratch_area/sim

INC_DIR=+incdir+$(DUT_DIR) +incdir+$(AGENT_DIR) +incdir+$(AGENT_DIR)/req_pcie_agent +incdir+$(AGENT_DIR)/comp_pcie_agent +incdir+$(AGENT_DIR)/reset_pcie_agent +incdir+$(AGENT_DIR)/cxl_pcie_agent +incdir+$(AGENT_DIR)/output_pcie_agent +incdir+$(TEST_DIR) +incdir+$(SEQ_DIR) +incdir+$(TB_DIR) +incdir+$(LOG_DIR) +incdir+$(SIM_DIR)

comp:
	vlog -coveropt 3 +cover -L $(QUESTA_HOME)/uvm-1.2 +define+$(DUMP_OPTS) $(INC_DIR) $(DUT_FILE) $(TOP_FILE)

vsim:
	rm -rf $(LOG_DIR)/$(TEST_NAME)_$(SEED)
	rm -rf $(TEST_NAME)_$(SEED).ucdb
	mkdir $(LOG_DIR)/$(TEST_NAME)_$(SEED)
	vsim  -debugDB  -sv_seed $(SEED) -cvgperinstance -voptargs=+acc -coverage -voptargs="+cover=all"  +UVM_VERBOSITY=UVM_LOW +UVM_TESTNAME=$(TEST_NAME) -l $(LOG_DIR)/$(TEST_NAME)_$(SEED)/$(TEST_NAME)_$(SEED).log -do "coverage save -onexit $(LOG_DIR)/$(TEST_NAME)_$(SEED)/$(TEST_NAME)_$(SEED).ucdb;" work.top

run:	comp vsim
#-cvgperinstance -voptargs=+acc -coverage -voptargs="+cover=none"-assertdebug -voptargs="+ASSERTION_ON"

run_reset_test: comp
	rm -rf $(LOG_DIR)/$(RESET_TEST)_$(SEED)
	rm -rf $(RESET_TEST)_$(SEED).ucdb
	mkdir $(LOG_DIR)/$(RESET_TEST)_$(SEED)
	vsim  -debugDB  -sv_seed $(SEED) -cvgperinstance -voptargs=+acc -coverage -voptargs="+cover=all"  +UVM_VERBOSITY=UVM_LOW +UVM_TESTNAME=$(RESET_TEST) -l $(LOG_DIR)/$(RESET_TEST)_$(SEED)/$(RESET_TEST)_$(SEED).log -do "coverage save -onexit $(LOG_DIR)/$(RESET_TEST)_$(SEED)/$(RESET_TEST)_$(SEED).ucdb;" work.top

run_a2c_test: comp
	rm -rf $(LOG_DIR)/$(A2C_TEST)_$(SEED)
	rm -rf $(A2C_TEST)_$(SEED).ucdb
	mkdir $(LOG_DIR)/$(A2C_TEST)_$(SEED)
	vsim  -debugDB  -sv_seed $(SEED) -cvgperinstance -voptargs=+acc -coverage -voptargs="+cover=all"  +UVM_VERBOSITY=UVM_LOW +UVM_TESTNAME=$(A2C_TEST) -l $(LOG_DIR)/$(A2C_TEST)_$(SEED)/$(A2C_TEST)_$(SEED).log -do "coverage save -onexit $(LOG_DIR)/$(A2C_TEST)_$(SEED)/$(A2C_TEST)_$(SEED).ucdb;" work.top
