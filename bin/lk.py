#!/usr/bin/env python
import argparse
import os
import re
import subprocess
import sys

DATA_ROOT = os.path.expanduser("~/Workspace/lk_ws")
CODE_DIR = os.path.join(DATA_ROOT, "code")
TEST_DIR = os.path.join(DATA_ROOT, "test")
DEFAULT_LANGUAGE = "python3"
CMD = "leetcode"

def find_problem_file(dir, problem_id):
    for file in os.listdir(dir):
        if int(file.split(".")[0]) == problem_id:
            return os.path.join(dir, file)
    raise Exception(f"Problem id {problem_id} not found in {dir}")


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description = 'Say hello')
    parser.add_argument("--test", help="Test the leetcode problem", type=int)
    parser.add_argument("--submit", help="Submit the leetcode problem", type=int)
    parser.add_argument("--gen", help="Generate code with difficulty", type=str)
    args = parser.parse_args()

    if args.test:
        print("Testing")
        code_file = find_problem_file(CODE_DIR, args.test)
        test_file = find_problem_file(TEST_DIR, args.test)
        test_data = ""
        with open(test_file, 'r') as file:
            test_data = file.read()
        p = subprocess.check_output([CMD, "test", code_file, "-t", test_data])
        cmd_output = p.decode("utf-8")
        print(cmd_output)
    elif args.submit:
        code_file = find_problem_file(CODE_DIR, args.submit)
        p = subprocess.check_output([CMD, "submit", code_file])
        cmd_output = p.decode("utf-8")
        print(cmd_output)
    elif args.gen:
        p = subprocess.check_output([CMD, "show", "-q", args.gen, "-g", "-l", DEFAULT_LANGUAGE], cwd=CODE_DIR)
        cmd_output = p.decode("utf-8")
        print(cmd_output)
        gen_problem_id = re.findall("\[(\d+)\]", cmd_output)[0]
        code_file = find_problem_file(CODE_DIR, gen_problem_id)

