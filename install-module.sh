#!/bin/bash
# Copy the Logitech HID module with F710 support to the lib/module location
# Which device is root mounted?
# We want to check if this is on the eMMC/SD Card (boot device) or if the rootfs has been
# pivoted
ROOT_DEVICE=$( findmnt -n -o SOURCE --target / )
echo "Installing on root device: $ROOT_DEVICE"

# Read version
JETSON_L4T_STRING=$(dpkg-query --showformat='${Version}' --show nvidia-l4t-core)
# extract version - remove build info
JETSON_L4T_ARRAY=$(echo $JETSON_L4T_STRING | cut -f 1 -d '-')

# Load release and revision
JETSON_L4T_RELEASE=$(echo $JETSON_L4T_ARRAY | cut -f 1 -d '.')
JETSON_L4T_REVISION=${JETSON_L4T_ARRAY#"$JETSON_L4T_RELEASE."}
# Write Jetson description
JETSON_L4T="$JETSON_L4T_RELEASE-$JETSON_L4T_REVISION"

JETSON_L4T_FIXED=bin/l4t-${JETSON_L4T_ARRAY//./-}
echo "Installing from: $JETSON_L4T_FIXED"


INSTALL_DIRECTORY=/lib/modules/$(uname -r)/kernel/drivers/hid


cd $JETSON_L4T_FIXED


MAGICVERSION=$(modinfo hid-logitech.ko | grep vermagic)
MODULEVERSION=$(echo $MAGICVERSION | cut -d " " -f 2)
KERNELVERSION=$(uname -r)
if [ "$MODULEVERSION" == "$KERNELVERSION" ]
then
  echo "Kernel and Module Versions Match; Installing ..."
else 
  echo "The Kernel version does not match the Module Version"
  echo "Kernel Version: " $KERNELVERSION
  echo "Module Version: " $MODULEVERSION
  while true; do
  read -p "Would you still like to install the module? [Y/n] " response
  case $response in
    [Yy]* ) break ;;
    [Nn]* ) exit;;
    * ) echo "Please answer Yes or no. " ;;
  esac
  done
  # The module version did not match the kernel version, but user selected to install anyway
  echo "You may have to force the module to be inserted, i.e.  "
  echo "$ sudo modprobe -f hid-logitech"
fi

sudo cp -v hid-logitech.ko $INSTALL_DIRECTORY
sudo depmod -a
echo "Installed hid-logitech Module"
