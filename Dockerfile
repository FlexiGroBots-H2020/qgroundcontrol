# Ubuntu Desktop LXDE image
FROM dorowu/ubuntu-desktop-lxde-vnc

# Install Gazebo
RUN sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
RUN wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
RUN curl -sSL http://get.gazebosim.org | sh

RUN /bin/bash -c "echo 'export HOME=/home/ubuntu' >> /root/.bashrc && source /root/.bashrc"

# Install git
RUN apt-get install -y git

# Creating px4 folder
RUN mkdir -p ~/px4_autopilot

# Creating .profile and .bash_profile files
RUN cd /home/ubuntu && touch .profile && touch .bash_profile

# Installing px4
RUN cd ~/px4_autopilot && git clone https://github.com/PX4/PX4-Autopilot.git --recursive && ./PX4-Autopilot/Tools/setup/ubuntu.sh

# Installing qgroundcontrol
#RUN sudo usermod -a -G dialout $USER
RUN sudo apt-get remove modemmanager -y
RUN sudo apt install gstreamer1.0-plugins-bad gstreamer1.0-libav gstreamer1.0-gl -y
RUN sudo apt-get install fuse -y

# Download 
RUN cd /home/ubuntu && mkdir qgroundcontrol && cd qgroundcontrol && wget https://d176tv9ibo4jno.cloudfront.net/latest/QGroundControl.AppImage

# Install image file
#RUN cd /home/ubuntu/qgroundcontrol && chmod +x ./QGroundControl.AppImage && ./QGroundControl.AppImage
