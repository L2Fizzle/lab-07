#!/bin/bash

overall_result=0


for i in {1..4}; do
    tc_passed=1
    difference_found=0

      for file1 in Testcase$i/*.1.txt; do

        base=$(basename "$file1" .1.txt)
        file2="Testcase$i/${base}.2.txt"


        #check if there is a difference between the two files
        if ! diff -u "$file1" "$file2" > /dev/null; then
            difference_found=1

            #check if difference file exists 
            if ! [ -f "Testcase${i}Diff/${base}Diff.txt" ]; then
                tc_passed=0

            else
                #check if the difference file is different
                expected=$(diff -u "$file1" "$file2")
                actual=$(cat "Testcase${i}Diff/${base}Diff.txt")

                if [ "$expected" != "$actual" ]; then
                    tc_passed=0
                fi
            fi
        else 

            #check if there is a difference file even though they are the same 
            if [ -f "Testcase${i}Diff/${base}Diff.txt" ]; then
                tc_passed=0
            fi
        fi
    done

    if  [ $difference_found -eq 0 ] && [ -d "Testcase${i}Diff" ]; then
        echo "Testcase${i}: FAIL"
        overall_result=1
    elif [ $tc_passed -eq 1 ]; then
            echo "Testcase${i}: PASS"

    else
            echo "Testcase${i}: FAIL"
            overall_result=1
    fi


done

exit $overall_result
