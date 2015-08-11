# Need at least Ubuntu 14.10 to get libc_nano in libnewlib-arm-none-eabi
FROM ubuntu:15.04

# Install pre-requisites
RUN apt-get update && apt-get install -y build-essential gcc-arm-none-eabi binutils-arm-none-eabi libnewlib-arm-none-eabi libnewlib-dev openocd expect git doxygen vim zlib1g-dev libglib2.0-dev libtool libpixman-1-dev libsdl1.2-dev libsdl-image1.2-dev

# Build and install QEMU for Cortex-M
RUN git clone -b gnuarmeclipse-dev git://git.code.sf.net/p/gnuarmeclipse/qemu /tmp/gnuarmeclipse-qemu
RUN cd /tmp/gnuarmeclipse-qemu && ./configure --disable-werror --disable-gtk --disable-vnc --target-list="gnuarmeclipse-softmmu"
RUN cd /tmp/gnuarmeclipse-qemu && make && make install
RUN ldconfig
RUN rm -rf /tmp/gnuarmeclipse-qemu

# Clean up
RUN apt-get -y clean
