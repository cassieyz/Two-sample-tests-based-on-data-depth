#!/bin/bash

# Define path
PATH_H="code_two_sample_null_H.R"
PATH_Q="code_two_sample_null_Q.R"

# null_H_5-9
for i in {5..9}
do
    for j in $(seq 100 100 600)
    do
        echo "Rscript $PATH_H $i $j $j"
        Rscript $PATH_H $i $j $j
    done
done

# null_H_5-9_different
for i in {5..9}
do
    for j in $(seq 100 100 600)
    do
        k=$((j / 2))
        echo "Rscript $PATH_H $i $j $k"
        Rscript $PATH_H $i $j $k
    done
done

# null_Q_5-9
for i in {5..9}
do
    for j in $(seq 100 100 600)
    do
        echo "Rscript $PATH_Q $i $j $j"
        Rscript $PATH_Q $i $j $j
    done
done

# null_Q_5-9_different
for i in {5..9}
do
    for j in $(seq 100 100 600)
    do
        k=$((j / 2))
        echo "Rscript $PATH_Q $i $j $k"
        Rscript $PATH_Q $i $j $k
    done
done



