#!/bin/sh

DIR=$HOME/cache-sim

BENCHMARK_CC1=$DIR/benchmarks/gcc/cc1.ss
BENCHMARK_GCC=$DIR/benchmarks/gcc/jump.i
BENCHMARK_GO=$DIR/benchmarks/go/go.ss" 50 9"
BENCHMARK_STONE=$DIR/benchmarks/go/2stone9.in

N_SETS=$2
B_SIZE=$3
CONFIG=$N_SETS:$B_SIZE:1:l

RESULTS_DIR=$DIR/experiment-4/data
RESULTS_GCC_DIR=$RESULTS_DIR/gcc
RESULTS_GO_DIR=$RESULTS_DIR/go

TMP_FILE=$DIR/experiment-4/tmp.txt

exec_gcc() 
{
	echo "Running GCC_4 benchmark with split cache $CONFIG..."

	$DIR/simplesim-3.0/sim-cache 	\
		-cache:il1 il1:$CONFIG	 	\
		-cache:dl1 dl1:$CONFIG	 	\
		-cache:il2 none 			\
		-cache:dl2 none 			\
		-tlb:itlb none 				\
		-tlb:dtlb none 				\
		$BENCHMARK_CC1		 		\
		$BENCHMARK_GCC 				>> $TMP_FILE 2>&1

	awk -v ORS="," 	'{
						for ( i = 1; i <= NF; i++ ) {
							if ( $i == "-cache:dl1") {
								gsub(/:/, ",")
								len=length($(i+1)) - 4;
								extracted = substr($(i+1), 5, len)
        						print extracted
								split(extracted, values, ",")
								result = values[1] * values[2] * values[3]
								print result
								exit 
							}
						}
					}' $TMP_FILE >> $RESULTS_GCC_FILE

	awk -v ORS=","	'{
						for ( i = 1; i <= NF ; i++) {
							if ( $i == "sim_num_insn" ) { 
								print $(i+1)
							}
							if ( $i == "sim_num_refs" ) {
								print $(i+1)
							}
							if ( $i == "il1.accesses" ) {
								il1_accesses = $(i+1)
							}
							if ( $i == "il1.hits" ) {
								print $(i+1)
							}
							if ( $i == "il1.misses" ) {
								il1_misses = $(i+1)
								print $(i+1)
								il1_miss_rate = il1_misses/il1_accesses
								print il1_miss_rate
							}
							if ( $i == "dl1.accesses" ) {
								dl1_accesses = $(i+1)
							}
							if ( $i == "dl1.hits" ) {
								print $(i+1)
							}
							if ( $i == "dl1.misses" ) { 
								dl1_misses = $(i+1)
								print $(i+1)
								dl1_miss_rate = dl1_misses/dl1_accesses
								print dl1_miss_rate
							}
						}
					}' $TMP_FILE | sed 's/,$/\n/' >> $RESULTS_GCC_FILE

	rm $TMP_FILE
}

exec_go() 
{
	echo "Running GO_1 benchmark with split cache $CONFIG..."
	
	$DIR/simplesim-3.0/sim-cache 	\
		-cache:il1 il1:$CONFIG	 	\
		-cache:dl1 dl1:$CONFIG	 	\
		-cache:il2 none 			\
		-cache:dl2 none 			\
		-tlb:itlb none 				\
		-tlb:dtlb none 				\
		$BENCHMARK_GO			 	\
		$BENCHMARK_STONE 			>> $TMP_FILE 2>&1

	awk -v ORS="," 	'{
						for ( i = 1; i <= NF; i++ ) {
							if ( $i == "-cache:dl1") {
								gsub(/:/, ",")
								len=length($(i+1)) - 4;
								extracted = substr($(i+1), 5, len)
        						print extracted
								split(extracted, values, ",")
								result = values[1] * values[2] * values[3]
								print result
								exit 
							}
						}
					}' $TMP_FILE >> $RESULTS_GO_FILE

	awk -v ORS=","	'{
						for ( i = 1; i <= NF ; i++) {
							if ( $i == "sim_num_insn" ) { 
								print $(i+1)
							}
							if ( $i == "sim_num_refs" ) {
								print $(i+1)
							}
							if ( $i == "il1.accesses" ) {
								il1_accesses = $(i+1)
							}
							if ( $i == "il1.hits" ) {
								print $(i+1)
							}
							if ( $i == "il1.misses" ) {
								il1_misses = $(i+1)
								print $(i+1)
								il1_miss_rate = il1_misses/il1_accesses
								print il1_miss_rate
							}
							if ( $i == "dl1.accesses" ) {
								dl1_accesses = $(i+1)
							}
							if ( $i == "dl1.hits" ) {
								print $(i+1)
							}
							if ( $i == "dl1.misses" ) { 
								dl1_misses = $(i+1)
								print $(i+1)
								dl1_miss_rate = dl1_misses/dl1_accesses
								print dl1_miss_rate
							}
						}
					}' $TMP_FILE | sed 's/,$/\n/' >> $RESULTS_GO_FILE

	rm $TMP_FILE
}

usage() 
{
	echo "Usage: $0 [gcc|go] [n_sets] [b_size]"

	exit 0 
}

if [[ "$#" -gt 2 ]]; then
	case $3 in
		128)
			RESULTS_GCC_FILE=$RESULTS_GCC_DIR/s_128.csv
			RESULTS_GO_FILE=$RESULTS_GO_DIR/s_128.csv
			;;
		256)
			RESULTS_GCC_FILE=$RESULTS_GCC_DIR/s_256.csv
			RESULTS_GO_FILE=$RESULTS_GO_DIR/s_256.csv
			;;
		512)
			RESULTS_GCC_FILE=$RESULTS_GCC_DIR/s_512.csv
			RESULTS_GO_FILE=$RESULTS_GO_DIR/s_512.csv
			;;
		1024)
			RESULTS_GCC_FILE=$RESULTS_GCC_DIR/s_1024.csv
			RESULTS_GO_FILE=$RESULTS_GO_DIR/s_1024.csv
			;;
		*)
			usage
			;;
	esac
	case $1 in
		gcc)
			exec_gcc
			exit 0
			;;
		go)
			exec_go
			exit 0 
			;;
		*)
			usage
			;;
	esac
else
	usage
fi

