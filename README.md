# logitech-f710-module
Support for Logitech F710 game controller on Jetson.

Installs hid-logitech module with F710 game controller. The module uses the local name 4.9.140-tegra which is the default image local name.

Additionally provides outline script to generate module.

# WIP

After installation, to test:

```
$ sudo apt-get install jstest-gtk
$ jstest /dev/input/js0
```



