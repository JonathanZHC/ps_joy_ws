# ps_joy_ws

## Using Docker to Launch the Teleop Controller

This project supports running the PlayStation joystick teleoperation controller enveloped inside a ROS 2 Humble Docker environment. Follow the instructions below to get started:

### Expected Project Structure

Ensure that your project directory looks like this:

```
PlayStation-JoyInterface-ROS2/
├── src/
│   ├── p9n_bringup/
│   │   ├── launch/
│   │   │   └── joy.launch.py
│   │   ├── CMakeLists.txt
│   │   └── package.xml
│   └── ... (other packages)
├── Dockerfile
├── docker-compose.yml
└── entrypoint.sh
```

### 0. Clone This Repository (with Submodule)

This project uses [`PlayStation-JoyInterface-ROS2`](https://github.com/HarvestX/PlayStation-JoyInterface-ROS2) as a submodule.

Clone and initialize everything with:

```bash
git clone <your_repo_url>.git
cd ps_joy_ws
git submodule update --init --recursive
```

### 1. Build the Docker Image

From the project root:

```bash
docker compose build --no-cache
```

### 2. Launch the Teleop Node

Run the container:

```bash
docker compose up
```

> **Note:** Make sure your host system is connected to the PlayStation controller and has access to `/dev/input/` and `/dev/hidraw*` devices. These are automatically shared with the container using `privileged: true`.

