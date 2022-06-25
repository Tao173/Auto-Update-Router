# 内核说明

查看英文说明 | [View English description](README.md)

可用于编译 Armbian 和 OpenWrt 系统的内核文件存储库。内核文件名称里有 `flippy` 标志的是 [unifreq](https://github.com/unifreq) 制作的文件，以其他名称命名的是我使用他的内核源码编译的文件。

- 在 [pub/stable](pub/stable) 目录下存储的内核文件是稳定版，适合在正式生产环境中使用。
- 在 [pub/dev](pub/dev) 目录下存储的内核文件是开发版，为一些特定盒子添加了第三方的驱动支持和特殊修改，供开发和测试使用。

## 使用内核

这些内核可用于 `Armbian` 和 `OpenWrt` 系统。例如 [amlogic-s9xxx-armbian](https://github.com/ophub/amlogic-s9xxx-armbian), [amlogic-s9xxx-openwrt](https://github.com/ophub/amlogic-s9xxx-openwrt), [flippy-openwrt-actions](https://github.com/ophub/flippy-openwrt-actions) 和 [unifreq/openwrt_packit](https://github.com/unifreq/openwrt_packit) 等项目。可以在编译固件时集成，也可以安装到已有的系统中使用。具体使用方法详见[内核使用说明](https://github.com/ophub/amlogic-s9xxx-armbian/blob/main/compile-kernel/README.cn.md#内核使用说明)。

## 编译内核

- 你可以根据需要对内核的配置进行调整，如添加驱动和补丁。也可以根据心情编译具有特殊意义的个性化签名内核，如 `5.10.95-happy-new-year`, `5.10.96-beijing-winter-olympics`, `5.10.99-valentines-day` 等等。

- 内核的编译方法详见 [compile-kernel](https://github.com/ophub/amlogic-s9xxx-armbian/tree/main/compile-kernel), 使用 github.com 的 Actions 进行内核编译的模板可参考 [.github/workflows/compile-kernel.yml](https://github.com/ophub/amlogic-s9xxx-openwrt/blob/main/.github/workflows/compile-kernel.yml)。

```yaml
- name: Compile the kernel for Amlogic s9xxx
  uses: ophub/amlogic-s9xxx-armbian@main
  with:
    build_target: kernel
    kernel_version: 5.10.125_5.15.50
    kernel_auto: true
    kernel_sign: -ophub
```

## 鸣谢

- [unifreq/kernel](https://github.com/unifreq)
- [kernel.org](https://kernel.org)

## License

The kernel © OPHUB is licensed under [GPL-2.0](https://github.com/ophub/kernel/blob/main/LICENSE)
