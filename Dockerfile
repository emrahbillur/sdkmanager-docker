# syntax=docker/dockerfile:1.3-labs
# vim:syntax=dockerfile
FROM ubuntu:focal-20220826

# Set this before `apt-get` so that it can be done non-interactively
ENV DEBIAN_FRONTEND noninteractive
ENV TZ America/New_York
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
ENV DISPLAY=:0

# KEEP PACKAGES SORTED ALPHABETICALY
# Do everything in one RUN command
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
  lsb-release \
  sudo \
  less \
  policykit-1 \
  kmod \
  lbzip2 \
  libusb-1.0-0 \ 
  apt-transport-https \
  build-essential \
  ca-certificates \
  curl \
  gnupg \
  python3 \
  python3-pip \
  python3-yaml \
  software-properties-common \
  apt-utils \
  debconf-utils \
  dialog \ 
  wget \
  cmake \
  autoconf \
  automake \
  bc \
  cmake \
  cpio \
  cppcheck \
  device-tree-compiler \
  elfutils \
  file \
  gawk \
  gdb \
  gettext \
  git \
  gosu \
  kmod \
  libasound2-dev \
  libavahi-compat-libdnssd-dev \
  libboost-all-dev \
  libclang-dev \
  libcurl4-openssl-dev \
  libncurses5-dev \
  libsndfile1-dev \
  libssl-dev \
  libtool \
  libwebsocketpp-dev \
  libwebsockets-dev \
  locales-all \
  lzop \
  ncurses-dev \
  openssh-client \
  pandoc \
  openssh-client \
  rsync \
  shellcheck \
  swig \
  time \
  unzip \
  uuid-dev \
  valgrind \
  vim \
  zip \
  zlib1g-dev
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections 
RUN echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections 
RUN apt-get update
RUN apt-get install -y resolvconf \
  iputils-ping \
  iproute2 \
  netcat-openbsd \
  iptables \
  dnsutils \
  network-manager \
  usbutils \
  net-tools \
  dosfstools \
  libgetopt-complete-perl \
  openssh-client \
  binutils \
  xxd \
  cpio \
  udev \
  whiptail \
  dmidecode 
RUN apt-get update
RUN apt-get install -y libcanberra-gtk-module \
  locales \
  libxshmfence1 \
  libnss3 \
  libatk-bridge2.0-0 \
  libdrm2 \
  libgtk-3-0 \
  libgbm1 \
  libx11-xcb1 \
  libcanberra-gtk3-module 
RUN apt-get update
RUN apt-get install -y ubuntu-desktop \  
  gnome-terminal \
  qemu-user-static \
  qemu-kvm \
  libvirt-daemon-system \
  libvirt-clients \
  bridge-utils
RUN update-binfmts --enable qemu-aarch64
COPY patch /
RUN /bin/bash -c 'dpkg -i /sdkmanager_*.deb || true' && rm /sdkmanager_*.deb &&\
    apt-get -qq update &&\
    apt-get -qq -f -y install &&\
    apt-get -qq -y install sudo libx11-xcb1 libxtst6 libnss3 libgtk-3-0 libxss1 lsb-release &&\
    rm -rf /var/lib/apt-get/lists &&\
    echo "root:root" | chpasswd &&\
    useradd nvidia && echo "nvidia:nvidia" | chpasswd && adduser nvidia sudo &&\
    echo "nvidia	ALL=(ALL) ALL" >> /etc/sudoers &&\
    mkdir -p /home/nvidia/Downloads/nvidia && chown -R nvidia:nvidia /home/nvidia

USER nvidia
WORKDIR /home/nvidia

#ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/bin/bash"]
