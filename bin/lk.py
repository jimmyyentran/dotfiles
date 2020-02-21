#!/usr/bin/env python
import argparse
import os
import re
import subprocess
from bs4 import BeautifulSoup

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


def remove_file(dir, problem_id):
    try:
        file = find_problem_file(dir, problem_id)
        os.remove(file)
    except:
        print(f"Can't find {problem_id} in {dir}")


def get_testcases(cmd_output):
    TARGET_WORDS = ["Testcase Example:", "Input:"]
    example_lines = [line for line in cmd_output.split('\n') if any(x in line for x in TARGET_WORDS)]

    ret_example_lines = []
    for el in example_lines:
        soup = BeautifulSoup(el, 'html.parser')
        try:
            soup.find('strong').decompose()
        except:
            print("Can't find strong")
        ret_example_lines.append(soup.string)

    ret_example_lines = "\n".join(ret_example_lines)
    for tw in TARGET_WORDS:
        ret_example_lines = ret_example_lines.replace(tw, "")
    return ret_example_lines


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Say hello')
    parser.add_argument("--test", help="Test the leetcode problem", type=int)
    parser.add_argument("--submit", help="Submit the leetcode problem", type=int)
    parser.add_argument("--remove", help="Remove the leetcode problem", type=int)
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
    elif args.remove:
        remove_file(CODE_DIR, args.remove)
        remove_file(TEST_DIR, args.remove)
        print("Remove successfully")
    elif args.gen:
        p = subprocess.check_output([CMD, "show", "-q", args.gen, "-gx", "-l", DEFAULT_LANGUAGE], cwd=CODE_DIR)
        cmd_output = p.decode("utf-8")
        cmd_output = cmd_output.replace('&amp;', '&').replace('&lt;', '<').replace('&gt;', '>') \
            .replace('&quot;', '"').replace('&#39;', "'").replace("&nbsp;", "")
        print(cmd_output)

        gen_problem_id = re.findall("\[(\d+)\]", cmd_output)[0]
        code_file = find_problem_file(CODE_DIR, int(gen_problem_id))
        code_file_base = os.path.basename(code_file)
        code_file_pre, ext = os.path.splitext(code_file_base)
        text_file_base = code_file_pre + '.test'

        example_lines = get_testcases(cmd_output)

        with open(os.path.join(TEST_DIR, text_file_base), 'w') as temp_file:
            temp_file.write(example_lines)
