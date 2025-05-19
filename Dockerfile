# Base image with Ubuntu 22.04
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV TZ=Etc/UTC

# Install dependencies
RUN apt-get update && apt-get install -y \
    git cmake build-essential clang libtool lsb-release \
    libxerces-c-dev libboost-all-dev libcoin80-dev \
    libspnav-dev libode-dev libeigen3-dev libqt5x11extras5-dev \
    libqt5svg5-dev libqt5opengl5-dev qttools5-dev qttools5-dev-tools \
    libpyside2-dev python3-pyside2.qtcore python3-pyside2.qtgui python3-pyside2.qtwidgets \
    libocct-data-exchange-dev libocct-visualization-dev \
    python3 python3-pip python3-dev python3-numpy python3-matplotlib \
    libgl1-mesa-glx libglu1-mesa libxrender1 libxext6 libx11-xcb1 \
    libxkbcommon-x11-0 x11-utils \
    && apt-get clean

# Optional: Install conda (comment out if not needed)
# RUN curl -fsSL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o miniconda.sh && \
#     bash miniconda.sh -b -p /opt/conda && \
#     rm miniconda.sh && \
#     /opt/conda/bin/conda clean -afy
# ENV PATH="/opt/conda/bin:$PATH"

# Set up working directories
RUN mkdir -p /mnt/source /mnt/build /mnt/files

# Default working directory
WORKDIR /mnt/build

# Entry point for GUI + shell
ENTRYPOINT ["/bin/bash"]
