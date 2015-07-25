#!/bin/sh

if [ -z "$VERSION" ]; then
	echo 'Version not set'
	echo 'Use one of prepare-[version].sh scripts'
	exit 1
fi

TARBALL=linux-${VERSION}.tar.xz
LINUXDIR=linux-${VERSION}
CONFIG=nsa310-kernel-${VERSION}/.config


echo "### GETTING KERNEL $VERSION ###"
if [ ! -f "$TARBALL" ]; then
	wget https://www.kernel.org/pub/linux/kernel/v3.x/${TARBALL}
fi
tar xJf $TARBALL
echo "DONE"
echo ""

cp cross-compile.sh $LINUXDIR
chmod +x $LINUXDIR/cross-compile.sh
cp -r nsa310-kernel-${VERSION}/. $LINUXDIR/

echo "### PATCHING KERNEL ###"
cd $LINUXDIR
for patch in *.patch; do
	patch -p1 < $patch
done
echo "DONE"
echo ""

echo "Now go to $LINUXDIR and run ./cross-compile.sh"
