#!/bin/sh
stty intr ^] 
QEMU=$(command -v qemu-system-arm)
TMP_DIR=qemu-rpi
RPI_KERNEL=kernel-qemu-4.4.34-jessie
RPI_KERNEL_FILE=$TMP_DIR/$RPI_KERNEL
PTB=versatile-pb.dtb
PTB_FILE=$TMP_DIR/$PTB
IMAGE_BASE=2017-04-10-raspbian-jessie
IMAGE=$IMAGE_BASE.zip
IMAGE_FILE=$TMP_DIR/$IMAGE
RPI_FS=$TMP_DIR/$IMAGE_BASE.img
 
#mkdir -p $TMP_DIR
 
#wget https://github.com/dhruvvyas90/qemu-rpi-kernel/blob/master/${RPI_KERNEL}?raw=true \
#        -O ${RPI_KERNEL_FILE}
 
#wget https://github.com/dhruvvyas90/qemu-rpi-kernel/raw/master/$PTB \
#        -O ${PTB_FILE}
 
#wget http://downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2019-09-30/$IMAGE \
#        -O ${IMAGE_FILE}
#unzip $IMAGE_FILE -d $TMP_DIR
 
$QEMU -kernel ${RPI_KERNEL_FILE} \
    -machine virt -cpu cortex-a7 -m 4000 -M \
    -no-reboot \
    -serial stdio -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw" \
    -drive "file=${RPI_FS},index=0,media=disk,format=raw" \
    -net user,hostfwd=tcp::5022-:22 -net nic
