#!/bin/sh

CROSS_COMPILE=arm-linux-gnueabi- 
ARCH=arm
LOADADDR=0x8000
TARGETDIR=out


mkdir -p $TARGETDIR
mkdir -p $TARGETDIR/boot


echo "### BUILDING KERNEL ###"
make -j6 zImage dtbs
echo "DONE"

echo "### BUILDING KERNEL IMAGE ###"
cat arch/arm/boot/dts/kirkwood-nsa310.dtb >> arch/arm/boot/zImage
make uImage
cp arch/arm/boot/uImage $TARGETDIR/boot
echo "DONE"

echo "### BUILDING MODULES ###"
make -j6 modules
make modules_install INSTALL_MOD_PATH=$TARGETDIR
echo "DONE"

