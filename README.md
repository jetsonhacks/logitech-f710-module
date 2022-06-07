# logitech-f710-module
Support for Logitech F710 game controller on NVIDIA Jetson Developer Kits.

Installs hid-logitech module with F710 game controller enabled. The module uses the local name (e.g. 4.9.253-tegra) which is the default image local name.

The repository also provides an outline script to generate the module from the kernel sources.

### install-module
To install the provided hid-logitech.ko module:
```
$ ./install-module.sh
```
After installation, cold boot the machine.

### build-module
This is the outline script to build the Logitech kernel module. The script expects kernel sources to be in /usr/src
```
./build-module.sh
```
This script is provided as an example on how to turn on the LOGITECH_FF module on and build the module.

After the build, the module will be in the source tree. For example, if the $KERNEL_RELEASE is kernel-4.9 : /usr/src/kernel/kernel-4.9/drivers/hid/hid-logitech.ko


## Testing

After installation, to test:

```
$ sudo apt-get install jstest-gtk
# By default, the logitech F710 is on /dev/input/js0
# for example:
$ jstest /dev/input/js0
```

## Notes
You will need to download the BSP source and expand it properly if you are going to build the module from source. There are convenience scripts in this account to help with that, depending on which Jetson you are using. 

###
### Release v1.4
* June, 2022
* Tag: l4t-32-7-2
* Add support for L4T 32.7.2

### Release v1.3
* April, 2022
* Tag: l4t-34-1-0
* JetPack 5.0 Developer Preview - L4T 34-1-0
* Initial support for Ubuntu 20.04
* Thanks to @hzheng40 for the update!

### Release v1.2
* September, 2021
* Tag: l4t-32-6-1
* JetPack 4.6 - L4T 32.6.1
* Installer now has message about location of where the module is being installed

### Release v1.1.1
* February, 2021
* Tag: l4t-32-5-1
* JetPack 4.5.1 - L4T 32.5.1

### Release v1.1
* February, 2021
* Tag: l4t-32-5-0
* JetPack 4.5 - L4T 32.5.0

### Release v1.0
* July 2020
* Tag: l4t-32-4-3
* JetPack 4.4 - L4T 32.4.3
* Initial Release
### Release v0.5
* July 2020
* JetPack 4.4 DP - L4T 32.4.2
* Developer Preview Release



