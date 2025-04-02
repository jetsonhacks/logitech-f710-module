# Logitech F710 Support on JetPack 6

JetPack 6 introduces changes to how kernel modules are handled on NVIDIA Jetson devices. In particular, support for the Logitech F710 game controller must now be **built into the kernel** rather than added as an external module.

---

## 🧠 Key Information

- The `LOGITECH_FF` kernel configuration option must be set to `Y` (built-in) rather than `M` (module).
- This change means the Logitech F710 cannot be enabled using a standalone `.ko` file as in JetPack 5 and earlier.
- This directory includes installation instructions and prebuilt kernel `Image` files for supported JetPack 6 releases (e.g. JetPack 6.2).

---

## 🚀 Supported Releases

- JetPack 6.2 and other supported releases will have a subdirectory here with:
  - Prebuilt kernel `Image`
  - Installation instructions

If your release is not listed, you can build your own image using the [`jetson-linux-build`](https://github.com/jetsonhacks/jetson-linux-build) tools.

---

## 🏗️ Building Your Own Image

1. Clone the tools from [jetsonhacks/jetson-linux-build](https://github.com/jetsonhacks/jetson-linux-build)
2. Download the kernel sources for your Jetson device.
3. Set the kernel configuration option:
   ```
   CONFIG_LOGITECH_FF=y
   ```
4. Build the kernel and generate a new `Image` file.

Once built, copy the resulting `Image` file to this directory and follow the installation steps below.

---

# Installing a Custom Linux Kernel on Jetson Devices

This guide walks you through installing a new Linux kernel on your NVIDIA Jetson device. You will replace the current kernel with the new one provided in this directory and configure the system to allow easy fallback to the original kernel in case something goes wrong.

---

## 🔧 Prerequisites

- You are in the directory containing a new `Image` file (the custom kernel).
- You have root/sudo access to your Jetson device.

---

## 📝 Step-by-Step Instructions

### 1. Backup the Original Kernel

Before installing the new kernel, it’s strongly recommended to keep a backup of the existing kernel:

```bash
sudo cp /boot/Image /boot/Image.backup
```

---

### 2. Install the New Kernel

Copy the new `Image` file (provided in this directory) to `/boot`:

```bash
sudo cp ./Image /boot/Image
```

> ⚠️ This replaces the existing kernel used by the system. Make sure you backed up the original!

---

### 3. Enable Fallback to Original Kernel

Edit the boot configuration file:

```bash
sudo gedit /boot/extlinux/extlinux.conf
```

Find the section near the bottom that looks like this:

```ini
# LABEL backup
#    MENU LABEL backup kernel
#    LINUX /boot/Image.backup
#    INITRD /boot/initrd
#    APPEND ${cbootargs}
```

Uncomment and replace the `APPEND` line with the one used in the `primary` kernel section.

⚠️ **WARNING:** Do not copy the example below directly — use your actual `APPEND` line from the current configuration!

Example:

```ini
LABEL backup
    MENU LABEL backup kernel
    LINUX /boot/Image.backup
    INITRD /boot/initrd
    APPEND ${cbootargs} root=/dev/mmcblk0p1 rw rootwait rootfstype=ext4 mminit_loglevel=4 console=ttyTCU0,115200 firmware_class.path=/etc/firmware fbcon=map:0 nospectre_bhb video=efifb:off console=tty0
```

---

### 4. Reboot

Now reboot your device to load the new kernel:

```bash
sudo reboot
```

---

## ✅ Optional: Verify Booted Kernel

After reboot, confirm the new kernel is running:

```bash
uname -r
```

---

## 🛡️ Troubleshooting

- If the system fails to boot, select the backup version from the NVIDIA splash screen.
- You can restore the original kernel by copying `Image.backup` back to `Image`:
  ```bash
  sudo cp /boot/Image.backup /boot/Image
  ```
(base) kangabook@Kangas-iMac Downloads % 
