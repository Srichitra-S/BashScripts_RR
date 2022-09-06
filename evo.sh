#!/usr/bin/env bash

"""

#To run evo tool, give the following arguments
#$1 - bag file
#$2 - input topic
#$3 - output topic

"""
mkdir -p results &
# For ape
evo_ape bag $1 $2 $3 -va --plot --plot_mode xy --save_results results/ape.zip  &

# For rpe
evo_rpe bag $1 $2 $3 -va --plot --plot_mode xy --save_results results/rpe.zip &

# For evo_traj
evo_traj bag $1 $3 --ref $2 -va -p --plot_mode=xy  &

sleep 50

# To plot and compare multiple results

evo_res results/ape.zip -p --save_table results/ape.csv &

evo_res results/rpe.zip -p --save_table results/rpe.csv
