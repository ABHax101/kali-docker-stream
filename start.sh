#!/bin/bash

# Start the VNC server
vncserver :1 -geometry 1280x800 -depth 24

# Start the noVNC server
/usr/local/bin/noVNC/utils/launch.sh --vnc localhost:5901 --listen 80 &

# Start Ratpoison
ratpoison &
