+++
title = "systemd-boot-friend"
template = "software.html"
insert_anchor_links = "right"
[extra]
software_category = "System Administration"
package_site_url = "https://packages.aosc.io/packages/systemd-boot-friend"
+++

`systemd-boot-friend` is a software which helps you to use [systemd-boot](https://www.freedesktop.org/software/systemd/man/systemd-boot.html).

**NOTICE**: If you have installed `systemd-boot-friend`,
it will automatically install all existing kernels
and generate entries for you once the kernel is upgraded or modified.

# Initialize
In order to use `systemd-boot-friend`, you have two options:
1. Automatically initialize `systemd-boot` and install the newest kernel via `systemd-boot-friend init`
2. Manually install and set-up `systemd-boot` yourself, then utilize `systemd-boot-friend` just to update the kernels.

For the automatic method, simply mount your *ESP partition* to `/efi` and run `systemd-boot-friend init`.
If everything goes well, you should have a working `systemd-boot` installation.

For the manual method, you can take a look at [systemd-boot - ArchWiki](https://wiki.archlinux.org/index.php/systemd-boot),
which describes how to set up systemd-boot by yourself. Then after you have decided on where to mount your *ESP partition*,
you can fill in the mountpoint at `/etc/systemd-boot-friend.conf` and create the `$ESP_MOUNTPOINT/EFI/systemd-boot-friend/` folder,
and then you are good to go.

# Usage
`systemd-boot-friend` has several subcommands.

    init              Initialize systemd-boot-friend
    list              List all available kernels
    install           Install the kernel specified
    list-installed    List all installed kernels
    remove            Remove the kernel specified
    update            Install all kernels and update boot entries

- `init`
  Initializes systemd-boot, installs the newest kernel and generate its boot entry.

- `list`
  Lists all available kernels.

- `install`
  Installs a specific kernel or the newest kernel if no argument is given.
  The argument can either be the number corresponding to the kernel in `systemd-boot-friend list` or the kernel's name (e.g. `5.12.0-aosc-main`).

- `list-installed`
  Lists all kernels installed in systemd-boot.

- `remove`
  Similar to `install`. Removes a specific kernel or choose a kernel if no argument is given.
  The argument can either be the number corresponding to the kernel in `systemd-boot-friend list-installed` or the kernel's name (e.g. `5.12.0-aosc-main`).

- `update`
  Removes all installed kernels, reinstalls all available kernels and re-generates the corresponding boot entries.

# Configuration
`/etc/systemd-boot-friend.conf` is systemd-boot-friend's configuration file.

- `VMLINUZ`
  vmlinuz filename format, you can find the filename at /boot usually.
  The format is `vmlinuz-{VERSION}-{LOCALVERSION}` by default, this is for filenames like `vmlinuz-5.12.0-aosc-main` or `vmlinuz-5.12.0-200.fc34.x86_64`.

- `INITRD`
  Similar to `VMLINUZ`, this is initrd filename format.
  The format is `initramfs-{VERSION}-{LOCALVERSION}.img` by default, this is for filenames like `initramfs-5.12.0-aosc-main.img` or `initramfs-5.12.0-200.fc34.x86_64`.
  For Debian users, modify it to `initrd.img-{VERSION}-{LOCALVERSION}`.

- `DISTRO`
  Distribution name, this is used in boot entry titles.
  Default value is `AOSC OS`.

- `ESP_MOUNTPOINT`
  ESP mountpoint, modify it to your mountpoint before using `systemd-boot-friend`.
  Default value is `/efi`.

- `BOOTARG`
  This is the kernel parameters used in boot process. In a boot entry file, this is filled after `options` key.
  Usually, you have to specify the root partition and make it rw here. For example `root=/dev/sda2 rw`.
  See https://systemd.io/BOOT_LOADER_SPECIFICATION/ and https://wiki.archlinux.org/title/systemd-boot#Adding_loaders for further information.

# Technical details
`systemd-boot-friend` will install kernels to `/EFI/systemd-boot-friend/` directory in your ESP partition,
and generate boot entries naming with `$VERSION-$LOCALVERSION.conf` (e.g. `5.12.0-aosc-main.conf` or `5.12.0-200.fc34.x86_64.conf`)
