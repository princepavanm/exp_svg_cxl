####################################
#         MOHAMMED KHADEER         #
####################################

import csv  # to work with CSV file
import os   # It is used to creating directories
import subprocess

# The Idea of this program is to converting the user information into hash of array
# To save this hash of array as disnary as an array I am initialing this two array
intf_info_hoa = {}  
intf_arr = []
agent_info_hoa = {}  
agent_arr = []

pwd = (f"pwd")
dir_path = subprocess.check_output(pwd, shell=True, text=True)
dir_path = dir_path.rstrip("\n")
print(f"********* {dir_path} *************")
# now I am going to open CSV file
#with open("cygdrive/g/auto_test_bench/DMA_TB_PARAMS.xlsx", "r") as f:
print("************************* Interface Info ************************************") 
with open(f"{dir_path}/Test_Bench_Info.csv", "r") as f:
    reader = csv.reader(f)
    for row in reader:
        for i, word in enumerate(row):
            if word == "DUT_NAME":
                dut_name = row[i + 1]
                dut_name_lc = dut_name.lower()
                print("DUT_name : " + dut_name)
            elif word == "NUM_INTF":
                num_intf = row[i + 1]
                print("NUM_INTF : " + num_intf)
            elif word == "INTF":
                intf_name = row[i + 1]
                intf_name_lc = intf_name.lower()
                intf_arr.append(intf_name_lc)
                intf_type = row[i + 2]
                intf_freq = row[i + 3]
                intf_clk = row[i + 4]
                intf_rst = row[i + 5]
                one_intf_info = [intf_type, intf_freq, intf_clk, intf_rst]
                #print("********* Intf_INFO : " + str(one_intf_info) + " *********")
                intf_info_hoa[intf_name_lc] = one_intf_info
            elif word == "NUM_AGENT":
                num_agent = row[i + 1]
                print("NUM_AGENT : " + num_agent)
            elif word == "AGENT":
                agent_name = row[i + 1]
                agent_name_lc = agent_name.lower()
                agent_arr.append(agent_name_lc)
                agent_type = row[i + 2]
                one_agent_info = [agent_type]
                #print("********* AGENT_INFO : " + str(one_agent_info) + " *********")
                agent_info_hoa[agent_name_lc] = one_agent_info                
                
print("************************** Interface Info with Name ***************************")               
for intf in intf_arr:
    print(f"******     {intf} --> {intf_info_hoa[intf]}     ******")

print("**************************** Agent Info with Name *****************************")               
for agent in agent_arr:
    print(f"******     {agent} --> {agent_info_hoa[agent]}     ******")
    
dut_name_lc = dut_name.lower()
print("********************************** DUT Name ***********************************") 
print("DUT_NAME : " + dut_name_lc)

############################################ Making Directories #######################################################

# creating the directories
os.makedirs(f"{dut_name_lc}/scratch_area", exist_ok=True)
os.makedirs(f"{dut_name_lc}/project_area", exist_ok=True)
os.makedirs(f"{dut_name_lc}/doc", exist_ok=True)

os.makedirs(f"{dut_name_lc}/project_area/design/rtl", exist_ok=True)

os.makedirs(f"{dut_name_lc}/project_area/verif/tb", exist_ok=True)
os.makedirs(f"{dut_name_lc}/project_area/verif/tests", exist_ok=True)
os.makedirs(f"{dut_name_lc}/project_area/verif/agents", exist_ok=True)
os.makedirs(f"{dut_name_lc}/project_area/verif/seqs", exist_ok=True)
os.makedirs(f"{dut_name_lc}/project_area/verif/reg", exist_ok=True)

os.makedirs(f"{dut_name_lc}/scratch_area/log", exist_ok=True)
os.makedirs(f"{dut_name_lc}/scratch_area/sim", exist_ok=True)

############################################ Creating top .sv file ####################################################

def create_top_sv_file(dut_name_lc):
    with open("top.sv", "w") as fw:
        fw.write("`timescale 1ns/1ns;\n")
        fw.write("  `include \"uvm_macros.svh\"\n")
        fw.write("  import uvm_pkg::*;\n")
        fw.write("\n")
        fw.write("  //include test library\n")
        fw.write(f"  include \"{dut_name_lc}_list.svh\";\n")
        fw.write("\n")
        fw.write("module top;\n")  
        fw.write("\n")
        fw.write("//Rst and clock declarations\n")
        for intf in intf_arr:
            one_intf_info = intf_info_hoa[intf]
            size = len(one_intf_info)
            if one_intf_info[0] == 'M':
                fw.write("  reg {}, {};\n".format(one_intf_info[2], one_intf_info[3]))
            elif one_intf_info[0] == 'S':
                fw.write("  reg {};\n".format(one_intf_info[2]))
        fw.write("\n")
        fw.write("//Interface instantation\n")
        for intf in intf_arr:
            one_intf_info = intf_info_hoa[intf]
            size = len(one_intf_info)
            intf_name = intf + "_intf"
            intf_pif = intf + "_pif"
            if one_intf_info[0] == 'M':
                fw.write("  {} {}({}, {});\n".format(intf_name, intf_pif, one_intf_info[2], one_intf_info[3]))
            elif one_intf_info[0] == 'S':
                fw.write("  {} {}({});\n".format(intf_name, intf_pif, one_intf_info[2]))
        fw.write("\n")
        fw.write("//Rst and Clock generation\n")
        fw.write("  initial begin\n")
        fw.write("\n")
        for intf in intf_arr:
            one_intf_info = intf_info_hoa[intf]
            size = len(one_intf_info)
            fw.write("    {} = 0;\n".format(one_intf_info[2])) 
        fw.write("\n")         
        for intf in intf_arr:
            one_intf_info = intf_info_hoa[intf]
            size = len(one_intf_info)
            delay = (int(one_intf_info[1])/2)+2
            if one_intf_info[3] != "":
                fw.write("    {} = 1;\n".format(one_intf_info[3]))
                fw.write("    #{};\t{} = 0;\n".format(delay,one_intf_info[3]))
        fw.write("\n")
        fw.write("    #500us;\n")
        fw.write("    $finish();\n")
        fw.write("  end\n")
        fw.write("\n")
        for intf in intf_arr:
            one_intf_info = intf_info_hoa[intf]
            size = len(one_intf_info)
            fw.write("  always #({}/2) {} = ~{};\n".format(one_intf_info[1], one_intf_info[2], one_intf_info[2]))   
        fw.write("\n")
        fw.write("//DUT Instantiation\n")
        fw.write("//  {} dut();\n".format(dut_name_lc))
        fw.write("\n")
        fw.write("//Register interfaces to config_db\n")
        fw.write("  initial begin\n")
        fw.write("\n")
        for intf in intf_arr:
            one_intf_info = intf_info_hoa[intf]
            size = len(one_intf_info)
            intf_name = intf + "_intf"
            intf_pif = intf + "_pif"
            intf_vif = intf + "_pif"
            fw.write("    uvm_config_db#(virtual {})::set(null,\"*\",\"{}\",{});\n".format(intf_name, intf_pif, intf_vif))
        fw.write("\n")        
        fw.write("  end\n")
        fw.write("\n")
        fw.write("//Run test\n")
        fw.write("  initial begin\n")
        fw.write("    run_test();\n")
        fw.write("  end\n")
        fw.write("\n")
        fw.write("endmodule:top\n")
    print(f"******     top.sv file implementation is done     ******")

############################################ Creating env .sv file  ###################################################

def create_env_sv_file(dut_name_lc):
    with open(f"env.sv", "w") as fw:
        fw.write(f"class {dut_name_lc}_env extends uvm_env;\n")
        fw.write(f"  `uvm_component_utils({dut_name_lc}_env)\n")
        fw.write("\n")        
        for agent in agent_arr:
            one_agent_info = agent_info_hoa[agent]
            size = len(one_agent_info)
            if one_agent_info[0] == "Active":
                fw.write(f"  {agent}\t{agent}_h;\n")
        fw.write("\n")
        fw.write(f"  {dut_name_lc}_virtual_sqr \t v_sqr_h;\n")
        fw.write("\n")
        fw.write("  function new(string name=\"{}_env\", uvm_component parent=null);\n".format(dut_name_lc))
        fw.write("    super.new(name, parent);\n")
        fw.write("  endfunction:new\n")
        fw.write("\n")
        fw.write("  function void build_phase(uvm_phase phase);\n")
        fw.write("    super.build_phase(phase);\n")
        fw.write(f"    v_sqr_h = {dut_name_lc}_virtual_sqr::type_id::create(\"v_sqr_h\", this);\n")
        fw.write("\n")
        for agent in agent_arr:
            one_agent_info = agent_info_hoa[agent]
            size = len(one_agent_info)
            if one_agent_info[0] == "Active":
                fw.write(f"    {agent}_h = {agent}::type_id::create(\"{agent}_h\", this);\n")
        fw.write("\n")
        fw.write("  endfunction:build_phase\n")
        fw.write("\n")
        fw.write("  function void connect_phase(uvm_phase phase);\n")
        fw.write("    super.connect_phase(phase);\n")
        for agent in agent_arr:
            one_agent_info = agent_info_hoa[agent]
            size = len(one_agent_info)
            if one_agent_info[0] == "Active":
                fw.write(f"    v_sqr_h.{agent}_sqr_h = {agent}_h.sqr_h;\n")
        fw.write("\n")        
        fw.write("  endfunction:connect_phase\n")
        fw.write("\n")
        fw.write("  function void report();\n")
        fw.write("\n")
        fw.write("    uvm_report_server reportserver=uvm_report_server::get_server();\n")
        fw.write("\n")
        fw.write("    $display(\"**************************************************\");\n")
        fw.write("    $display(\"****************** TEST Summary ******************\");\n")
        fw.write("    $display(\"**************************************************\");\n")
        fw.write("\n")
        fw.write(f"    if((reportserver.get_severity_count(UVM_FATAL)==0)&&(reportserver.get_severity_count(UVM_WARNING)==0)&&(reportserver.get_severity_count(UVM_ERROR)==0))  begin\n")
        fw.write("      $display(\"**************************************************\");\n")
        fw.write("      $display(\"****************** TEST  PASSED ******************\");\n")
        fw.write("      $display(\"**************************************************\");\n")
        fw.write("    end//if_end\n")
        fw.write("\n")
        fw.write("    else begin\n")
        fw.write("      $display(\"**************************************************\");\n")
        fw.write("      $display(\"                    \\\\ / \");\n")
        fw.write("      $display(\"                    oVo \");\n")
        fw.write("      $display(\"            \\\\___XXX___/ \");\n")
        fw.write("      $display(\"                 __XXXXX__ \");\n")
        fw.write("      $display(\"                /__XXXXX__\\\\ \");\n")
        fw.write("      $display(\"                /   XXX   \\\\ \");\n")
        fw.write("      $display(\"                     V \");\n")
        fw.write("      $display(\"                TEST  FAILED          \");\n")
        fw.write("      $display(\"**************************************************\");\n")
        fw.write("    end//else_end\n")
        fw.write("\n")
        fw.write("  endfunction:report\n")
        fw.write("\n")
        fw.write(f"endclass:{dut_name_lc}_env\n")
    print(f"******     env.sv file implementation is done     ******")

############################################ Creating virtual sequencer .sv file ######################################

def create_virtual_sqr_sv_file(dut_name_lc):
    with open(f"virtual_sqr.sv", "w") as fw:
        fw.write(f"class {dut_name_lc}_virtual_sqr extends uvm_sequencer;\n")
        fw.write(f"  `uvm_component_utils({dut_name_lc}_virtual_sqr)\n")
        fw.write("\n")
        for agent in agent_arr:
            one_agent_info = agent_info_hoa[agent]
            size = len(one_agent_info)
            if one_agent_info[0] == "Active":
                fw.write(f"  {agent}_sqr \t {agent}_sqr_h;\n")
        fw.write("\n")
        fw.write("  function new(string name=\"{}_virtual_sqr\", uvm_component parent=null);\n".format(dut_name_lc))
        fw.write("    super.new(name, parent);\n")
        fw.write("  endfunction:new\n")
        fw.write("\n")
        fw.write("  function void build_phase(uvm_phase phase);\n")
        fw.write("\n")
        fw.write("    super.build_phase(phase);\n")
        fw.write("\n")
        for agent in agent_arr:
            one_agent_info = agent_info_hoa[agent]
            size = len(one_agent_info)
            if one_agent_info[0] == "Active":
                fw.write(f"    {agent}_sqr_h = {agent}_sqr::type_id::create(\"{agent}_sqr_h\", this);\n")
        fw.write("\n")
        fw.write("  endfunction:build_phase\n")
        fw.write("\n")
        fw.write(f"endclass:{dut_name_lc}_virtual_sqr\n")
    print(f"******     virtual_sqr.sv file implementation is done     ******")

############################################ Creating Scoreboard .sv file #############################################

def create_sbd_sv_file(dut_name_lc, intf_arr, intf_info_hoa):
    with open(dut_name_lc + "_sbd.sv", "w") as fw:    
        fw.write(f"class {dut_name_lc}_sbd extends uvm_scoreboard;\n")
        fw.write("\n")
        for intf in intf_arr:
            one_intf_info = intf_info_hoa[intf]
            fw.write(f"  `uvm_analysis_imp_decl(_{intf})\n")
        fw.write("\n")
        for intf in intf_arr:
            fw.write(f"  uvm_analysis_imp_{intf}#({intf}_tx, {dut_name_lc}_sbd) imp_{intf}_h;\n")
        fw.write("\n")
        fw.write("  function new(string name=\"{}_sbd\", uvm_component parent=null);\n".format(dut_name_lc))
        fw.write("    super.new(name, parent);\n")
        fw.write("  endfunction:new\n")
        fw.write("\n")
        fw.write("  function void build_phase(uvm_phase phase);\n")
        fw.write("    super.build_phase(phase);\n")
        fw.write("\n")
        for intf in intf_arr:
            fw.write(f"    imp_{intf}_h = new(\"imp_{intf}_h\", this);\n")
        fw.write("\n")
        fw.write("  endfunction:build_phase\n")
        fw.write("\n")        
        for intf in intf_arr:
            fw.write(f"  function void write_{intf}({intf}_tx tx);\n")
            fw.write("\n")
            fw.write("    `uvm_info(\"SBD\", \"Gettting tx from " + intf + " Interface\", UVM_LOW)\n")
            fw.write("\n")
            fw.write("  endfunction\n")
            fw.write("\n")
        fw.write("  virtual task run_phase(uvm_phase phase);\n")
        fw.write("    super.run_phase(phase);\n")
        fw.write("\n")
        fw.write("    `uvm_info(\"SBD\",\"Comparition Logic : Run_phase\", UVM_LOW)\n")
        fw.write("\n")
        fw.write("  endtask:run_phase\n")
        fw.write("\n")
        fw.write("  virtual function check_phase(uvm_phase phase);\n")
        fw.write("    super.check_phase(phase);\n")
        fw.write("\n")
        fw.write("    `uvm_info(\"SBD\",\"Comparition Logic : Check_phase\", UVM_LOW)\n")
        fw.write("\n")
        fw.write("  endfunction:check_phase\n")
        fw.write("\n")
        fw.write("  virtual function report_phase(uvm_phase phase);\n")
        fw.write("    super.report_phase(phase);\n")
        fw.write("\n")
        fw.write("    `uvm_info(\"SBD\",\"Passed and Failed \", UVM_LOW)\n")
        fw.write("\n")
        fw.write("  endfunction:report_phase\n")
        fw.write("\n")
        fw.write(f"endclass:{dut_name_lc}_sbd\n")
    print(f"******     {dut_name_lc}_sbd.sv file implementation is done     ******")

############################################ Creating Filelist .svh (Pakage file) ######################################

def create_filelist_svh_file():
    #create SIM folder files
    with open (f"{dut_name_lc}_list.svh", "w") as fw:
        fw.write("//List of Include Files\n")
        fw.write("\n")
        for agent in agent_arr:
            one_agent_info = agent_info_hoa[agent]
            if one_agent_info[0] == "Active":
                fw.write(f"  `include \"{agent}_intf.sv\"\n")
        fw.write("\n")
        for agent in agent_arr:
            one_agent_info = agent_info_hoa[agent]
            size = len(one_agent_info)
            if one_agent_info[0] == "Active":
                fw.write(f"  `include \"{agent}_tx.sv\"\n")            
                fw.write(f"  `include \"{agent}_drv.sv\"\n")
                fw.write(f"  `include \"{agent}_sqr.sv\"\n")
                fw.write(f"  `include \"{agent}_cov.sv\"\n")
            fw.write(f"  `include \"{agent}_mon.sv\"\n")
            fw.write(f"  `include \"{agent}.sv\"\n")
            fw.write("\n")
        fw.write(f"  `include \"virtual_sqr.sv\"\n")
        fw.write("\n")
        fw.write("// Sequence List\n")
        fw.write("  `include \"../seqs/sequence_list.sv\"\n")
        fw.write(f"  `include \"env.sv\"\n")
        fw.write("\n")
        fw.write("// Test List\n")
        fw.write("  `include \"../tests/test_list.sv\"\n")
    print(f"******     {dut_name_lc}_list.svh file implementation is done     ******")

########################### Changing the directories for creation of top directories files ############################

os.chdir(f"{dir_path}/{dut_name_lc}/project_area/verif/tb")

def create_file(file_name):
    with open(file_name, "w") as f:
        pass
        
create_top_sv_file(dut_name_lc)
create_env_sv_file(dut_name_lc)
create_virtual_sqr_sv_file(dut_name_lc)
create_sbd_sv_file(dut_name_lc, intf_arr, intf_info_hoa)
create_filelist_svh_file()

############################################ Creating sequence_list .sv file ##########################################

def create_seq_list_file(dut_name_lc):
    #create SIM folder files
    with open (f"sequence_list.sv", "w") as fw:
        fw.write("//List of Include Files\n")
        fw.write("\n")
        fw.write(f"  `include \"{dut_name_lc}_base_seq.sv\"\n")
        fw.write("\n")
    print(f"******     sequence_list.sv file implementation is done     ******")

############################################ Creating Base sequence .sv file ##########################################

def create_base_seq_sv_file(dut_name_lc):
    with open(dut_name_lc + "_base_seq.sv", "w") as fw:
        fw.write(f"class {dut_name_lc}_base_seq extends uvm_sequence;\n")
        fw.write("\n")
        fw.write(f"  `uvm_object_utils({dut_name_lc}_base_seq)\n")
        fw.write("\n")
        fw.write(f"  function new(string name=\"{dut_name_lc}_base_seq\");\n")
        fw.write("    super.new(name);\n")
        fw.write("  endfunction\n")
        fw.write("\n")
        fw.write("  virtual task pre_body();\n")
        fw.write("    `ifdef UVM_POST_VERSION_1_1\n")
        fw.write("      var uvm_phase starting_phase = get_starting_phase();\n")
        fw.write("    `endif\n")
        fw.write("  \n")
        fw.write("    if (starting_phase != null)  begin\n")
        fw.write("      starting_phase.raise_objection(this);\n")
        fw.write("    end\n")
        fw.write("  endtask:pre_body\n")
        fw.write("\n")
        fw.write("  virtual task body();\n\n")
        fw.write("   // Functionality of sequence are coded here\n\n")
        fw.write("  endtask:body\n")
        fw.write("\n")
        fw.write("  virtual task post_body();\n")
        fw.write("    `ifdef UVM_POST_VERSION_1_1\n")
        fw.write("      var uvm_phase starting_phase = get_starting_phase();\n")
        fw.write("    `endif\n")
        fw.write("  \n")
        fw.write("    if (starting_phase != null)  begin\n")
        fw.write("      starting_phase.drop_objection(this);\n")
        fw.write("    end\n")
        fw.write("  endtask:post_body\n")
        fw.write("  \n")
        fw.write(f"endclass:{dut_name_lc}_base_seq\n")
    print(f"******     {dut_name_lc}_base_seq.sv file implementation is done     ******")

########################## Changing the directories for creation of seqs directories files ############################
 
os.chdir(f"{dir_path}/{dut_name_lc}/project_area/verif/seqs")

def create_file(file_name):
    with open(file_name, "w") as f:
        pass

create_seq_list_file(dut_name_lc)
create_base_seq_sv_file(dut_name_lc)        

############################################ Creating Test_list .sv file ###############################################

def create_test_list_file(dut_name_lc):
    #create SIM folder files
    with open (f"test_list.sv", "w") as fw:
        fw.write("//List of Include Files\n")
        fw.write("\n")
        fw.write(f"  `include \"{dut_name_lc}_base_test.sv\"\n")
        fw.write("\n")
    print(f"******     test_list.sv file implementation is done     ******")

############################################ Creating Base test .sv file ###############################################

def create_base_test_sv_file(dut_name_lc):
    with open(dut_name_lc + "_base_test.sv", "w") as fw:
        fw.write(f"class {dut_name_lc}_base_test extends uvm_test;\n\n")
        fw.write(f"  {dut_name_lc}_env      env_h; \n\n")
        fw.write(f"  `uvm_component_utils({dut_name_lc}_base_test)\n")
        fw.write("\n")
        fw.write("  function new(string name=\"{}_base_test\", uvm_component parent=null);\n".format(dut_name_lc))
        fw.write("    super.new(name, parent);\n")
        fw.write("  endfunction:new\n")
        fw.write("\n")
        fw.write("  function void build_phase(uvm_phase phase);\n")
        fw.write("    super.build_phase(phase);\n")
        fw.write("\n")
        fw.write(f"    env_h = {dut_name_lc}_env::type_id::create(\"env_h\", this);\n")
        fw.write("\n")
        fw.write("  endfunction:build_phase\n")
        fw.write("\n")  
        fw.write("  function void end_of_elaboration_phase(uvm_phase phase);\n")
        fw.write("    uvm_factory factory = uvm_factory::get();\n")
        fw.write("    uvm_top.print_topology();\n")
        fw.write("    factory.print();\n")
        fw.write("  endfunction:end_of_elaboration_phase\n")
        fw.write("\n")
        fw.write(f"endclass:{dut_name_lc}_base_test\n")
    print(f"******     {dut_name_lc}_base_test.sv file implementation is done     ******")

########################## Changing the directories for creation of tests directories files ############################

os.chdir(f"{dir_path}/{dut_name_lc}/project_area/verif/tests")

def create_file(file_name):
    with open(file_name, "w") as f:
        pass

create_test_list_file(dut_name_lc)
create_base_test_sv_file(dut_name_lc)

############################################# Creating Agent .sv files ################################################

def create_agent_sv_file(agent,option):
    with open(agent+".sv", "w") as fw:
        tx_name = agent.split('_')[0]
        fw.write(f"class {agent} extends uvm_agent;\n")
        fw.write("\n")
        fw.write(f"  {agent}_mon      mon_h; \n")
        fw.write("\n")
        fw.write(f"  virtual {tx_name}_intf     {tx_name}_pif;\n")
        fw.write("\n")
        if option == "Active":
            fw.write(f"  {agent}_drv      drv_h; \n")
            fw.write(f"  {agent}_sqr      sqr_h; \n")
            fw.write(f"  {agent}_cov      cov_h; \n")
        fw.write("\n")
        fw.write(f"  `uvm_component_utils({agent})\n")
        fw.write("\n")
        fw.write("  function new(string name=\"{}\", uvm_component parent=null);\n".format(agent))
        fw.write("    super.new(name, parent);\n")
        fw.write("  endfunction:new\n")
        fw.write("\n")
        fw.write("  function void build_phase(uvm_phase phase);\n")
        fw.write("    super.build_phase(phase);\n")
        fw.write("\n")
        fw.write(f"     mon_h = {agent}_mon::type_id::create(\"mon_h\", this);\n")
        if option == "Active":
            fw.write("\n")
            fw.write(f"     drv_h = {agent}_drv::type_id::create(\"drv_h\", this);\n")
            fw.write(f"     sqr_h = {agent}_sqr::type_id::create(\"sqr_h\", this);\n")
            fw.write(f"     cov_h = {agent}_cov::type_id::create(\"cov_h\", this);\n")
        fw.write("\n")
        if option == "Active":
            fw.write(f"    if(!uvm_config_db#(virtual {tx_name}_intf)::get(this,\" \",\"{tx_name}_pif\",{tx_name}_pif))\n")
            fw.write(f"      `uvm_fatal(\"AGENT\", \"***** Could not get vif *****\")\n")
            fw.write(f"    uvm_config_db#(virtual {tx_name}_intf)::set(this,\"*\",\"{tx_name}_pif\",{tx_name}_pif);\n")
        fw.write("\n")
        fw.write("  endfunction:build_phase\n")
        fw.write("\n")
        fw.write("  function void connect_phase(uvm_phase phase);\n")
        fw.write("    super.connect_phase(phase);\n")
        if option == "Active":
            fw.write("\n")
            fw.write(f"    drv_h.seq_item_port.connect(sqr_h.seq_item_export);\n")
        fw.write("\n")        
        fw.write("  endfunction:connect_phase\n")        
        fw.write("\n")
        fw.write(f"endclass:{agent}\n")
    print(f"******     {agent}.sv files implementation is done     ******")

############################################ Creating Monitor .sv files ###############################################

def create_mon_sv_file(agent,option):
    with open(f"{agent}_mon.sv", "w") as fw:
        tx_name = agent.split('_')[0]
        fw.write(f"class {agent}_mon extends uvm_monitor;\n")
        fw.write("\n")
        fw.write(f"  `uvm_component_utils({agent}_mon)\n")
        fw.write("\n")
        fw.write(f"  {tx_name}_tx   tx_h;\n")
        fw.write("\n")
        if option =="Active":
            fw.write(f"  uvm_analysis_port #({tx_name}_tx)       {agent}_mon_port;\n")
        fw.write("\n")
        fw.write("  function new(string name=\"{}_mon\", uvm_component parent=null);\n".format(agent))
        fw.write("    super.new(name, parent);\n")
        fw.write("  endfunction:new\n")
        fw.write("\n")
        fw.write("  function void build_phase(uvm_phase phase);\n")
        fw.write("    super.build_phase(phase);\n")
        fw.write("\n")
        if option =="Active":        
            fw.write(f"    {agent}_mon_port = new(\"{agent}_mon_port\", this);\n")
        fw.write(f"    tx_h = {tx_name}_tx::type_id::create(\"tx_h\", this);\n")
        fw.write("\n")
        fw.write("  endfunction:build_phase\n")
        fw.write("\n")
        fw.write("  virtual task run_phase(uvm_phase phase);\n")
        fw.write("    super.run_phase(phase);\n")
        fw.write("\n")
        fw.write(f"    `uvm_info(\"{agent}_mon\",\"Monitor Run Phase\", UVM_LOW)\n")
        fw.write("\n")
        fw.write("  endtask:run_phase\n")
        fw.write("\n")        
        fw.write(f"endclass:{agent}_mon\n")
    print(f"******     {agent}_mon.sv files implementation is done     ******")

############################################ Creating Coverage .sv files ##############################################

def create_cov_sv_file(agent):
    with open(f"{agent}_cov.sv", "w") as fw:
        tx_name = agent.split('_')[0]
        fw.write(f"class {agent}_cov extends uvm_subscriber#({tx_name}_tx);\n")
        fw.write("\n")
        fw.write(f"  `uvm_component_utils({agent}_cov)\n")
        fw.write("\n")
        fw.write(f"  uvm_analysis_imp#({tx_name}_tx, {agent}_cov)       {agent}_cov_port;\n")
        fw.write("\n")
        fw.write(f"  {tx_name}_tx   tx_h;\n")
        fw.write("\n")
        fw.write("  covergroup cg();\n\n")
        fw.write("    // Implement Cover bins here\n\n")
        fw.write("  endgroup:cg\n")
        fw.write("\n")
        fw.write("  function new(string name=\"{}_cov\", uvm_component parent=null);\n".format(agent))
        fw.write("    super.new(name, parent);\n")
        fw.write("  endfunction:new\n")
        fw.write("\n")
        fw.write("  function void build_phase(uvm_phase phase);\n")
        fw.write("    super.build_phase(phase);\n")
        fw.write(f"    {agent}_cov_port = new(\"{agent}_cov_port\", this);\n")
        fw.write(f"    tx_h = {tx_name}_tx::type_id::create(\"tx_h\", this);\n")
        fw.write("  endfunction:build_phase\n")
        fw.write("\n")
        fw.write(f"  function void write({tx_name}_tx   t);\n")
        fw.write("\n")
        fw.write(f"    `uvm_info(\"{agent}_COV\", \"From Coverage Write function\", UVM_LOW)\n")
        fw.write("\n")
        fw.write("  endfunction:write\n")
        fw.write("\n")
        fw.write("  virtual task run_phase(uvm_phase phase);\n")
        fw.write("    super.run_phase(phase);\n")
        fw.write("\n")
        fw.write(f"    `uvm_info(\"{agent}_COV\",\"From Coverage Run Phase\", UVM_LOW)\n")
        fw.write("\n")
        fw.write("  endtask:run_phase\n")
        fw.write("\n")
        fw.write(f"endclass:{agent}_cov\n")
    print(f"******     {agent}_cov.sv files implementation is done     ******")

########################################### Creating Sequencer .sv files ##############################################

def create_sqr_sv_file(agent):
    with open(f"{agent}_sqr.sv", "w") as fw:
        tx_name = agent.split('_')[0]
        fw.write(f"class {agent}_sqr extends uvm_sequencer#({tx_name}_tx);\n")
        fw.write("\n")
        fw.write(f"  `uvm_component_utils({agent}_sqr)\n")
        fw.write("\n")
        fw.write(f"  function new(string name=\"{agent}_sqr\", uvm_component parent=null);\n")
        fw.write("    super.new(name, parent);\n")
        fw.write("  endfunction:new\n")
        fw.write("\n")
        fw.write(f"endclass:{agent}_sqr\n")
    print(f"******     {agent}_sqr.sv files implementation is done     ******") 
       
############################################ Creating Driver .sv files ################################################

def create_drv_sv_file(agent):
    with open(f"{agent}_drv.sv", "w") as fw:
        tx_name = agent.split('_')[0]
        fw.write(f"class {agent}_drv extends uvm_driver#({tx_name}_tx);\n")
        fw.write("\n")
        fw.write(f"  `uvm_component_utils({agent}_drv)\n")
        fw.write("\n")
        fw.write(f"  {tx_name}_tx               tx_h;\n")
        fw.write("\n")
        fw.write(f"  virtual {tx_name}_intf     vif;\n")
        fw.write("\n")
        fw.write(f"  function new(string name=\"{agent}_drv\", uvm_component parent=null);\n")
        fw.write("    super.new(name, parent);\n")
        fw.write("  endfunction:new\n")
        fw.write("\n")
        fw.write(f"  function void build_phase(uvm_phase phase);\n")
        fw.write("    super.build_phase(phase);\n")
        fw.write(f"    if(!uvm_config_db#(virtual {tx_name}_intf)::get(this, \" \", \"{tx_name}_pif\", vif))\n")
        fw.write(f"      `uvm_fatal(\"DRV\", \"***** Could not get vif *****\")\n")
        fw.write("  endfunction:build_phase\n")
        fw.write("\n")
        fw.write(f"  task run_phase(uvm_phase phase);\n")
        fw.write("\n")
        fw.write("     seq_item_port.get_next_item(req);\n")
        fw.write("       req.print();\n")
        fw.write("       drive_tx(req);\n")
        fw.write("     seq_item_port.item_done();\n")
        fw.write("\n")
        fw.write("  endtask:run_phase\n")
        fw.write("\n")
        fw.write(f"  task drive_tx({tx_name}_tx     tx_h);\n")
        fw.write("\n")
        fw.write("     //Implement driving logic here\n")
        fw.write("\n")
        fw.write("  endtask:drive_tx\n")
        fw.write("\n")
        fw.write(f"endclass:{agent}_drv\n")
    print(f"******     {agent}_drv.sv files implementation is done     ******")

######################################### Creating Sequencer_item .sv files ###########################################

def create_tx_sv_file(agent):
    with open(f"{agent}_tx.sv", "w") as fw:
        tx_name = agent.split('_')[0]
        fw.write(f"class {tx_name}_tx extends uvm_sequence_item;\n")
        fw.write("\n")
        fw.write("  //rand bit [31:0] data;\n")
        fw.write("\n")
        fw.write(f"  `uvm_object_utils_begin({tx_name}_tx)\n")
        fw.write("    //`uvm_field_int(data, UVM_ALL_ON)\n")
        fw.write("  `uvm_object_utils_end\n")
        fw.write("\n")
        fw.write(f"  function new(string name=\"{tx_name}_tx\");\n")
        fw.write("    super.new(name);\n")
        fw.write("  endfunction\n")
        fw.write("\n")
        fw.write("endclass\n")
    print(f"******     {agent}_tx.sv files implementation is done     ******")

########################################### Creating Interface .sv files ##############################################

def create_intf_sv_file(agent):
    with open(f"{agent}_intf.sv", "w") as fw:
        tx_name = agent.split('_')[0]
        for intf in intf_arr:
            one_intf_info = intf_info_hoa[intf]
            size = len(one_intf_info)
            if tx_name == intf:
                if one_intf_info[0] == 'M':
                    fw.write(f"interface {tx_name}_intf(input logic {one_intf_info[2]}, {one_intf_info[3]});\n")
                if one_intf_info[0] == 'S':
                    fw.write(f"interface {tx_name}_intf(input logic {one_intf_info[2]});\n")
        fw.write("\n")
        fw.write("  //Implement Modpot and clocking block here\n")
        fw.write("\n")
        fw.write(f"endinterface:{tx_name}_intf\n")
    print(f"******     {agent}_intf.sv files implementation is done     ******")

######################### Changing the directories for creation of agents directories files ###########################
        
for agent in agent_arr:
    os.makedirs(f"{dir_path}/{dut_name_lc}/project_area/verif/agents/{agent}", exist_ok=True)
    os.chdir(f"{dir_path}/{dut_name_lc}/project_area/verif/agents/{agent}")
    one_agent_info = agent_info_hoa[agent]
       
    create_agent_sv_file(agent,one_agent_info[0])
    create_mon_sv_file(agent,one_agent_info[0])
    create_intf_sv_file(agent)
    if one_agent_info[0] == "Active":
        create_tx_sv_file(agent)
        create_cov_sv_file(agent)
        create_sqr_sv_file(agent)
        create_drv_sv_file(agent)


################################################ Creating Make file ###################################################

def create_make_file(dut_name_lc):
    with open("makefile", "w") as fw:
        name = dir_path.split("/",2)
        if len(name) >= 3:
            result = name[2]
            print(f" ********** {result} ***********")
        else:
            print("Invalid path format")
        #print(f"************* {dir_name} ***********")
        fw.write(f"TEST_NAME={dut_name_lc}_base_test\n")
        fw.write(f"MODULE_PATH=../../../{dut_name_lc}\n")
        fw.write("\n")
        fw.write("SEED=10\n")
        fw.write("DUMP_OPTS=DUMP_ON\n")
        fw.write("\n")
        fw.write("DUT_DIR=$(MODULE_PATH)/project_area/design/rtl\n")
        fw.write("#DUT_FILE=$(DUT_DIR)/ethmac.v\n")
        fw.write("\n")
        fw.write("TB_DIR=$(MODULE_PATH)/project_area/verif/tb\n")
        fw.write("AGENT_DIR=$(MODULE_PATH)/project_area/verif/agents\n")
        fw.write("SEQ_DIR=$(MODULE_PATH)/project_area/verif/seqs\n")
        fw.write("TEST_DIR=$(MODULE_PATH)/project_area/verif/tests\n")
        fw.write("REG_DIR=$(MODULE_PATH)/project_area/verif/reg\n")
        fw.write("\n")
        fw.write("TOP_FILE=$(TB_DIR)/top.sv\n")
        fw.write("\n")
        fw.write("LOG_DIR=$(MODULE_PATH)/scratch_area/log\n")
        fw.write("SIM_DIR=$(MODULE_PATH)/scratch_area/sim\n")
        fw.write("\n")
        fw.write(f"INC_DIR=+incdir+$(DUT_DIR) +incdir+$(AGENT_DIR)")
        for agent in agent_arr:
            fw.write(f" +incdir+$(AGENT_DIR)/{agent}")# +incdir+$(AGENT_DIR)/phy_rx_agent +incdir+$(AGENT_DIR)/phy_tx_agent +incdir+$(AGENT_DIR)/wb_mst_agent +incdir+$(AGENT_DIR)/wb_slv_agent")
        fw.write(f" +incdir+$(TEST_DIR) +incdir+$(SEQ_DIR) +incdir+$(TB_DIR) +incdir+$(LOG_DIR) +incdir+$(SIM_DIR)\n")
        fw.write("\n")
        fw.write("comp:\n\tvlog -coveropt 3 +cover -L $(QUESTA_HOME)/uvm-1.2 +define+$(DUMP_OPTS) $(INC_DIR) $(DUT_FILE) $(TOP_FILE)\n")
        fw.write("\n")
        fw.write("vsim:\n\trm -rf $(LOG_DIR)/$(TEST_NAME)_$(SEED)\n")
        fw.write("\trm -rf $(TEST_NAME)_$(SEED).ucdb\n")
        fw.write("\tmkdir $(LOG_DIR)/$(TEST_NAME)_$(SEED)\n")
        fw.write("\tvsim -c -sv_seed $(SEED) -cvgperinstance -voptargs=+acc -coverage -voptargs=\"+cover=all\" -assertdebug -voptargs=\"+ASSERTION_ON\" +UVM_VERBOSITY=UVM_LOW +UVM_TESTNAME=$(TEST_NAME) -l $(LOG_DIR)/$(TEST_NAME)_$(SEED)/$(TEST_NAME)_$(SEED).log -do \"coverage save -onexit $(LOG_DIR)/$(TEST_NAME)_$(SEED)/$(TEST_NAME)_$(SEED).ucdb; run -all; exit\" work.top\n")
        fw.write("\n")
        fw.write("run:\tcomp vsim\n")
        fw.write("\n")
    print(f"******     makefiles implementation is done     ******")
    
########################## Changing the directories for creation of sim directories files #############################

os.chdir(f"{dir_path}/{dut_name_lc}/scratch_area/sim")

create_make_file(dut_name_lc)

#######################################################################################################################
