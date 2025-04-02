# logitech-f710-module

Support for the Logitech F710 game controller on NVIDIA Jetson Developer Kits. This enables the Logitech F710 to operate in Direct Input mode (selector D on the back of the controller).

> **JetPack 6 Note:**  
> Starting with JetPack 6, the Logitech F710 support must be built directly into the kernel (`LOGITECH_FF` must be enabled as a built-in feature). This means the module (`hid-logitech.ko`) cannot be installed as a separate external module as with previous releases.  
> 
> A new `JetPack6` directory in this repository contains instructions for installing the full kernel `Image` with built-in F710 support where available.

---

## Overview

This repository provides:

- Prebuilt `hid-logitech.ko` modules for earlier JetPack versions
- Scripts to build the module from kernel sources
- JetPack 6 support via full kernel replacement

---

## install-module (JetPack 5 and earlier)

To install the provided `hid-logitech.ko` module:

```bash
$ ./install-module.sh
```

After installation, **cold boot** the Jetson device.

---

## build-module (JetPack 5 and earlier)

This script outlines how to build the Logitech kernel module. It expects kernel sources in `/usr/src`.

```bash
# For Kernel 5.x (Ubuntu 20+), install dependencies:
$ sudo apt install libssl-dev

# Then build:
$ ./build-module.sh
```

This script enables the `LOGITECH_FF` option and builds the module.

After the build, the module will be located in the source tree.  
Example for kernel 4.9:  
`/usr/src/kernel/kernel-4.9/drivers/hid/hid-logitech.ko`

---

## JetPack 6 Instructions

As of JetPack 6, external modules are no longer supported for this use case.  
You must install the kernel `Image` with Logitech support built-in.

Please see the `jetpack-6/` directory in this repository for full instructions.

---

## Testing

After installation, test the controller with:

```bash
$ sudo apt-get install jstest-gtk
# The Logitech F710 typically appears at /dev/input/js0
$ jstest /dev/input/js0
```

---

## Notes

To build from source, you’ll need to download and extract the BSP source for your Jetson model. This repository contains convenience scripts to help with setup.

---

## Release Notes

### Release v1.6
* April, 2025
* Added support for JetPack 6
* Kernel must be rebuilt with built-in Logitech support (`LOGITECH_FF`)
* See `jetpack-6/` directory for new installation process

### Release v1.5
* December, 2022
* Tag: l4t-35.1.0
* Add support for L4T 32.7.3, L4T 35.1.0

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
* Installer now shows installation path

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
