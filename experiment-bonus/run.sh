#!/bin/sh


DIR=$HOME/cache-sim

BENCHMARK_GCC=$DIR/benchmarks/gcc/cc1.ss
BENCHMARK_JUMP=$DIR/benchmarks/gcc/jump.i
BENCHMARK_STONE=$DIR/benchmarks/go/2stone9.in

N_SETS_L1=$3
CONFIG_L1=$N_SETS_L1:16:16:l
N_SETS_L2_S=$((N_SETS_L1 * 8))
N_SETS_L2_U=$((N_SETS_L1 * 16))
CONFIG_L2_U=$N_SETS_L2_U:16:16:l
CONFIG_L2_S=$N_SETS_L2_S:16:16:l

RESULTS_DIR=$DIR/experiment-bonus/data
RESULTS_GCC_U_L2_FILE=$RESULTS_DIR/gcc/ul2.csv
RESULTS_GCC_S_L2_FILE=$RESULTS_DIR/gcc/sl2.csv
RESULTS_GO_U_L2_FILE=$RESULTS_DIR/go/ul2.csv
RESULTS_GO_S_L2_FILE=$RESULTS_DIR/go/sl2.csv

TMP_FILE=$DIR/experiment-bonus/tmp.txt

exec_unified_l2() 
{
	echo "Running $BENCHMARK_NAME benchmark with unified L2 $CONFIG_L2_U..."

	$DIR/simplesim-3.0/sim-cache 	\
		-cache:il1 il1:$CONFIG_L1	\
		-cache:dl1 dl1:$CONFIG_L1	\
		-cache:il2 dl2	 			\
		-cache:dl2 dl2:$CONFIG_L2_U \
		-tlb:itlb none 				\
		-tlb:dtlb none 				\
		$BENCHMARK	 				\
		$BENCHMARK_INPUT	 		>> $TMP_FILE 2>&1

	awk -v ORS="," 	'{
						for ( i = 1; i <= NF; i++ ) {
							if ( $i == "-cache:dl1") {
								len=length($(i+1)) - 4;
								extracted = substr($(i+1), 5, len)
								split(extracted, values, ":")
								result = values[1] * values[2] * values[3]
								print result
							}
							if ( $i == "-cache:dl2") {
								len=length($(i+1)) - 4;
								extracted = substr($(i+1), 5, len)
								split(extracted, values, ":")
								result = values[1] * values[2] * values[3]
								print result
								exit 
							}
						}
					}' $TMP_FILE >> $RESULTS_FILE

	awk -v ORS=","	'{
						for ( i = 1; i <= NF ; i++) {
							if ( $i == "sim_num_insn" ) { 
								print $(i+1)
							}
							if ( $i == "sim_num_refs" ) {
								print $(i+1)
							}
							if ( $i == "il1.misses" ) {
								print $(i+1)
							}
							if ( $i == "dl1.misses" ) {
								print $(i+1)
							}
							if ( $i == "dl2.misses" ) {
								print $(i+1)
							}
						}
					}' $TMP_FILE | sed 's/,$/\n/' >> $RESULTS_FILE

	rm $TMP_FILE
}

exec_split_l2() 
{
	echo "Running $BENCHMARK_NAME benchmark with split L2 cache $CONFIG_L2_S..."
	$DIR/simplesim-3.0/sim-cache 	\
		-cache:il1 il1:$CONFIG_L1	\
		-cache:dl1 dl1:$CONFIG_L1	\
		-cache:il2 il2:$CONFIG_L2_S \
		-cache:dl2 dl2:$CONFIG_L2_S \
		-tlb:itlb none 				\
		-tlb:dtlb none 				\
		$BENCHMARK					\
		$BENCHMARK_INPUT	 		>> $TMP_FILE 2>&1

	awk -v ORS="," 	'{
						for ( i = 1; i <= NF; i++ ) {
							if ( $i == "-cache:dl1") {
								len=length($(i+1)) - 4;
								extracted = substr($(i+1), 5, len)
								split(extracted, values, ":")
								result = values[1] * values[2] * values[3]
								print result
							}
							if ( $i == "-cache:dl2") {
								len=length($(i+1)) - 4;
								extracted = substr($(i+1), 5, len)
								split(extracted, values, ":")
								result = values[1] * values[2] * values[3]
								print result
								exit
							}
						}
					}' $TMP_FILE >> $RESULTS_FILE

	awk -v ORS=","	'{
						for ( i = 1; i <= NF ; i++) {
							if ( $i == "sim_num_insn" ) { 
								print $(i+1)
							}
							if ( $i == "sim_num_refs" ) {
								print $(i+1)
							}
							if ( $i == "il1.misses" ) {
								print $(i+1)
							}
							if ( $i == "il2.misses" ) {
								print $(i+1)
							}
							if ( $i == "dl1.misses" ) {
								print $(i+1)
							}
							if ( $i == "dl2.misses" ) {
								print $(i+1)
							}
						}
					}' $TMP_FILE | sed 's/,$/\n/' >> $RESULTS_FILE

	rm $TMP_FILE
}
usage() 
{
	echo "Usage: $0 [gcc|go] [u|s] [n_sets]"

	exit 0 
}

if [[ "$#" -gt 2 ]]; then
	case $1 in
		gcc)
			BENCHMARK_NAME="GCC_4"
			BENCHMARK=$BENCHMARK_GCC
			BENCHMARK_INPUT=$BENCHMARK_JUMP
			case $2 in
				u)
					RESULTS_FILE=$RESULTS_GCC_U_L2_FILE
					exec_unified_l2
					exit 0
					;;
				s)
					RESULTS_FILE=$RESULTS_GCC_S_L2_FILE
					exec_split_l2
					exit 0
					;;
				*)
					usage
					;;
			esac
			;;
		go)
			BENCHMARK_NAME="GO_1"
			BENCHMARK=$DIR/benchmarks/go/go.ss" 50 9"
			BENCHMARK_INPUT=$BENCHMARK_STONE
			case $2 in
				u)
					RESULTS_FILE=$RESULTS_GO_U_L2_FILE
					exec_unified_l2
					exit 0
					;;
				s)
					RESULTS_FILE=$RESULTS_GO_S_L2_FILE
					exec_split_l2
					exit 0
					;;
				*)
					usage
					;;
			esac
			;;
		*)
			usage
			;;
	esac
else
	usage
fi
