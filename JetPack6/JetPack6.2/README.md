# Install for JetPack 6.2
A Linux kernel Image is provided here for the Jetson Orin Nano/Super. The version of the kernel is 5.15.148-tegra. You can check your version with:
```bash
uname -r
```
This is an unmodified, default kernel Image. If you have modified your kernel Image, do not use this method. This method sets the kernel feature:
```
LOGITECH_FF = Y
```
If you have modified your kernel, you may want to incorporate the flag to support the Logitech F710 in Direct mode.


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

This allows you to boot into the original kernel if needed.

---

### 2. Install the New Kernel

Copy the new `Image` file (provided in this directory) to `/boot`:

```bash
sudo cp ./Image /boot/Image
```

> ⚠️ This replaces the existing kernel used by the system. Make sure you backed up the original!

---

### 3. Enable Fallback to Original Kernel

The `extlinux.conf` file controls boot options. To enable booting the original (backup) kernel, you need to **uncomment and modify** the backup section in the configuration file.

Edit the file:

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

Uncomment it **and replace** the `APPEND` line with the one used in the `primary` kernel section (the one currently in use). **<I>WARNING: DO NOT USE THE EXAMPLE DIRECTLY, USE THE ACTUAL APPEND LINE IN YOUR extlinux.conf FILE.</I>** Here's an example:

```ini
LABEL backup
    MENU LABEL backup kernel
    LINUX /boot/Image.backup
    INITRD /boot/initrd
    APPEND ${cbootargs} root=/dev/mmcblk0p1 rw rootwait rootfstype=ext4 mminit_loglevel=4 console=ttyTCU0,115200 firmware_class.path=/etc/firmware fbcon=map:0 nospectre_bhb video=efifb:off console=tty0
```

This ensures that the backup kernel boots with the same parameters as the primary one.

---

### 4. Reboot

Now reboot your device to load the new kernel:

```bash
sudo reboot
```

---

## ✅ Optional: Verify Booted Kernel

After reboot, check that the new kernel is in use:

```bash
uname -r
```

If anything goes wrong, you can select the **"backup kernel"** from the boot menu or revert to the backup manually using recovery tools.

---

## 🛡️ Troubleshooting

- If the system fails to boot, select the backup version in the NVIDIA splash screen.
- You can also restore the original kernel by copying `Image.backup` back to `Image`:

```bash
sudo cp /boot/Image.backup /boot/Image
```
