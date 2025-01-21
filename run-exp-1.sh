#!/bin/sh

DIR=$HOME/trabalho-aoc

# benchmark
BENCHMARK_CC1=$DIR/benchmarks/gcc/cc1.ss
BENCHMARK_GCC=$DIR/benchmarks/gcc/jump.i
BENCHMARK_GO=$DIR/benchmarks/go/go.ss
BENCHMARK_STONE=$DIR/benchmarks/go/2stone9.in" 50 9"

# config
N_SETS=$2
ASSOC=$3
CONFIG=$N_SETS:16:$ASSOC
CONFIG_NAME=$N_SETS-16-$ASSOC

# result files
RESULTS_GCC_DIR=$DIR/results/exp-1/gcc
RESULTS_GO_DIR=$DIR/results/exp-1/go
GCC_RESULTS_FILE=$RESULTS_GCC_DIR/gcc-results-$CONFIG_NAME.txt
GO_RESULTS_FILE=$RESULTS_GO_DIR/go-results-$CONFIG_NAME.txt

exec_gcc() {
	echo "Running GCC_4 benchmark with cache $N_SETS:16:$ASSOC:l..."
	
	# <name>:<nsets>:<bsize>:<assoc>:<repl>
	./simplesim-3.0/sim-cache 		\
		-cache:il1 il1:$CONFIG:l 	\
		-cache:dl1 dl1:$CONFIG:l 	\
		-cache:il2 none 			\
		-cache:dl2 none 			\
		-tlb:itlb none 				\
		-tlb:dtlb none 				\
		$BENCHMARK_CC1		 		\
		$BENCHMARK_GCC 				>> $DIR/tmp.txt 2>&1

	cat $DIR/tmp.txt | grep -A999 "** simulation statistics **" > $DIR/tmp-2.txt

	awk '{
			for ( i = 1; i <= NF ; i++) {
				if ( $i == "sim_num_insn" ) { 
					print "instructions executed = " $(i+1)
				}
				if ( $i == "sim_num_refs" ) {
					print "load/stores = " $(i+1)
				}
				if ( $i == "il1.misses" ) {
					print "misses cache de instrucoes = " $(i+1)
				}
				if ( $i == "dl1.misses" ) { 
					print "misses cache de dados = " $(i+1)
				}
			}
		}' $DIR/tmp-2.txt > $GCC_RESULTS_FILE

	rm $DIR/tmp.txt
	rm $DIR/tmp-2.txt

	exit 0 
}

exec_go() {
	echo "Running GO_1 benchmark..."

	./simplesim-3.0/sim-cache		\
		-cache:il1 il1:64:64:1:f 	\
		-cache:dl1 dl1:64:64:1:f 	\
		-cache:il2 none 			\
		-cache:dl2 none 			\
		-tlb:itlb none 				\
		-tlb:dtlb none 				\
		$BENCHMARK_GO	 			\
		$BENCHMARK_STONE			>> tmp.txt 2>&1

	cat tmp.txt | grep -A999 "** simulation statistics **" > go-results.txt

	rm tmp.txt

	awk	'{ 
			for ( i = 1; i <= NF ; i++) {
				if ( $i == "sim_num_insn" ) { 
					print "instructions executed = " $2; 
				}
				if ( $i == "sim_num_refs" ) {
					print "load/stores = " $2
				}
				if ( $i == "dl1.misses" ) { 
					print "misses cache de dados = " $2; 
				}
			}
		}' go-results.txt

	exit 0
}


usage() {
	echo "Usage: $0 [gcc|go] [n_sets] [assoc]"

	exit 0 
}

if [[ "$#" -gt 2 ]]; then
	case $1 in
		gcc)
			exec_gcc
			;;
		go)
			exec_go
			;;
		*)
			usage
			;;
	esac
else
	usage
fi

