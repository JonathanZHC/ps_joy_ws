# ---------- 1 Base Image ----------
FROM ros:humble-ros-base  
# You can also use ros:foxy-ros-base

# ---------- 2 System Dependencies ----------
RUN apt-get update && apt-get install -y \
    git python3-colcon-common-extensions \
    ros-humble-joy ros-humble-teleop-twist-joy \
 && rm -rf /var/lib/apt/lists/*

# ---------- 3 Create Workspace ----------
ENV ROS_WS=/root/ps_joy_ws
RUN mkdir -p $ROS_WS/src
WORKDIR $ROS_WS
# Copy source code into the image (if you use docker build ., Docker will automatically copy the context)
COPY ./src ./src

# ---------- 4 Build ----------
RUN . /opt/ros/humble/setup.sh && \
    apt-get update && rosdep install -y --from-paths src --ignore-src && \
    colcon build --symlink-install

# ---------- 5 Runtime Environment ----------
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]