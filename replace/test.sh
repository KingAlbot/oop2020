#!/bin/bash

i=1
testsPath=tests
tests=(             
	'1231234 000'   # TEST 1
	'ma mama'       # TEST 2
	'"" empty'      # TEST 3
	'fox dog'       # TEST 4
	'Ipsum STRING'  # TEST 5
        ''              # TEST 6
        '"hel" "hello"' # TEST 7
        '"" ""'         # TEST 8
	)        

g++ replace.cpp -o replace
for te in "${tests[@]}"
do
	echo "Test $i:"
	./replace $testsPath/input$i.txt output.txt $te > output.txt
        code="$?"
        if  [ $code -eq 0 ]
        then
	        if cmp -s output.txt $testsPath/output$i.txt
        	then
	        	echo "Passed"
	        else
		        echo "Wrong output"
	        fi
        else
                echo "Program finished with code $code"
                if cmp -s output.txt $testsPats/output$i.txt
                then
                        echo "Correct error text"
                else
                        echo "Invalid error text"
                fi
        fi
done
