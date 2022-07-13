#!/usr/bin/env python
# coding: utf-8

import sys

def main(instance_info):

	instance_info_dict = {}
	instance_path_dict = {}
	
	over_lapped_path = set()

	# get all the source info and destination info; keep them in a dict
	with open(instance_info) as fr: 
		for instance in fr.readlines():
			instance = instance.strip()
			instance_info_dict[instance.split(" ")[0]] = instance.split(" ")[1]
			instance_path_dict[instance.split(" ")[0]] = dict()
	
	# get all the paths hit by a instance and pertain them with the hitting seeds
	for instance in instance_info_dict: 
		with open(instance) as fr:
			for seed_path in fr.readlines():
				if seed_path.find("PATHNUM") == -1: 
					continue

				seed_path = seed_path.strip()
				seed = seed_path.split(" ")[0].split("/")[-1]
				path = seed_path.split(" ")[1]

				if path not in instance_path_dict[instance]:
					instance_path_dict[instance][path] = set()
				
				instance_path_dict[instance][path].add(seed)
				# this is to first get all the paths from all instances. No worries, they will be later intersected with paths from each instance
				over_lapped_path.add(path)

	
	#get the overlapping paths
	for instance in instance_path_dict:
		over_lapped_path =  over_lapped_path.intersection(instance_path_dict[instance].keys())


	#split paths to different instances with each instance getting the same amount of paths
	overlap_list = list(over_lapped_path)
	num_of_ins = len(instance_info_dict)
	path_per_ins = int(len(overlap_list) / num_of_ins)

	ins_cnt = 0 

	for instance in instance_info_dict:
		with open(instance_info_dict[instance], "w") as fw:
			for path in overlap_list:
				if path not in overlap_list[ins_cnt * path_per_ins: (ins_cnt + 1) * path_per_ins]:
					[fw.write(seed + "\n") for seed in instance_path_dict[instance][path]]	

		ins_cnt += 1


if __name__ == "__main__":
	main(sys.argv[1])





