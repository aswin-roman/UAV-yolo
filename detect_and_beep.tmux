#!/bin/bash

# Define the session name
SESSION_NAME="detect_and_beep"

# Start a new tmux session
tmux new-session -d -s $SESSION_NAME

#first pane commands
tmux send-keys -t $SESSION_NAME "conda activate ml_env" C-m
#tmux send-keys -t $SESSION_NAME "cd UAV/UAV-yolo" C-m
tmux send-keys -t $SESSION_NAME "python /home/duser/UAV/UAV-yolo/beep_on_detect.py --dir /home/duser/UAV/UAV-yolo/runs/detect/exp/labels/" C-m

tmux split-window -h -t $SESSION_NAME

#second pane commands
tmux send-keys -t $SESSION_NAME "conda activate ml_env" C-m
#tmux send-keys -t $SESSION_NAME "cd UAV/UAV-yolo" C-m
tmux send-keys -t $SESSION_NAME "python /home/duser/UAV/UAV-yolo/detect.py --weights /home/duser/UAV/1e83964874884a139d8374be7daac4ef.pt --source rtsp://192.168.1.100:554/MainStream --imgsz 1080 1920 --exist-ok --save-txt --conf-thres 0.85
" C-m

# Attach to the tmux session
tmux attach -t $SESSION_NAME

