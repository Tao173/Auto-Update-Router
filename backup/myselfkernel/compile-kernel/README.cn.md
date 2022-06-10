# 内核编译和使用说明

查看英文说明 | [View English description](README.md)

此内核可用于 `Armbian` 和 `OpenWrt` 系统。例如 [amlogic-s9xxx-armbian](https://github.com/ophub/amlogic-s9xxx-armbian), [amlogic-s9xxx-openwrt](https://github.com/ophub/amlogic-s9xxx-openwrt), [flippy-openwrt-actions](https://github.com/ophub/flippy-openwrt-actions) 和 [unifreq/openwrt_packit](https://github.com/unifreq/openwrt_packit) 等项目。可以在编译固件时集成，也可以安装到已有的系统中使用。

你可以根据需要对内核的配置进行调整，如添加驱动和补丁。也可以根据心情编译具有特殊意义的个性化签名内核，如 `5.10.95-happy-new-year`, `5.10.96-beijing-winter-olympics`, `5.10.99-valentines-day` 等等。

## 本地编译

- ### 在 Ubuntu 系统下运行

1. 克隆仓库到本地 `git clone --depth 1 https://github.com/ophub/amlogic-s9xxx-armbian.git`

2. 安装必要的软件包（脚本仅在 x86_64 Ubuntu-20.04/22.04 下做过测试）

```yaml
cd amlogic-s9xxx-armbian
sudo apt-get update -y
sudo apt-get full-upgrade -y
# For Ubuntu-22.04
sudo apt-get install -y $(cat compile-kernel/tools/script/ubuntu2204-build-armbian-depends)
```

3. 进入 `~/amlogic-s9xxx-armbian` 根目录，然后运行 `sudo ./recompile -d -k 5.10.100` 等指定参数命令即可编译内核。脚本会自动下载安装编译环境和内核源码并做好全部设置。打包好的内核文件保存在 `compile-kernel/output` 目录里。

- ### 在 Armbian 系统下运行

1. 更新本地编译环境和配置文件：`armbian-kernel -update`

2. 编译内核：运行 `armbian-kernel -d -k 5.10.100` 等指定参数命令即可编译内核。脚本会自动下载安装编译环境和内核源码并做好全部设置。打包好的内核文件保存在 `/opt/kernel/compile-kernel/output` 目录里。

- ### 本地编译参数说明

| 参数 | 含义 | 说明 |
| ---- | ---- | ---- |
| -d | Defaults | 使用默认配置 |
| -k | Kernel | 指定 kernel 名称，如 `-k 5.10.100` . 多个内核使用 `_` 进行连接，如 `-k 5.15.25_5.10.100` |
| -a | AutoKernel | 设置是否自动采用同系列最新版本内核。当为 `true` 时，将自动查找在 `-k` 中指定的内核如 `5.10.100` 的同系列是否有更新的版本，如有 `5.10.100` 之后的最新版本时，将自动更换为最新版。设置为 `false` 时将编译指定版本内核。默认值：`true` |
| -n | CustomName | 设置内核自定义签名。默认值为 `` ，生成的内核名称为 `5.10.100` 。设置自定义签名时请勿包含空格。 |
| -r | Repository | 指定编译内核的源代码仓库。默认为 `unifreq` 。可选择 `kernel.org` 的源码和 `github.com` 的内核源代码仓库。例如 `-r kernel.org` 或 `-r unifreq` 等。当使用 `github.com` 的内核源代码仓库时，可设置参数格式为 `owner/repo@branch` 三项组合，参数中的所有者名称 `owner` 为必选参数，内核源代码仓库名称 `/repo` 和 仓库的分支名称 `@branch` 为可选参数。当仅指定所有者名称 `owner` 参数时，将自动匹配所有者的名称为 `linux-5.x.y` 格式且分支为 `main` 的内核源代码仓库。如果仓库名称或分支名称不同，请使用组合方式指定，如 `owner@branch` 或 `owner/repo` 或 `owner/repo@branch` |

- `sudo ./recompile -d` : 使用默认配置编译内核。
- `sudo ./recompile -d -k 5.10.100` : 使用默认配置，并通过 `-k` 进行指定需要编译的内核版本，多个版本同时编译时使用 `_` 进行连接。
- `sudo ./recompile -d -k 5.10.100 -a true` : 使用默认配置，并通过 `-a` 参数设置编译内核时，是否自动升级到同系列最新内核。
- `sudo ./recompile -d -k 5.10.100 -n ` : 使用默认配置，并通过 `-n` 参数设置内核自定义签名。
- `sudo ./recompile -d -k 5.10.100 -r kernel.org` : 使用默认配置，并通过 `-r` 参数设置内核源代码仓库。
- `sudo ./recompile -d -k 5.15.25_5.10.100 -a true -n  -r kernel.org` : 使用默认配置，并通过多个参数进行设置。

💡提示：推荐使用 `unifreq` 的 [5.10](https://github.com/unifreq/linux-5.10.y), [5.15](https://github.com/unifreq/linux-5.15.y) 等仓库的内核源代码进行编译，他针对相关盒子添加了驱动和补丁。推荐使用 [tools/config](tools/config) 中的模板，已经根据相关盒子进行了预配置，可以在此基础上进行个性化定制。

## 使用 GitHub Actions 编译内核

1. 在 [Action](https://github.com/ophub/amlogic-s9xxx-armbian/actions) 页面里选择 ***`Compile the kernel`*** ，点击 ***`Run workflow`*** 按钮即可编译。

2. 详见使用模板 [compile-kernel.yml](../.github/workflows/compile-kernel.yml) 。代码如下:

```yaml
- name: Compile the kernel
  uses: Tao173/compile-kernel@main
  with:
    build_target: kernel
    kernel_version: 5.15.25_5.10.100
    kernel_auto: true
    kernel_sign: 
```

- ### GitHub Action 输入参数说明

相关参数与`本地编译命令`相对应，请参考上面的说明。

| 参数               | 默认值            | 说明                                                      |
|-------------------|------------------|-----------------------------------------------------------|
| build_target      | kernel           | 固定参数 `kernel`，设置编译目标为内核。                        |
| kernel_version    | 5.15.25_5.10.100 | 指定 kernel 名称，如 `5.10.100`。功能参考 `-k`                |
| kernel_auto       | true             | 设置是否自动采用同系列最新版本内核。默认值为 `true`。功能参考 `-a`  |
| kernel_sign       |            | 设置内核自定义签名。默认值为 ``。功能参考 `-n`             |
| kernel_repo       | unifreq          | 指定编译内核的源代码仓库。默认值为 `unifreq` 。功能参考 `-r`      |
| kernel_config     | 无               | 默认使用 [tools/config](tools/config) 目录下的配置模板。你可以设置编译内核的配置文件在你仓库中的存放目录，如 `kernel/config_path` 。在此目录下存放的各系列的内核配置模板都必须以 `config-5.x` 的名称为开头，例如编译 `5.10` 系列内核的模板可命名为以 `config-5.10` 开头的各种名字，如 `config-5.10` 、 `config-5.10.100` 或者 `config-5.10.100` 等，有多个以 `config-5.10` 为开头的文件时，将使用版本号最大的文件。 |

- ### GitHub Action 输出变量说明

上传到 `Releases` 需要给仓库添加 `GITHUB_TOKEN` 和 `GH_TOKEN` 并设置 `Workflow 读写权限`，详见[使用说明](../build-armbian/armbian-docs/README.cn.md#2-设置隐私变量-github_token)。

| 参数                               | 默认值                    | 说明                       |
|-----------------------------------|--------------------------|----------------------------|
| ${{ env.PACKAGED_OUTPUTTAGS }}    | 5.15.25_5.10.100         | 编译好的内核的名称            |
| ${{ env.PACKAGED_OUTPUTPATH }}    | compile-kernel/output    | 编译完成的内核所在文件夹的路径  |
| ${{ env.PACKAGED_OUTPUTDATE }}    | 04.13.1058               | 编译日期（月.日.时分）        |
| ${{ env.PACKAGED_STATUS }}        | success                  | 编译状态：success / failure  |

## 内核使用说明

此内核可用于 `Armbian` 和 `OpenWrt` 系统。以 ophub 的项目进行举例说明。

### 在 Armbian 系统中使用

下面分别对在编译 Armbian 固件时集成，以及如何安装到已有的系统中使用进行说明。

- #### 使用内核编译 Armbian 固件

编译 Armbian 固件支持本地化操作，也支持使用 github.com 的 Actions 在线编译。其中本地化编译时的使用方法详见：[本地化打包](../README.cn.md#本地化打包), 使用 Actions 在线编译的方法详见：[使用 GitHub Actions 进行编译](../README.cn.md#使用-github-actions-进行编译)

- #### 将内核安装到已有的 Armbian 系统

可以使用 `armbian-update` 命令将编译好的内核安装到已有的 Armbian 系统中，具体操作方法详见：[更新 Armbian 内核](../README.cn.md#更新-armbian-内核)


### 在 OpenWrt 系统中使用

下面分别对在 OpenWrt 系统中编译固件时集成和安装到已有的系统中使用进行介绍。

- #### 使用内核编译 OpenWrt 固件

编译 OpenWrt 固件支持本地化操作，也支持使用 github.com 的 Actions 在线编译。其中本地化编译时的使用方法详见：[本地化打包](https://github.com/ophub/amlogic-s9xxx-openwrt/blob/main/README.cn.md#本地化打包), 使用 Actions 在线编译的方法详见：[使用 Actions 进行编译](https://github.com/ophub/amlogic-s9xxx-openwrt/blob/main/README.cn.md#使用-github-actions-进行编译)

- #### 将内核安装到已有的 OpenWrt 系统

可以使用 [luci-app-amlogic](https://github.com/ophub/luci-app-amlogic/blob/main/README.cn.md) 插件将编译好的内核安装到已有的 OpenWrt 系统中，具体操作方法详见：[升级 OpenWrt](https://github.com/ophub/amlogic-s9xxx-openwrt/blob/main/README.cn.md#升级-openwrt)

