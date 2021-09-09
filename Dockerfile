FROM ubuntu:18.04

# Install packages
RUN apt update

ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt install gawk wget git-core diffstat unzip texinfo gcc-multilib \
    build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
    xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
    pylint3 xterm rsync curl -y

# Locales
RUN apt-get install locales -y
COPY ./locale.gen /etc/locale.gen
RUN locale-gen

# Create user
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1001 ubuntu
USER ubuntu
WORKDIR /home/ubuntu

# Install repo bin 
RUN mkdir ~/bin
RUN curl https://storage.googleapis.com/git-repo-downloads/repo  > ~/bin/repo
RUN chmod a+x ~/bin/repo

# Config git
RUN git config --global user.name "Your Name"
RUN git config --global user.email "Your Email"

# Init sources
RUN mkdir imx-yocto-bsp
RUN cd imx-yocto-bsp && ../bin/repo init -u https://source.codeaurora.org/external/imx/imx-manifest \
    -b imx-linux-hardknott -m imx-5.10.35-2.0.0.xml

# Sync sources
RUN cd imx-yocto-bsp && ../bin/repo sync

# Source files
RUN mkdir -p build/conf
COPY src/bblayers.conf build/conf
COPY src/local.conf build/conf
COPY src/meta-maax-test imx-yocto-bsp/sources/meta-maax-test/

COPY container_entrypoint.sh start.sh
CMD [ "/bin/bash", "start.sh" ]