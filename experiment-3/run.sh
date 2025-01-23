#!/bin/sh

DIR=$HOME/cache-sim

BENCHMARK_CC1=$DIR/benchmarks/gcc/cc1.ss
BENCHMARK_GCC=$DIR/benchmarks/gcc/jump.i
BENCHMARK_GO=$DIR/benchmarks/go/go.ss" 50 9"
BENCHMARK_STONE=$DIR/benchmarks/go/2stone9.in

N_SETS=$3
ASSOC=$4
REPL=$2
CONFIG=$N_SETS:16:$ASSOC:$REPL

RESULTS_DIR=$DIR/experiment-3/data
RESULTS_GCC_DIR=$RESULTS_DIR/gcc
RESULTS_GO_DIR=$RESULTS_DIR/go

TMP_FILE=$DIR/experiment-3/tmp.txt

exec_gcc() 
{
	echo "Running GCC_4 benchmark with unified cache $N_SETS:16:$ASSOC:$REPL..."
	
	$DIR/simplesim-3.0/sim-cache 	\
		-cache:il1 dl1 				\
		-cache:dl1 ul1:$CONFIG		\
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
							if ( $i == "ul1.hits" ) {
								print $(i+1)
							}
							if ( $i == "ul1.misses" ) {
								print $(i+1)
							}
							if ( $i == "ul1.miss_rate" ) {
								print $(i+1)
							}

						}
					}' $TMP_FILE | sed 's/,$/\n/' >> $RESULTS_GCC_FILE

	rm $TMP_FILE
}

exec_go() 
{
	echo "Running GO_1 benchmark with unified cache $N_SETS:16:$ASSOC:$REPL..."

	$DIR/simplesim-3.0/sim-cache 	\
		-cache:il1 dl1 				\
		-cache:dl1 ul1:$CONFIG	 	\
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
							if ( $i == "ul1.hits" ) {
								print $(i+1)
							}
							if ( $i == "ul1.misses" ) {
								print $(i+1)
							}
							if ( $i == "ul1.miss_rate" ) {
								print $(i+1)
							}
						}
					}' $TMP_FILE | sed 's/,$/\n/' >> $RESULTS_GO_FILE

	rm $TMP_FILE
}

usage() 
{
	echo "Usage: $0 [gcc|go] [l|f|r] [n_sets] [assoc]"

	exit 0 
}

if [[ "$#" -gt 3 ]]; then
	case $2 in
		l)
			RESULTS_GCC_FILE=$RESULTS_GCC_DIR/lru.csv
			RESULTS_GO_FILE=$RESULTS_GO_DIR/lru.csv
			;;
		f)
			RESULTS_GCC_FILE=$RESULTS_GCC_DIR/fifo.csv
			RESULTS_GO_FILE=$RESULTS_GO_DIR/fifo.csv
			;;
		r)
			RESULTS_GCC_FILE=$RESULTS_GCC_DIR/random.csv
			RESULTS_GO_FILE=$RESULTS_GO_DIR/random.csv
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

