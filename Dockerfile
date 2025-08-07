# ---------- 1 基础镜像 ----------
FROM ros:humble-ros-base  
# 也可以换成 ros:foxy-ros-base

# ---------- 2 系统依赖 ----------
RUN apt-get update && apt-get install -y \
    git python3-colcon-common-extensions \
    ros-humble-joy ros-humble-teleop-twist-joy \
 && rm -rf /var/lib/apt/lists/*
 
# ---------- 3 创建工作空间 ----------
ENV ROS_WS=/root/ps_joy_ws
RUN mkdir -p $ROS_WS/src
WORKDIR $ROS_WS 
# 把源代码放进镜像（如果你用 docker build .，Docker 会自动把上下文拷进去）
COPY ./src ./src

# ---------- 4 编译 ----------
RUN . /opt/ros/humble/setup.sh && \
    apt-get update && rosdep install -y --from-paths src --ignore-src && \
    colcon build --symlink-install

# ---------- 5 运行环境 ----------
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]