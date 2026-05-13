FROM worms-ros-jazzy-runtime:latest

USER root
ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

# Extra development dependencies
RUN apt-get update && apt-get install -y \
    ros-jazzy-desktop \
    # C++ formatting
    clangd \
    clang-format \
    # Terminal tools
    gdb \
    rsync \
    less \
    nano \
    && rm -rf /var/lib/apt/lists/*

USER worms
WORKDIR /home/worms-ws

CMD ["/bin/bash"]