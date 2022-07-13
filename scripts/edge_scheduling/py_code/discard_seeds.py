import glob
import os
import struct
import sys
import ast
import itertools
import collections
import os

def discard_more_seeds(list_edges, split_num, discard_seeds, name_edge, split, split_point):

    keep_num = len(list_edges)//int(split_num)

    with open(discard_seeds, "a+") as fw:
        for i in list_edges[0 : split]:
            for seed, edge in name_edge.items():
                if i in edge:
                    fw.write(seed + "\n")
                else:
                    continue

        for j in list_edges[split + keep_num : -1]:
            for seed, edge in name_edge.items():
                if j in edge:
                    fw.write(seed + "\n")
                else:
                    continue

    with open(split_point, 'w+') as data:
        data.write(str(split + keep_num))

def main():
    if len(sys.argv) != 6:
        print("Wrong arguments. Usage: python3 xxx.py <path to XX>")
        exit()

    common_edges = sys.argv[1]
    split_num = sys.argv[2]
    discard_seeds = sys.argv[3]
    seed_edge_map = sys.argv[4]
    split_point = sys.argv[5]

    with open(common_edges, "r+") as content:
        list_edges = ast.literal_eval(content.read())

    with open(seed_edge_map, "r+") as data:
        content = iter(data)
        name_edge =dict()
        for i in content:
            if "id" in i:
                seed_name = i[i.index('id'):-1]
            else:
                seed_edge_map = ast.literal_eval(i)
            name_edge[seed_name] = seed_edge_map

    with open(split_point, "r+") as content:
        split = ast.literal_eval(content.read())

    discard_more_seeds(list_edges, split_num, discard_seeds, name_edge, split, split_point)

if __name__ == "__main__":
    main()




