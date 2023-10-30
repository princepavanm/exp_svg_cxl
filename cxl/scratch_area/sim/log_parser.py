import os
import re
import textwrap
from prettytable import *
dir_path = "../regression_dir/logs"



def find_errors(file_path): #To extract the error message from the log
    keyword = "ERROR"
    exc = "# UVM_ERROR :    0\n"
    #exc1 = "# UVM_ERROR :    1"
    with open(file_path,"r") as log_file:
        lines = log_file.readlines()


    matching_line = None

    for line in lines:
        if keyword in line:
            if(line != exc):
                matching_line = line
                break
            
    if matching_line:
        return matching_line
    else:
        return "***TEST PASSED***"

def test_name(file_path): #To extract the test name from the log
    keyword = "UVM_TESTNAME"
    str_1 = ""
    with open(file_path,"r") as log_file:
        lines = log_file.readlines()


    matching_line = None

    for line in lines:
        if keyword in line:
            matching_line = line
            break

    pattern = r'(\w+)=([^;"]+)'

    matches = re.findall(pattern,matching_line)
    
    target_match = None
    for word, details in matches:
        if word == keyword:
            target_match = (word, details)
            str_1 = str(details)
            return str_1
            

    
    


def pass_or_fail(file_path): # To extract Pass/Fail from the log
    pass_str = "PASSED"
    fail_str = "FAILED"

    with open(file_path,"r") as log_file:
        content = log_file.read()
        
    if pass_str in content:
        return "PASS"
    elif fail_str in content:
        return "FAIL"
    else:
        return "UNKNOWN"



if __name__ == "__main__":
    if os.path.exists(dir_path):
        # List files in the directory
        file_names = [f for f in os.listdir(dir_path) if os.path.isfile(os.path.join(dir_path, f))]
        cnt =1
        table = PrettyTable()
        table.field_names = ["SL.No","TEST NAME","PASS/FAIL","Description"]
        table.hrules = ALL
        if file_names:
            for file_name in file_names:
                filepath = "../regression_dir/logs/"+file_name
                stat = pass_or_fail(filepath)
                message = find_errors(filepath)
                message = textwrap.fill(message,width=40)
                name = test_name(filepath)
                table.add_row([cnt,name,stat,message])
                cnt = cnt+1
        else:
            print("No files found in the directory.")
    else:
        print("Directory not found.")

    print(table)

