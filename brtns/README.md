# brtns
A script to change brightness using the hotkeys on your keyboard. We do this by writing a number to `/sys/class/backlight/intel_backlight/brightness`. It works in i3wm running on arch, and only with an Intel GPU. Minor modifications are required for nVidia or ATI. See [this link][arch_backlight] for more info.

Save the file `backlight.rules` as `/etc/udev/rules.d/backlight.rules`, to allow members of the `video` group to edit the above mentioned file. Next add yourself to the `video` group:

    $ sudo usermod -a -G video username

If the group does not exist, create it using 

    $ sudo addgroup video

Now save `.brtns.sh` as `/home/username/.brtns.sh`. Make it executable, and create a symlink:

    $ chmod +x ./.brtns.sh
    $ cd /usr/local/bin
    $ ln -s /home/username/.brtns.sh brtns

Now edit you i3 config file and add these lines to the end:

    # Control brightness using hotkeys
    bindsym XF86MonBrightnessUp "exec --no-startup-id brtns -u -i 15"
    bindsym XF86MonBrightnessDown "exec --no-startup-id brtns -d -i 15"


[arch_backlight]: https://wiki.archlinux.org/title/Backlight#ACPI