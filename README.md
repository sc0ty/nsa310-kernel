# Linux kernel for ZyXEL NSA310
Kernel config and patches for this NAS device.

 - **author:** Mike 'sc0ty' Szymaniak
 - **email:** sc0typl[at]gmail.com
 - **webpage:** http://sc0ty.pl

## PREPARATION
Just run script `./prepare-<version>.sh`. This will download, extract and patch Linux kernel.

## CROSS COMPILATION
Under Ubuntu:
```
sudo apt-get install fakeroot build-essential kexec-tools kernel-wedge gcc-arm-linux-gnueabihf gcc-arm-linux-gnueabihf libncurses5 libncurses5-dev libelf-dev asciidoc binutils-dev
sudo apt-get build-dep linux
```
You may want to change `CONFIG_CMDLINE` in config. I have to hardcode it - uBoot `cmdargs` is not working with this kernel for some reason.
```
cd linux-<version>
./cross-compile.sh
```
Your kernel and modules will be created in `out` directory.

I made it to blink sys led during boot. To stop blinking when system is ready, you should add
```
echo "default-on" > /sys/class/leds/nsa310:green:sys/trigger
```
to your `/etc/rc.local`.
You could edit default leds config in `arch/arm/boot/dts/kirkwood-nsa310.dtb`.
