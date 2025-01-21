#!/bin/sh

if [[ "$#" != 1 ]]; then
	echo "Usage: $0 [filepath]"
	
	exit 0
fi

sed -i '2,$d' $1
