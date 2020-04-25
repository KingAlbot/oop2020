#!/bin/bash

path_of_tests=tests
tests=(        # TEST 0
	'1231234 000'   # TEST 1
	'ma mama'       # TEST 2
	'"" empty'      # TEST 3
	'fox dog'       # TEST 4
	'Ipsum STRING'  # TEST 5
	
	)        
i=1

g++ replace.cpp -o replace
for te in "${tests[@]}"
do
	echo "Test $i:"
	./replace $path_of_tests/input$i.txt output.txt $te
	if cmp -s output.txt $path_of_tests/output$i.txt
	then
		echo "Passed"
	else
		echo "Wrong"
	fi
	i=$(($i + 1))
done


# TEST 
# no args
echo "Test $i" 
./replace > /dev/null

if [ "$?" == "2" ]
then 
	echo "Passed"
else
	echo "Wrong"
fi
i=$(($i + 1))


# TEST
# wrong input 
echo "Test $i"
./replace not_exist.txt output.txt some any > /dev/null
if [ "$?" == "1" ]
then
	echo "Passed"
else
	echo "Wrong"
fi
i=$(($i + 1))

# TEST
# "" "" 
echo "Test $i"
out=$(./replace tests/input$i.txt output$i.txt "" "")
if [ "$out" == "Search string is empty" ]
then
	echo "Passed"
else
	echo "Wrong" 
fi 
#i=$(($i + 1))

