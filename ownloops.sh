#! /bin/sh


if [ -n "$1" ] & [ -n "$2" ]; then
	count=0
	while [ $1 -gt $count ]; do

		echo ""
		echo "Ich glaube wir brauchen mehr Zeiten !!!"
		echo ""

		for (( i = 0; i < $2; i++ )); do
			time+=$(date)"\n"
			echo $time
		done

		echo ""
		echo "Und nochmal !"
		echo ""

		for (( i = 0; i < 1; i++ )); do
			echo $time
		done

		count=$((count+1))

	done
else
	echo "Please enter those parameters: [random number] [random number]"
fi
