#! /bin/bash
sleep 10
/home/pi/getLog/end_download/build/end_download serial:///dev/ttyACM0 > /home/pi/drone/logs/px4/test_px4.log 2>&1 &
sleep 10
sudo shutdown -h now 