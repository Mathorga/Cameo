#!/bin/bash

# Stop any running services.
sudo systemctl stop cameo.service
sudo systemctl stop cameo_hotspot.service

# Prevent the services from running on boot.
sudo systemctl disable cameo.service
sudo systemctl disable cameo_hotspot.service

# Make all necessary scripts executable.
sudo chmod +x ~/Cameo/snap_picture.sh
sudo chmod +x ~/Cameo/start_stream.sh
sudo chmod +x ~/Cameo/start_server.sh

# Remove any preexisting service files.
sudo rm /etc/systemd/system/cameo.service
sudo rm /etc/systemd/system/cameo_hotspot.service

# Copy the new files to the services location.
sudo cp ~/Cameo/cameo.service /etc/systemd/system/
sudo cp ~/Cameo/cameo_hotspot.service /etc/systemd/system/

# Make sure the service files are accessible.
sudo chmod 644 /etc/systemd/system/cameo.service
sudo chmod 644 /etc/systemd/system/cameo_hotspot.service

# Reload the systemd daemon to make sure the new services are noticed.
sudo systemctl daemon-reload

# Enable the new services to start at boot time.
sudo systemctl enable cameo.service
sudo systemctl enable cameo_hotspot.service

# Reboot the system.
sudo reboot