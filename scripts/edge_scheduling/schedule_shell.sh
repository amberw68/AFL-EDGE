while getopts b:a:n:s:c:p: option
do
	case "${option}"
	in
	b) BIN_PATH=${OPTARG};; #path to the binary
	a) AFL_BIN=${OPTARG};; #path to the afl binary
	n) NUMBER=${OPTARG};; #number of instance
	s) SPLIT_PATH=${OPTARG};; #path to the split folder
	c) CMIN=${OPTARG};; #path to the afl-cmin
	p) OPTION=${OPTARG};; #target bin option
	
	esac
done

if [[ $BIN_PATH == "" ]]; then
	echo "Please input the binary path (-b)"
	exit -1
fi

if [[ $AFL_BIN == "" ]]; then
	echo "Please input the afl binary path (-a)"
	exit -1
fi

if [[ $NUMBER == "" ]]; then
	echo "Please input the number of instance (-n)"
	exit -1
fi

if [[ $SPLIT_PATH == "" ]]; then
	echo "Please input the split folder path (-s)"
	exit -1
fi

if [[ $CMIN == "" ]]; then
	echo "Please input the afl-cmin path (-c)"
	exit -1
fi

if [[ $OPTION == "" ]]; then
	echo "Please input the target bin option (-p)"
	exit -1
fi

hour_cnt=0

#let's wait for the fuzing for a little while
sleep 1h

last_round_seed_cnt=0

while true;do

	# realtime seed cnt will be updated every min
	real_time_seed_cnt=`ls $SPLIT_PATH/afl_S_0/queue/ | wc -l`
	
	# the target number of seeds for triggering next round: 10% more
	increment_target=`expr $last_round_seed_cnt \/ 10 + $last_round_seed_cnt`
	
	# indicates if the realtime seed cnt has equal or more than 110% of last round seeds num
	increment_bool=`expr $increment_target \<= $real_time_seed_cnt`

        # if realtime seed cnt is equal or more than 110% of last round seed cnt : scanning starts
        if [[ $increment_bool == 1 ]]; then

		start=$(date + "%T")

		echo "[*] >>>>>> Picking the seeds according to seed selection policy ..."

    		for queue in `find $SPLIT_PATH -name "queue" | grep -v "afl_M"`; do

			echo "[*] currently handle $queue ..."
			slave_path=`dirname $queue`
			if [[ -d "$slave_path/optimized_seeds" ]]; then
			    echo "[-] delete $slave_path/optimized_seeds"
			    rm -r $slave_path/optimized_seeds
			fi

			$CMIN -m none -i $queue -o $slave_path/optimized_seeds -- $AFL_BIN $OPTION @@

			# get the discard seeds according to the afl-cmin and save them into discard_seeds
			diff -q $queue $slave_path/optimized_seeds | grep 'queue' | grep 'Only in' | grep -v '\.state' | cut -d ':' -f2- | xargs -n1 echo > $slave_path/discard_seeds  

    done	

		for optimized_seeds in `find $SPLIT_PATH -name "optimized_seeds" | grep -v "afl_M"`; do
			slave_path=`dirname $optimized_seeds`
			for i in $optimized_seeds/*; do
				$BIN_PATH $OPTION $i |grep -h "|" >> $slave_path/result_edge_number.txt
				echo "$i" >> $slave_path/seeds_edges.txt
				python3 scripts/edge_scheduling/py_code/collect_edges.py $slave_path/result_edge_number.txt $SPLIT_PATH>> $slave_path/seeds_edges.txt
				rm -r $slave_path/result_edge_number.txt
			done
			python3 scripts/edge_scheduling/py_code/hit_once_edges.py $SPLIT_PATH/edge_counts.txt $SPLIT_PATH
			rm -r $SPLIT_PATH/edge_counts.txt

		done

		echo 0 > $SPLIT_PATH/cursor

		for seeds_edges in `find $SPLIT_PATH -name "seeds_edges.txt" | grep -v "afl_M"`; do
			slave_path=`dirname $seeds_edges`
			python3 scripts/edge_scheduling/py_code/discard_seeds.py $SPLIT_PATH/common_edges.txt $NUMBER $slave_path/discard_seeds $slave_path/seeds_edges.txt $SPLIT_PATH/cursor 
			rm -r $slave_path/seeds_edges.txt
		done

		rm -r $SPLIT_PATH/common_edges.txt
		rm -r $SPLIT_PATH/cursor

		date

		# update last round seed cnt
		last_round_seed_cnt=`ls $SPLIT_PATH/afl_S_0/queue/ |wc -l`
		
		echo "$last_round_seed_cnt seeds in the queue" 
		
		echo "Start Time : $start"
		
		end=$(date +"%T")
		
		echo "End Time : $end";


	fi

	sleep 5m

done
