FROM ubuntu:22.04

LABEL author='Bilge Mirac Atici'

LABEL mail='miracatici@gmail.com'

ENV LANG="en_US.UTF-8"

ARG DEBIAN_FRONTEND="noninteractive"

RUN apt-get update && apt-get install locales -y && \
locale-gen en_US en_US.UTF-8 && \
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

RUN apt-get install curl software-properties-common -y && add-apt-repository universe

RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" |  tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
ros-humble-desktop ros-dev-tools \
ros-humble-gazebo-ros-pkgs \
ros-humble-xacro ros-humble-joint-state-publisher-gui \
ros-humble-gazebo-ros2-control ros-humble-ros2-control \
ros-humble-ros2-controllers

RUN useradd -ms /bin/bash ros-user && passwd -d ros-user && usermod -aG sudo ros-user

USER ros-user

RUN echo 'source /opt/ros/humble/setup.bash' >> /home/ros-user/.bashrc

CMD [“echo”,”Image created”] 
