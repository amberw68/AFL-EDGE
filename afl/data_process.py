import glob
import os
import struct
import matplotlib.pyplot as plt
import numpy as np

bitmap_size = 1024 * 64

total_size = 64 * 1024 * 8

def decimal_binary(x):
	return bin(x)[2:].zfill(8)

def bitmaps_overlap(path):
	overlap_counts = []
	for filename in sorted(glob.glob(os.path.join(path, '*.txt'))):
		overlap_count = 0
		with open(filename,mode = "rb") as file:
			count = 0		
			total_byte = file.read()
			for i in range(bitmap_size):
				for j in range(len(decimal_binary(total_byte[i]))):
					if int(decimal_binary(total_byte[i])[j]) == 0 and int(decimal_binary(total_byte[i + bitmap_size])[j]) == 0:
						overlap_count += 1

			overlap_counts.append(overlap_count)
	x_axis = np.linspace(0, len(overlap_counts), len(overlap_counts))
	plt.plot(x_axis, overlap_counts, label='overlap')
	plt.xlabel('Epoch TimeStamp')
	plt.ylabel('Overlap Count')
	plt.title('Graph of Overlap')
	plt.legend()
	plt.show()

def bitmaps_difference(path):
	difference_counts = []
	for filename in sorted(glob.glob(os.path.join(path, '*.txt'))):
		difference_count = 0
		with open(filename,mode = "rb") as file:
			count = 0		
			total_byte = file.read()
			for i in range(bitmap_size):
				for j in range(len(decimal_binary(total_byte[i]))):
					difference_count += int(decimal_binary(total_byte[i])[j]) ^ int(decimal_binary(total_byte[i + bitmap_size])[j])
			difference_counts.append(difference_count)

	x_axis = np.linspace(0, len(difference_counts), len(difference_counts))
	plt.plot(x_axis, difference_counts, label='difference')
	plt.xlabel('Epoch TimeStamp')
	plt.ylabel('Difference Count')
	plt.title('Graph of Difference')
	plt.legend()
	plt.show()

def bitmaps_overall(path):
	overall_counts = []
	for filename in sorted(glob.glob(os.path.join(path, '*.txt'))):
		overall_count = 0
		with open(filename,mode = "rb") as file:
			count = 0		
			total_byte = file.read()
			for i in range(bitmap_size):
				for j in range(len(decimal_binary(total_byte[i]))):
					if int(decimal_binary(total_byte[i])[j]) == 0 or int(decimal_binary(total_byte[i + bitmap_size])[j]) == 0:
						overall_count += 1
			overall_counts.append(overall_count)

	x_axis = np.linspace(0, len(overall_counts), len(overall_counts))
	plt.plot(x_axis, overall_counts, label='overall')
	plt.xlabel('Epoch TimeStamp')
	plt.ylabel('Overall Count')
	plt.title('Graph of Overall')
	plt.legend()
	plt.show()

def main():
	path = "/home/dennis/binutils-2.32/executable/bin/objdump_out/fuzzor02/bitmap_comparison"
	# path = "/home/dennis/Desktop"
	bitmaps_overlap(path)
	bitmaps_difference(path)
	bitmaps_overall(path)

main()




