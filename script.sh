#!/bin/bash

#loops through each test case file
for i in {1..4}; do

#remove any existing diff files for this test case
  rm -rf "Testcase${i}Diff"

  for file1 in Testcase$i/*.1.txt; do

    base=$(basename "$file1" .1.txt)
    file2="Testcase$i/${base}.2.txt"

    #check if there is a difference between the two files and output the result
    if ! diff -u "$file1" "$file2" > /dev/null; then

    #check if the diff directory exists, if not create it
      if ! [ -d "Testcase${i}Diff" ]; then
        mkdir "Testcase${i}Diff"

      fi

      #output the differences to a diff file in the diff directory
      diff -u "$file1" "$file2" > "Testcase${i}Diff/${base}Diff.txt"
    fi
    done
done
