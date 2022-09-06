#!/bin/bash

#bash script to run hdl_graph_slam

#Arguments : 
        # arg 1 : path to the bag file
        # arg 2 : ground truth topic


if [ -d "hdl_map"]
then 
  echo "Directory hdl_map exists"
else    
    mkdir -p hdl_map/map
fi

#mkdir -p hdl_map/map


#run slam
xterm -hold -e " 
rosparam set use_sim_time true
roslaunch hdl_graph_slam hdl_rr.launch"  &

sleep 5

#open rviz
xterm -hold -e "
source ~/hdl_ws/devel/setup.bash
roscd hdl_graph_slam/rviz 
exec rviz -d hdl_graph_slam.rviz"  &

sleep 5 #wait for 5 secs



#record bag file with gt and out topics
xterm -hold -e " 
cd hdl_map
rosbag record -O hdl_slam_out.bag $2 /odom "  &

sleep 5

#ground truth from tf data
#xterm -hold -e "
#rosparam set use_sim_time true 
#rosrun tf_to_odometry tf_to_odometry" &

#sleep 5



# play bag file
xterm -hold -e " 
rosbag play --clock  $1 --topic = /rr_os_cloud_node/points_filtered /rr_os_cloud_node/imu /odom " 
echo "bag play done"  &

#"rosnode kill /my_bag" &

sleep 10
# save map
xterm -hold -e "rosparam set use_sim_time false
cd hdl_map
echo $(pwd)
rosservice call /hdl_graph_slam/save_map false 0.05 '$(pwd)/hdl_map/map/map.pcd'"
