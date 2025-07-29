# Stop any running instances of the service.
sudo systemctl stop cameo.service

# Prevent the service from running on boot.
sudo systemctl disable cameo.service

# Make all scripts executable.
sudo chmod +x start_stream.sh
sudo chmod +x start_server.sh

# Remove any preexisting service file.
sudo rm /etc/systemd/system/cameo.service

# Copy the new file to the services location.
sudo cp ~/Cameo/cameo.service /etc/systemd/system/

# Make sure the service file is accessible.
sudo chmod 644 /etc/systemd/system/cameo.service

# Reload the systemd daemon to make sure the new service is noticed.
sudo systemctl daemon-reload

# Start the new server.
sudo systemctl start cameo.server