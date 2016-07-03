#! /bin/bash

myread(){
	read -e -p '> ' $1
}

if [ -n "$1" ]; then
	if [ $1 = "--config" ] & [ -n "$2" ] & [ "$2" != "-" ];
	then

		echo "count (key:value): $(cat $2 | wc -l)"
		count=0
		strong=$(cat $2 | sort)

		while IFS='' read -r line || [[ -n "$line" ]]; do
			array[$count]=$line
			count=$(($count+1))
		done <<< "$strong"

		touch $2.json
		echo "{" > "$2".json

		for (( i = 0; i < ${#array[*]}; i++ )); do
			kappa=$(echo ${array[$i]} | tr -d "\'" |  tr -d "=")
			tryhard=($kappa)
			re='^-?[0-9]+([.][0-9]+)?'
			if [[ $i -eq $((${#array[*]}-1)) ]]; then
				if ! [[ $tryhard[1] =~ $re ]] ; then
					echo "	\""${tryhard[0]}"\": \""${tryhard[1]}"\"" >> "$2".json
				else
					echo "	\""${tryhard[0]}"\": "${tryhard[1]}"" >> "$2".json
				fi
			else
				if ! [[ $tryhard[1] =~ $re ]] ; then
					echo "	\""${tryhard[0]}"\": \""${tryhard[1]}"\"," >> "$2".json
				else
					echo "	\""${tryhard[0]}"\": "${tryhard[1]}"," >> "$2".json
				fi
			fi

		done
		echo "}" >> "$2".json


	elif [ $1 = "--config" ] & [ -n "$2" ] & [ "$2" = "-" ];
	then

		while myread line; do
			case ${line%% *} in
				exit ) break ;;
				*		 )
								array[$count]=$line
								count=$(($count+1));;
			esac
		done

		config="myjsonconfig"
		touch $config.json
		echo "{" > "$config".json

		for (( i = 0; i < ${#array[*]}; i++ )); do

			kappa=$(echo ${array[$i]} | tr -d "\'" |  tr -d "=")
			tryhard=($kappa)
			re='^-?[0-9]+([.][0-9]+)?'

			if [[ $i -eq $((${#array[*]}-1)) ]]; then
				if ! [[ $tryhard[1] =~ $re ]] ; then
					echo "	\""${tryhard[0]}"\": \""${tryhard[1]}"\"" >> "$config".json
				else
					echo "	\""${tryhard[0]}"\": "${tryhard[1]}"" >> "$config".json
				fi
			else
				if ! [[ $tryhard[1] =~ $re ]] ; then
					echo "	\""${tryhard[0]}"\": \""${tryhard[1]}"\"," >> "$config".json
				else
					echo "	\""${tryhard[0]}"\": "${tryhard[1]}"," >> "$config".json
				fi
			fi

		done
		echo "}" >> "$config".json

	else
		echo "No config file given."
		exit 2
	fi

else
	echo "Error, no parameters given. Add --config [FILE] " 1>&2
	exit 1
fi
