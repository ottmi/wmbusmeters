#!/bin/bash

PROG="$1"

rm -rf testoutput
mkdir -p testoutput

TEST=testoutput

cat simulations/simulation_conversionsadded.txt | grep '^{' | grep 58234965 > $TEST/test_expected.txt
$PROG --addconversions=GJ,L --format=json simulations/simulation_conversionsadded.txt \
      Hettan   vario451    58234965 ""  > $TEST/test_output.txt

if [ "$?" == "0" ]
then
    cat $TEST/test_output.txt | sed 's/"timestamp":"....-..-..T..:..:..Z"/"timestamp":"1111-11-11T11:11:11Z"/' > $TEST/test_responses.txt
    diff $TEST/test_expected.txt $TEST/test_responses.txt
    if [ "$?" == "0" ]
    then
        echo Conversions OK
    else
        echo Failure. Conversions failed.
    fi
else
    echo Failure. Conversions failed.
    exit 1
fi