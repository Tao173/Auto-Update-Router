# Kernel Description

View Chinese description  |  [查看中文说明](README.cn.md)

Kernel repository that can be used to compile Armbian and OpenWrt system. Kernel files with the `flippy` flag in their names are files made by [unifreq](https://github.com/unifreq), The files named by other names are the files I compiled using his kernel source code.

- The kernel files stored in the [pub/stable](pub/stable) directory is a stable version, suitable for use in a formal production environment.
- The kernel files stored in the [pub/dev](pub/dev) directory is a development version, and third-party driver support and special modifications have been added for some specific devices, for development and testing use.

## Use the kernel

This kernel can be used in `Armbian` and `OpenWrt` systems. For example [amlogic-s9xxx-armbian](https://github.com/ophub/amlogic-s9xxx-armbian), [amlogic-s9xxx-openwrt](https://github.com/ophub/amlogic-s9xxx-openwrt), [flippy-openwrt-actions](https://github.com/ophub/flippy-openwrt-actions) and [unifreq/openwrt_packit](https://github.com/unifreq/openwrt_packit). It can be integrated when compiling firmware, or it can be installed into an existing system for use. For specific usage, please refer to [Kernel usage Instructions](https://github.com/ophub/amlogic-s9xxx-armbian/blob/main/compile-kernel/README.md#kernel-usage-instructions).

## Compile the kernel

- You can adjust the configuration of the kernel as needed, such as adding drivers and patches. It is also possible to compile personalized signature kernels with special meanings according to mood, such as `5.10.95-happy-new-year`, `5.10.96-beijing-winter-olympics`, `5.10.99-valentines-day` and so on.

- For the compilation method of the kernel, see [compile-kernel](https://github.com/ophub/amlogic-s9xxx-armbian/tree/main/compile-kernel), The template for kernel compilation using github.com's Actions can be found in [.github/workflows/compile-kernel.yml](https://github.com/ophub/amlogic-s9xxx-openwrt/blob/main/.github/workflows/compile-kernel.yml).

```yaml
- name: Compile the kernel for Amlogic s9xxx
  uses: ophub/amlogic-s9xxx-armbian@main
  with:
    build_target: kernel
    kernel_version: 5.15.25_5.10.100
    kernel_auto: true
    kernel_sign: -ophub
```

## Acknowledgments

- [unifreq/kernel](https://github.com/unifreq)
- [kernel.org](https://kernel.org)

## License

The kernel © OPHUB is licensed under [GPL-2.0](https://github.com/ophub/kernel/blob/main/LICENSE)
