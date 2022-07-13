import glob
import os
import struct
import sys
import ast
import itertools  
import collections 
import os
import calendar
import time
import json

def collect_edges(path, folder_path):
	all_edges = []
	edges_dic = dict()
	with open(path, "r+") as file:
		content = file.readlines()
		for i in content:
			if "|" in i:
				all_edges = i.split("|")
			else:
				continue
	print(all_edges)

	for i in all_edges:
		if i != '\n':
			edges_dic[i] = 1
		else:
			continue

	target_path = folder_path + '/edge_counts.txt'
				
	if os.path.exists(target_path):
		with open(target_path, 'r+') as content:
			dictionary = ast.literal_eval(content.read())
			update_count = collections.defaultdict(int)
			for key, val in itertools.chain(dictionary.items(), edges_dic.items()):
				update_count[key] += val
			content.seek(0)
			content.truncate()	
			content.write(str(dict(update_count)))
	else:
		with open(target_path, 'w+') as data:
			data.write(str(edges_dic))

	
def main():

    if len(sys.argv) != 3:
    	print("Wrong arguments. Usage: python3 xxx.py <path to XX>")
    	exit()

    path = sys.argv[1]

    folder_path = sys.argv[2]

    collect_edges(path, folder_path)

if __name__ == "__main__":
    main()