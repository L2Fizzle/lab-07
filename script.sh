#!/bin/bash

for i in {1..4}; do
  rm -rf "Testcase${i}Diff"
  for file1 in Testcase$i/*.1.txt; do
    echo "Comparing $file1 with Testcase$i"/*.2.txt
    done
done
