#!/bin/sh

VERSION=3.18.18
TARBALL=linux-${VERSION}.tar.xz
LINUXDIR=linux-${VERSION}
CONFIG=config-${VERSION}


echo "### GETTING KERNEL $VERSION ###"
if [ ! -f "$TARBALL" ]; then
	wget https://www.kernel.org/pub/linux/kernel/v3.x/${TARBALL}
fi
tar xJf $TARBALL
echo "DONE"

cp cross-compile.sh $LINUXDIR
chmod +x $LINUXDIR/cross-compile.sh
cp $CONFIG $LINUXDIR/.config
cp *-${VERSION}.patch $LINUXDIR

echo "### PATCHING KERNEL ###"
cd $LINUXDIR
for patch in *.patch; do
	patch -p1 < $patch
done
echo "DONE"

