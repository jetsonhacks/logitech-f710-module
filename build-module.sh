#!/bin/bash
# build the hid-logitech.ko module with Logitech F710 support
# We need the kernel sources installed


cd /usr/src/kernel/kernel-4.9
sudo bash scripts/config --file .config \
	--set-val LOGITECH_FF y
sudo make modules_prepare
sudo make drivers/hid/hid-logitech.ko




