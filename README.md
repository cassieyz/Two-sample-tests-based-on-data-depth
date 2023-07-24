# Welcome! :wave:

This repository contains a collection of R scripts designed to run seamlessly on macOS systems. This README provides a quick guide on how to navigate through the contents of the repository and run the scripts. For a more in-depth explanation of each R script and command, please refer to the Appendix at the end of this document.

## Repository Structure :open_file_folder:

The repository houses three types of files:

1. **.R**: The R source code files.
2. **.sh**: Bash scripts to execute corresponding .R files in a terminal.
3. **.rds**: Binary files in R for storing data. These files serve both as the output for some scripts and the input for others.

The .rds files are stored in three separate folders:

- `data_two_sample_null`: Contains simulated data under the null hypothesis.
- `data_two_sample_power`: Houses calculated power data.
- `plots_two_sample_power`: Stores all generated plots.

## Getting Started :rocket:

1. Install R on your macOS system.

2. Open Terminal and navigate to the directory containing the repository using the `cd` command.

3. Simulate data under the null hypothesis using the `script_null_all.sh` script:
    - Make the script executable: `chmod +x script_two_sample_null.sh`.
    - Run the script: `./script_two_sample_null.sh`.
    - The script will generate .rds files in the same directory.

4. Once all .rds files are generated, execute `script_power_all.sh` script to calculate power:
    - Make the script executable: `chmod +x script_two_sample_power.sh`.
    - Run the script: `./script_two_sample_power.sh`.
    - The script will use the .rds files as input and save the results in the same directory.

5. After all power data are collected, run `script_two_sample_plot.sh` to generate plots:
    - Make the script executable: `chmod +x script_two_sample_plot.sh`.
    - Run the script: `./script_two_sample_plot.sh`.

## Appendix: Command Details :bookmark_tabs:

- `script_two_sample_null.sh`:
    - Argument 1: Smallest sample size.
    - Argument 2: Increment by which the sample size increases.
    - Argument 3: Maximum sample size.

- `script_two_sample_power.sh` and `script_two_sample_plot.sh`:
    - Argument 1: Depth type (options: "Mahalanobis", "spatial", "projection", "Mahalanobis_Robust", "betaSkeleton", "L2", "qhpeeling", "simplicial", "zonoid").
    - Argument 2: Sample size (options: "same" for equal sample size (m: 100-1000, step 100; n=m), "different" for different sample size (m: 100-1000, step 100; n=m/2)).
    - Argument 3: Specifies the parameters (options: "variance" for same mean (0 and 0), different variance (I and 1.5I); "location" for different mean (0 and 0.35), same variance (I and I); "both" for different mean (0 and 0.3), different variance (I and 1.4I)).

## Thank You! :heart:

Your participation and interest are greatly appreciated!

NOTE: All .R and .sh files should be run in one folder with the same local path.
