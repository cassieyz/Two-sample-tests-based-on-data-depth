#!/bin/bash

# Refer to Appendix A of the README for a detailed explanation regarding the range of choices for each argument.

# Define path
RSCRIPT_PATH="code_two_sample_power.R"

# Type of Depth
TYPE_DEPTH=(5 6 7 8 9)

# Sample Size
SAMPLE_SIZE=("same" "different")


# Location shift
for type_depth in "${TYPE_DEPTH[@]}"
do
  for sample_size in "${SAMPLE_SIZE[@]}"
  do
    echo "Rscript $RSCRIPT_PATH $type_depth $sample_size location"
    Rscript $RSCRIPT_PATH $type_depth $sample_size location
  done
done


# Variance shift
for type_depth in "${TYPE_DEPTH[@]}"
do
  for sample_size in "${SAMPLE_SIZE[@]}"
  do
    echo "Rscript $RSCRIPT_PATH $type_depth $sample_size variance"
    Rscript $RSCRIPT_PATH $type_depth $sample_size variance
  done
done

# Both shift
for type_depth in "${TYPE_DEPTH[@]}"
do
  for sample_size in "${SAMPLE_SIZE[@]}"
  do
    echo "Rscript $RSCRIPT_PATH $type_depth $sample_size both"
    Rscript $RSCRIPT_PATH $type_depth $sample_size both
  done
done

