# AFL-EDGE

## Overview
Fuzz testing has become one of the de facto standard techniques for bug finding in the software industry. However, most of the popular fuzzing tools naively run multiple instances concurrently, without elaborate distribution of workload. This can lead different instances to explore overlapped code regions, eventually reducing the benefits of concurrency. We develop a solution, called AFL-EDGE, to improve the parallel mode of AFL, considering a round of mutations to a unique seed as a task and adopting edge coverage to define the uniqueness of a seed.

## Environment
- Tested on Ubuntu 16.04 64bit, 18.04 64bit and 20.04 64bit
- Installation of [ gllvm ](https://cran.r-project.org/web/packages/gllvm/index.html) is required
- [ Go ](https://go.dev/) Installation is recommended for running instance concurrently

## Usage

### Compile target binary with afl-clang

~~~~{.sh}

# Obtain target_binary_afl : Compile with AFL compiler
$ CC=afl-clang CXX=afl-clang++ LLVM_COMPILER=clang CFLAGS="-g -O3" CXXFLAGS="-g -O3" /location/of/your/src/code/configure --enable-static=yes --enable-shared=no
$ make /location/of/your/build_afl_dir

~~~~

### Compile target binary with gclang

~~~~{.sh}

# Obtain target_binary_instru : Compile with gclang
$ CC=gclang CXX=gclang++ LLVM_COMPILER=clang CFLAGS="-g -O3" CXXFLAGS="-g -O3" /location/of/your/src/code/configure --enable-static=yes --enable-shared=no
$ make /location/of/your/build_instru_dir

~~~~

### Obtain .bc file

~~~~{.sh}

# Obtain .bc file from target_binary_instru
$ get-bc [ target_binary_instru ]

~~~~
 
### Instrumentations : we provide two intrumentations following different task distrubution rules(based on CFG-edges or CFG-paths). Feel free to pick one for your fuzzing works. [ How to build the passes ](passes)

~~~~{.sh}

$ cd AFL-EDGE/

# Edge method instrumentation :  
# Obtain target_binary_edge.bc 
$ opt -load passes/CFG_edge_pass/build/splitEdge_inst/libsplit_edge.so -iterateAllBB [ target_binary_instru.bc ] -S -o [ target_binary_edge.bc ]
# Obtain target_binary_edge
$ clang++ -o [ target_binary_edge ] [ target_binary_edge.bc ] -ldl passes/CFG_edge_pass/build/runtime/libruntime.a

# Path method instrumentation : 
# Obtain target_binary_path.bc
$ opt -load passes/CFG_path_pass/build/basicBlock_inst/libbasicBlock_profiling.so -iterateAllBB [ target_binary_instru.bc ] -S -o [ target_binary_path.bc ]
$ clang++ -o [ target_binary_path ] [ target_binary_path.bc ] -ldl passes/CFG_path_pass/build/runtime/libruntime.a

~~~~

### Start Fuzzing : 
#### step 1 : running desired number of fuzzing instances concurrently

~~~~{.sh}

$ go run afl-launch/main.go -afl afl/afl-fuzz -i [ seed_dir ] -no-master -name afl -o [ output_dir ] -n [ # of instances ] -- [ target_binary_afl ] [ option ] @@

~~~~


#### step 2 : runing task distribution tool by following command 

~~~~{.sh}

# Task Distribution Scheduling (Edge) : 
$ bash scripts/edge_scheduling/schedule_shell.sh -b [ target_binary_edge ] -a [ targe_binary_afl ] -n [ #_of_instances ] -s [ AFL_output_dir ] -c /location/of/afl-cmin -p [ option ]

# Task Distribution Scheduling (Path)
$ bash scripts/path_scheduling/schedule_shell.sh -b [ target_binary_path ] -s [ AFL_output_dir ] -c [ option ] -p scripts/path_scheduling/py_code/multi_distribute_by_path_func.py

~~~~

## Publications

~~~~{.sh}

Facilitating Parallel Fuzzing with Mutually-exclusive Task Distribution

@inproceedings{yun:qsym,
  title        = {{Facilitating Parallel Fuzzing with Mutually-exclusive Task Distribution}},
  author       = {Yifan Wang and Yuchen Zhang and Chengbin Pang and Peng Li and Nikolaos Triandopoulos and Jun Xu},
  booktitle    = {Proceedings of the 17th EAI International Conference on Security and Privacy in Communication Networks (SecureComm)},
  month        = Sep,
  year         = 2021,
  address      = {Canterbury, Great Britain (online)},
}

~~~~
