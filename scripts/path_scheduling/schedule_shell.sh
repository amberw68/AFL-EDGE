while getopts b:s:c:p: option
do
	case "${option}"
	in 
	b) BIN_PATH=${OPTARG};;
	s) SPLIT_PATH=${OPTARG};;
	c) COMMAND=${OPTARG};;
	p) PY_CODE=${OPTARG};;
	esac
done

if [[ $BIN_PATH == '' ]]; then
	echo 'Please provide BIN_PATH(-b)'
	exit -1
fi

if [[ $SPLIT_PATH == '' ]]; then
	echo 'Please provide SPLIT_PATH(-s)'
	exit -1
fi

if [[ $PY_CODE == '' ]]; then
	echo 'Please provide py code location(-p)'
	exit -1
fi


#let's wait for the fuzing for a little while
echo "let's take a nap!"
sleep 1h

last_round_seed_cnt=0

while true; do
	
	# realtime seed cnt will be updated every min
	real_time_seed_cnt=`ls $SPLIT_PATH/afl_S_0/queue/ | wc -l`

	# the target number of seeds for triggering next round: 10% more
	increment_target=`expr $last_round_seed_cnt \/ 10 + $last_round_seed_cnt`

	# indicates if the realtime seed cnt has equal or more than 110% of last round seeds num
	increment_bool=`expr $increment_target \<= $real_time_seed_cnt`


	# if realtime seed cnt is equal or more than 110% of last round seed cnt : scanning starts
	if [[ $increment_bool == 1 ]]; then

		start=$(date +"%T")

		echo "[*] >>>>>> Picking the seeds according to seed selection policy ..."


		rm $SPLIT_PATH/instance_info.txt	


		for queue in `find $SPLIT_PATH -name "queue" | grep -v "qsym"`; do

			slave_path=`dirname $queue`

			for i in $queue/*; do
				if grep -q "$i" $slave_path/hash_func_path.txt
				then 
					continue
				else 
					pathlist=`$BIN_PATH $COMMAND $i 2> /dev/null | grep -h PATHNUM`		
					echo "$i $pathlist" >> $slave_path/hash_func_path.txt;
				fi
			done

			echo "$slave_path/hash_func_path.txt $slave_path/discard_seeds" >> $SPLIT_PATH/instance_info.txt 
		done

		# Here should pass in python script : multi_distribute_by_path_func.py 
		python3 $PY_CODE $SPLIT_PATH/instance_info.txt
		
		# update last round seed cnt
		last_round_seed_cnt=`ls $SPLIT_PATH/afl_S_0/queue/ |wc -l`
	
		echo "$last_round_seed_cnt seeds in the queue" 

		echo "Start Time : $start"

		end=$(date +"%T")

		echo "End Time : $end";

	fi
	
	sleep 5m

done
