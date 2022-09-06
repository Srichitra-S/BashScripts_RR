#!/bin/bash

#bash script to run hdl localization

#Arguments when running the script : 
            # arg 1 : path to the bag file
            # arg 2 : ground truth topic


if [ -d "hdl_loc"]
then 
  echo "Directory hdl_loc exists"
else    
    mkdir -p hdl_loc
fi


xterm -hold -e "
cd /home/srichitras/hdl_ws/src/hdl_localization/rviz
rviz -d hdl_localization.rviz"  &

sleep 5

xterm -hold -e "
sleep 30
rosservice call /relocalize" &

sleep 5
#gnome-terminal -- 
xterm -hold -e "
rosparam set use_sim_time true
roslaunch hdl_localization hdl_loc_rr.launch"   &

sleep 5
#record bag file with gt and out topics
xterm -hold -e " 
cd hdl_loc
rosbag record -O hdl_loc_out.bag $2 /odom "  &


sleep 5
#gnome-terminal --
xterm -hold -e " 
rosbag play --clock  $1"
#rosservice call /relocalize" 
