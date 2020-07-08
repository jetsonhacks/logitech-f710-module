This is a compiled driver for the Logitech F710 Gamepad for L4T 32.3.1.

JetPack 4.3

Place the driver in /lib/modules/4.9.140-tegra/kernel/drivers/hid

After rebooting, you should be able to use jstest (it's in the 'joystick' package) to make sure that the game pad works. Also, note that the joystick should be in 'D' mode. This stand for digital.

To compile the driver, set CONFIG-LOGITECH-FF=y in the kernel config and recompile the driver.
The driver will be hid-logitech.ko


