import os
import subprocess


TEST_LIST = open("test_list.txt","r")
test = TEST_LIST.readlines()

MODULE_PATH = "../../../cxl"
SEED        = 10
DUMP_OPTS   = "DUMP_ON"
DUT_DIR     = MODULE_PATH+"/project_area/design/rtl"
DUT_FILE    = DUT_DIR+"/pcie_axi_master.v"
TB_DIR      = MODULE_PATH+"/project_area/verif/tb"
AGENT_DIR   = MODULE_PATH+"/project_area/verif/agents"
SEQ_DIR     = MODULE_PATH+"/project_area/verif/seqs"
TEST_DIR    = MODULE_PATH+"/project_area/verif/tests"
REG_DIR     = MODULE_PATH+"/project_area/verif/reg"

TOP_FILE= TB_DIR+"/top.sv"

LOG_DIR= MODULE_PATH+"/scratch_area/log"
SIM_DIR= MODULE_PATH+"/scratch_area/sim"

INC_DIR="+incdir+"+DUT_DIR+"+incdir+"+AGENT_DIR+"+incdir+"+AGENT_DIR+"/req_pcie_agent"+"+incdir+"+AGENT_DIR+"/comp_pcie_agent"+"+incdir+"+AGENT_DIR+"/reset_pcie_agent"+"+incdir+"+AGENT_DIR+"/cxl_pcie_agent"+"+incdir+"+AGENT_DIR+"/output_pcie_agent"+"+incdir+"+TEST_DIR+"+incdir+"+SEQ_DIR+"+incdir+"+TB_DIR+"+incdir+"+LOG_DIR+"+incdir+"+SIM_DIR



def cxl_comp():
    os.system("vlog -coveropt 3 +cover -L +define+%s %s %s %s"%(DUMP_OPTS,INC_DIR,DUT_FILE,TOP_FILE))


def cxl_regression():
    i = 1
    print("------------------------------------------------------------------------------")
    print("|                                                                            |")
    print("|                   RUNNING CXL REGRESSION                                   |")
    print("|                                                                            |")
    print("------------------------------------------------------------------------------")

    print(">>>>>>>>>>>>>>>>>>>>>CREATING REGRESSION DIRECTORY")
    os.system("rm -rf ../regression_dir")
    os.system("mkdir ../regression_dir")
    os.system("mkdir ../regression_dir/waves")
    os.system("mkdir ../regression_dir/logs")


    for names in test:
        test_name = names.strip('\n')
        cxl_comp()
        os.system("vsim -vopt -cvgperinstance -coverage -assertdebug -c -do  \" log -r /* ;coverage save -onexit -cvg -directive -codeAll mem_cov%d;run -all; exit\"   -wlf ../regression_dir/waves/%s.wlf -l ../regression_dir/logs/%s.log  -sv_seed random work.top +UVM_TESTNAME=%s"%(i,test_name,test_name,test_name))
        os.system("vcover report -html -source -details -assert -directive -cvg -code bcefst mem_cov%d"%(i))
        i=i+1

    
cxl_regression()
