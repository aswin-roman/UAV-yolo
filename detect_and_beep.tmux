#!/bin/bash

# Define the session name
SESSION_NAME="detect_and_beep"

# Start a new tmux session
tmux new-session -d -s $SESSION_NAME

#first pane commands
tmux send-keys -t $SESSION_NAME "conda activate ml_env" C-m
#tmux send-keys -t $SESSION_NAME "cd UAV/UAV-yolo" C-m
tmux send-keys -t $SESSION_NAME "python beep_on_detect.py runs/detect/exp/labels/" C-m

tmux split-window -h -t $SESSION_NAME

#second pane commands
tmux send-keys -t $SESSION_NAME "conda activate ml_env" C-m
#tmux send-keys -t $SESSION_NAME "cd UAV/UAV-yolo" C-m
tmux send-keys -t $SESSION_NAME "python detect.py --weights yolov5s.pt --source rtsp://192.168.1.100:554/MainStream --imgsz 1024 --exist-ok --nosave --save-txt" C-m

# Attach to the tmux session
tmux attach -t $SESSION_NAME

