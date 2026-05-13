FROM ros:jazzy-ros-base

ARG USERNAME=worms
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

# Runtime and build dependencies
RUN apt-get update && apt-get install -y \
    sudo \
    git \
    # ROS2 build
    build-essential \
    cmake \
    curl \
    wget \
    # Python
    python3-pip \
    python3-colcon-common-extensions \
    # Dependency management
    python3-vcstool \
    python3-rosdep \
    && rm -rf /var/lib/apt/lists/*

# Create the worms user
RUN if getent group ${USER_GID} > /dev/null; then \
        groupmod --new-name ${USERNAME} $(getent group ${USER_GID} | cut -d: -f1); \
    else \
        groupadd --gid ${USER_GID} ${USERNAME}; \
    fi \
    && if getent passwd ${USER_UID} > /dev/null; then \
        usermod --login ${USERNAME} --home /home/${USERNAME} --move-home \
            $(getent passwd ${USER_UID} | cut -d: -f1); \
    else \
        useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME}; \
    fi \
    && usermod -aG dialout,plugdev,video ${USERNAME} \
    && echo "${USERNAME} ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}

# Initialize rosdep
RUN rosdep init || true

# Automatically source ROS2 and the workspace in new terminals
RUN echo 'source /opt/ros/$ROS_DISTRO/setup.bash' >> /home/${USERNAME}/.bashrc \
    && echo 'if [ -f /home/worms-ws/install/setup.bash ]; then source /home/worms-ws/install/setup.bash; fi' >> /home/${USERNAME}/.bashrc \
    && chown ${USERNAME}:${USERNAME} /home/${USERNAME}/.bashrc

ENV SHELL=/bin/bash

USER ${USERNAME}
WORKDIR /home/worms-ws

CMD ["/bin/bash"]