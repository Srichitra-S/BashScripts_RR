## Guidelines to use the bash script

# Requirements

1. [Install xterm](https://installati.one/ubuntu/21.04/xterm/)
2. See that the arguments are given correctly whe running the bash scripts. 
3. This script was tested on ROS noetic.


# evo.sh

`$ source /path_to_evo.sh --path to bag file  --ground truth topic --output topic of SLAM/Localization as required`

# hdl_slam.sh

`$ source /path_to_slam.sh --path to the bag file  --ground truth topic `

### Points to note

1. Name of the launch file in bash script is  `hdl_rr.launch`. See that your launch file is named the same or you make the necessary changes in the bash script.
2. Output topic of HDL_GRAPH_SLAM is `/odom` and has been hardcoded in the bash script. So, if the bag file has a topic of the same name, see that is renamed. 
3. `rr_localization_msgs` package need to built for hdl slam and localization.
 

# hdl_slam.sh for bags where gt has to be taken from tf

1. Use `tf_to_odometry`  package to extract ground truth from tf topic.
2. Re-record bag files with this gt and use slam.sh



# hdl_loc.sh

`$ source /path_to_loc.sh --path to the bag file --ground truth topic `

### Points to note

1. Name of the launch file in bash script is  `hdl_loc_rr.launch`. See that your launch file is named the same or you make the necessary changes in the bash script.
2. Provide initial pose either directly in the launch file or using 2D pose estimate on RViZ.
3. Also, specify the path to the pcd file in the launch file
