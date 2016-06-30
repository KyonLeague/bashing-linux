#! /bin/bash

if [ -n "$1" ]; then
	if [ $1 = "--config" ] & [ -n "$2" ];
	then

		echo "count (key:value): $(cat $2 | wc -l)"

		count=0
		array=()
		
		# TODO fix fill array. 
		while read line; do
			echo $line
			array[$count]=$line
			count=$(($count+1))
		done < $2 | sort

		echo ${#array[*]}
		
		# write to file instead of console.
		echo "{"
		for (( i = 1; i < ${#array[*]}; i++ )); do
			kappa=$(echo ${array[$i]} | tr -d "\'" |  tr -d "=")
			echo $kappa
			tryhard=($kappa)
			echo "	\""${tryhard[0]}"\" = \""${tryhard[1]}"\""
		done
		echo "}"

	else
		echo "No config file given."
		exit 2
	fi

else
	echo "Error, no parameters given. Add --config ... "
	exit 1
fi

#for TEXT in "${array[@]}"
#do
#	echo "	$TEXT"
#done
