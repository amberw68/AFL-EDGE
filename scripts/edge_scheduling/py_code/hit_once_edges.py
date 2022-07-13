import glob
import os
import struct
import sys
import ast
import itertools
import collections
import os

def seed_filter(edge_dic, path):

    hit_once_edge = []
    for key, value in edge_dic.items():
        if int(value) == 1:
            hit_once_edge.append(key)
        else:
            continue

    target_path = path + '/common_edges.txt'

    if os.path.exists(target_path):
        with open(target_path, 'r+') as content:
            prev_list = ast.literal_eval(content.read())
            update_list = set(prev_list).intersection(set(hit_once_edge))
            content.seek(0)
            content.truncate()
            content.write(str(list(update_list)))
    else:
        with open(target_path, 'w+') as data:
            data.write(str(hit_once_edge))

def main():
    if len(sys.argv) != 3:
        print("Wrong arguments. Usage: python3 xxx.py <path to XX>")
        exit()

    edge_counts = sys.argv[1]

    with open(edge_counts, "r+") as data:
        edge_dic = ast.literal_eval(data.read())

    path = sys.argv[2]

    seed_filter(edge_dic, path)

if __name__ == "__main__":
    main()