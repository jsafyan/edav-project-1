#!/bin/sh
# This script creates a plots folder and runs all of the scripts.
# To execute this script, put all of the script and the .xlsx survey
# in the root directory with this run.sh bash script. Then execute the
# following from the terminal:
# > chmod u+x run.sh
# and then run:
# > ./run.sh
mkdir data
mkdir plots
Rscript clean.R
Rscript gender_plots.R
Rscript pca.R
Rscript DataChecks.R
Rscript DS_NonDS.R
Rscript RvsOthers.R
Rscript toolsClustering.R

python heatmap.py
python experience.py
