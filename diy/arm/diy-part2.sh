#!/bin/bash
#===============================================
# Description: DIY script part 2
# File name: diy-part2.sh
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#===============================================

# 修改默认IP
sed -i 's/192.168.1.1/192.168.124.38/g' package/base-files/files/bin/config_generate
sed -i 's/UTC/UTC+8/g' package/base-files/files/bin/config_generate

# Autocore
sed -i 's/TARGET_rockchip/TARGET_rockchip\|\|TARGET_armvirt/g' package/lean/autocore/Makefile

#2. 取消首次登陆WEB页密码 设置ttyd免帐号登录
#sed -i '/CYXluq4wUazHjmCDBCqXF/d' package/lean/default-settings/files/zzz-default-settings
sed -i 's/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/root::0:0:99999:7:::/' package/lean/default-settings/files/zzz-default-settings
sed -i 's/\/bin\/login/\/bin\/login -f root/' feeds/packages/utils/ttyd/files/ttyd.config

#7. 修改版本号
sed -i "s/OpenWrt /OpenWrt-Tao $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

# Hostname
sed -i 's/OpenWrt/OpenWrt-Tao/g' package/base-files/files/bin/config_generate

# Cpufreq
sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' feeds/luci/applications/luci-app-cpufreq/Makefile
sed -i 's/services/system/g' feeds/luci/applications/luci-app-cpufreq/luasrc/controller/cpufreq.lua

# 移除lede内重复软件包
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/admin/netdata
rm -rf package/lean/luci-app-dockerman
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/themes/luci-theme-netgear
rm -rf feeds/luci/applications/luci-app-netdata
rm -rf feeds/luci/applications/luci-app-wrtbwmon
rm -rf feeds/luci/applications/luci-app-dockerman
rm -rf feeds/luci/applications/luci-app-pushbot
rm -rf feeds/luci/applications/luci-app-qbittorrent
rm -rf feeds/luci/applications/luci-app-serverchan
# 添加额外软件包
git clone https://github.com/gSpotx2f/luci-app-cpu-status package/luci-app-cpu-status
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git  package/luci-app-jd-dailybonus
git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
# git clone https://github.com/jerrykuku/luci-app-vssr.git package/luci-app-vssr
git clone https://github.com/kongfl888/luci-app-adguardhome.git package/luci-app-adguardhome
git clone https://github.com/tty228/luci-app-serverchan.git package/luci-app-serverchan
git clone https://github.com/iwrt/luci-app-ikoolproxy.git package/luci-app-ikoolproxy
git clone https://github.com/sirpdboy/luci-app-advanced package/luci-app-advanced
git clone https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff
git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
git clone https://github.com/siwind/luci-app-wolplus package/luci-app-wolplus
git clone https://github.com/zzsj0928/luci-app-pushbot package/luci-app-pushbot
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-eqos package/luci-app-eqos
# svn co https://github.com/kiddin9/openwrt-bypass/trunk/luci-app-bypass package/luci-app-bypass
svn co https://github.com/lisaac/luci-app-dockerman/trunk/applications/luci-app-dockerman package/luci-app-dockerman
svn co https://github.com/kenzok8/jell/trunk/luci-app-smartdns package/luci-app-smartdns
svn co https://github.com/kenzok8/jell/luci-app-socat package/luci-app-socat
svn co https://github.com/doushang/luci-app-shortcutmenu/trunk/luci-app-shortcutmenu package/luci-app-shortcutmenu
# 增加shortcutmenu默认配置
# curl -fsSL  https://raw.githubusercontent.com/Tao173/Auto-Update-Router/main/diy/shortcutmenu > ./package/luci-app-shortcutmenu/root/etc/config/shortcutmenu
#phtunnel花生壳
svn co https://github.com/teasiu/dragino2/trunk/devices/common/diy/package/teasiu/luci-app-phtunnel package/luci-app-phtunnel
svn co https://github.com/teasiu/dragino2/trunk/devices/common/diy/package/teasiu/phtunnel package/phtunnel

# 科学上网插件依赖
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash

# 编译 po2lmo (如果有po2lmo可跳过)
pushd package/luci-app-openclash/tools/po2lmo
make && sudo make install
popd
# svn co https://github.com/xiaorouji/openwrt-passwall/trunk/brook package/brook
# svn co https://github.com/xiaorouji/openwrt-passwall/trunk/chinadns-ng package/chinadns-ng
# svn co https://github.com/xiaorouji/openwrt-passwall/trunk/tcping package/tcping
# svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-go package/trojan-go
# svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-plus package/trojan-plus
# svn co https://github.com/xiaorouji/openwrt-passwall/branches/luci/luci-app-passwall package/luci-app-passwall
# svn co https://github.com/xiaorouji/openwrt-passwall/trunk/xray-core package/xray-core
# svn co https://github.com/xiaorouji/openwrt-passwall/trunk/xray-plugin package/xray-plugin
# svn co https://github.com/xiaorouji/openwrt-passwall/trunk/ssocks package/ssocks
# svn co https://github.com/xiaorouji/openwrt-passwall/trunk/hysteria package/hysteria
# svn co https://github.com/xiaorouji/openwrt-passwall/trunk/v2ray-plugin package/v2ray-plugin
# svn co https://github.com/xiaorouji/openwrt-passwall/trunk/v2ray-core package/v2ray-core
# svn co https://github.com/fw876/helloworld/trunk/naiveproxy package/naiveproxy
# svn co https://github.com/fw876/helloworld/trunk/shadowsocks-rust package/shadowsocks-rust
# svn co https://github.com/fw876/helloworld/trunk/shadowsocksr-libev package/shadowsocksr-libev
# svn co https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus package/luci-app-ssr-plus
# svn co https://github.com/fw876/helloworld/trunk/simple-obfs package/simple-obfs
# svn co https://github.com/fw876/helloworld/trunk/trojan package/trojan

# Themes
git clone https://github.com/thinktip/luci-theme-neobird package/luci-theme-neobird
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
# git clone https://github.com/XXKDB/luci-theme-argon_armygreen package/luci-theme-argon_armygreen
# svn co https://github.com/kenzok8/jell/trunk/luci-theme-edge package/luci-theme-edge
# vn co https://github.com/kenzok78/small-package/trunk/luci-theme-argonne package/luci-theme-argonne
# svn co https://github.com/kenzok78/small-package/trunk/luci-app-argonne-config package/luci-app-argonne-config
# svn co https://github.com/rosywrt/luci-theme-rosy/trunk/luci-theme-rosy package/luci-theme-rosy
# svn co https://github.com/haiibo/packages/trunk/luci-theme-darkmatter package/luci-theme-darkmatter
# svn co https://github.com/haiibo/packages/trunk/luci-theme-atmaterial_new package/luci-theme-atmaterial_new
# svn co https://github.com/haiibo/packages/trunk/luci-theme-opentomcat package/luci-theme-opentomcat
# svn co https://github.com/haiibo/packages/trunk/luci-theme-netgear package/luci-theme-netgear
# git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/luci-theme-infinityfreedom
# git clone https://github.com/sirpdboy/luci-theme-opentopd package/luci-theme-opentopd
#修改主题多余版本信息
#登陆页面右下角技术支持  跳转网站“https://github.com/openwrt/luci”   名称“可爱动漫主题”
#sed -i 's/可爱动漫主题/可爱动漫主题/g' package/lean/luci-theme-argon_armygreen/luasrc/view/themes/argon_armygreen/footer.htm
#sed -i 's#https://github.com/openwrt/luci#https://jq.qq.com/?_wv=1027&k=s7GHUQ4e#g' package/lean/luci-theme-argon_armygreen/luasrc/view/themes/argon_armygreen/footer.htm
#主机名右上角符号❤
#sed -i 's/❤/❤/g' package/lean/luci-theme-argon_armygreen/luasrc/view/themes/argon_armygreen/header.htm
#修改主题多余版本信息
sed -i "s|Powered by <%= ver.luciname %>|Powered by <%= ver.luciname %><\/a> \/|g" package/luci-theme-argon/luasrc/view/themes/argon/footer.htm
sed -i "/(<%= ver.luciversion %>)<\/a> \//d" package/luci-theme-argon/luasrc/view/themes/argon/footer.htm
#去除固件版本小尾巴
sed -i "s| (<%=pcdata(ver.luciversion)%>)||g" feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm
#去除型号右侧肿瘤式跑分信息
sed -i "s|\ <%=luci.sys.exec(\"cat \/etc\/bench.log\") or \" \"%>||g" feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm
#修改web页面内核信息(菜鸟转义)
#sed -i 's?unameinfo.release?luci.sys.exec("cat /etc/flippy-openwrt-release | grep \\"KERNEL_VERSION=5\\" | cut -d \\"=\\" \\-f 2")?g' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm

# 晶晨宝盒软件固件升级地址
svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic package/luci-app-amlogic
sed -i "s|https.*/OpenWrt|https://github.com/Tao173/Auto-Update-Router|g" package/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|opt/kernel|https://github.com/Tao173/Auto-Update-Router/tree/master/backup/mykernel|g" package/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|ARMv8|ARMv8_PLUS|g" package/luci-app-amlogic/root/etc/config/amlogic

# MosDNS
svn co https://github.com/QiuSimons/openwrt-mos/trunk/luci-app-mosdns package/luci-app-mosdns
svn co https://github.com/QiuSimons/openwrt-mos/trunk/v2ray-geodata package/v2ray-geodata
svn co https://github.com/QiuSimons/openwrt-mos/trunk/mosdns package/mosdns

# DDNS.to
svn co https://github.com/linkease/nas-packages-luci/trunk/luci/luci-app-ddnsto package/luci-app-ddnsto
svn co https://github.com/linkease/nas-packages/trunk/network/services/ddnsto package/ddnsto

# 易有云
# svn co https://github.com/linkease/nas-packages-luci/trunk/luci/luci-app-linkease package/luci-app-linkease
# svn co https://github.com/linkease/nas-packages/trunk/network/services/linkease package/linkease

# 实时监控
svn co https://github.com/kenzok8/jell/trunk/luci-app-netdata package/luci-app-netdata
svn co https://github.com/kenzok8/jell/trunk/netdata package/netdata

# 流量监控
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-wrtbwmon package/luci-app-wrtbwmon
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/wrtbwmon package/wrtbwmon

# Gost
svn co https://github.com/kenzok8/jell/trunk/luci-app-gost package/luci-app-gost
svn co https://github.com/kenzok8/jell/trunk/gost package/gost

# Dockerman
svn co https://github.com/lisaac/luci-app-dockerman/trunk/applications/luci-app-dockerman package/luci-app-dockerman

# mqtt
# svn co https://github.com/kenzok8/jell/trunk/luci-app-mosquitto package/luci-app-mosquitto
svn co https://github.com/Ermyderis/mqttcleint/trunk/mqttapp package/mqttapp
svn co https://github.com/Ermyderis/mqttcleint/trunk/luci_mqtt package/luci_mqtt

# 修改makefile
# find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/include\ \.\.\/\.\.\/luci\.mk/include \$(TOPDIR)\/feeds\/luci\/luci\.mk/g' {}
# find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/include\ \.\.\/\.\.\/lang\/golang\/golang\-package\.mk/include \$(TOPDIR)\/feeds\/packages\/lang\/golang\/golang\-package\.mk/g' {}
# find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=\@GHREPO/PKG_SOURCE_URL:=https:\/\/github\.com/g' {}
# find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=\@GHCODELOAD/PKG_SOURCE_URL:=https:\/\/codeload\.github\.com/g' {}

# 调整V2ray服务到VPN菜单
sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-v2ray-server/luasrc/controller/*.lua
sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-v2ray-server/luasrc/model/cbi/v2ray_server/*.lua
sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-v2ray-server/luasrc/view/v2ray_server/*.htm

# 调整阿里云盘到存储菜单
#luci-app-aliyundrive-webdav
sed -i 's/services/nas/g' feeds/luci/applications/luci-app-aliyundrive-webdav/luasrc/controller/*.lua
sed -i 's/services/nas/g' feeds/luci/applications/luci-app-aliyundrive-webdav/luasrc/model/cbi/aliyundrive-webdav/*.lua
sed -i 's/services/nas/g' feeds/luci/applications/luci-app-aliyundrive-webdav/luasrc/view/aliyundrive-webdav/*.htm
#luci-app-aliyundrive-fuse
sed -i 's/services/nas/g' feeds/luci/applications/luci-app-aliyundrive-fuse/luasrc/controller/*.lua
sed -i 's/services/nas/g' feeds/luci/applications/luci-app-aliyundrive-fuse/luasrc/model/cbi/aliyundrive-fuse/*.lua
sed -i 's/services/nas/g' feeds/luci/applications/luci-app-aliyundrive-fuse/luasrc/view/aliyundrive-fuse/*.htm
# 调整位置
sed -i 's/status/services/g' package/luci-app-shortcutmenu/luasrc/controller/*.lua

# 修改插件名字
# 修改插件名字
sed -i 's/"挂载 SMB 网络共享"/"挂载共享"/g' `grep "挂载 SMB 网络共享" -rl ./`
sed -i 's/"Argon 主题设置"/"主题设置"/g' `grep "Argon 主题设置" -rl ./`
sed -i 's/"阿里云盘 FUSE"/"阿里云盘FUSE"/g' `grep "阿里云盘 FUSE" -rl ./`
sed -i 's/"阿里云盘 WebDAV"/"阿里云盘WebDAV"/g' `grep "阿里云盘 WebDAV" -rl ./`
sed -i 's/"USB 打印服务器"/"USB 打印"/g' `grep "USB 打印服务器" -rl ./`
sed -i 's/"BaiduPCS Web"/"百度网盘"/g' `grep "BaiduPCS Web" -rl ./`
sed -i 's/解锁网易云灰色歌曲/解锁灰色歌曲/g' `grep "解锁网易云灰色歌曲" -rl ./`
sed -i 's/网页快捷菜单/端口访问/g' `grep "网页快捷菜单" -rl ./`
sed -i 's/AirPlay 2 音频接收器/AirPlay/g' `grep "AirPlay 2 音频接收器" -rl ./`
sed -i 's/Argon 主题设置/主题设置/g' `grep "Argon 主题设置" -rl ./`
sed -i 's/Turbo ACC 网络加速/ACC网络加速/g' `grep "Turbo ACC 网络加速" -rl ./`

# dockerd去版本验证
# sed -i 's/^\s*$[(]call\sEnsureVendoredVersion/#&/' feeds/packages/utils/dockerd/Makefile

#8 预解压安装kodexplorer 提前下载，避免后期需要下载解压
# 会和 apcupsd 冲突
if grep -Eq '^CONFIG_PACKAGE_luci-app-kodexplorer=y' .config;then
    mkdir -p files/opt/kodexplorer
    # curl -s https://api.kodcloud.com/?app/version
    wget --no-check-certificate https://static.kodcloud.com/update/download/kodbox.$(
        curl -s  https://api.github.com/repos/kalcaddle/kodbox/releases/latest | jq -r .name | cut -d " " -f 1
    ).zip -O /tmp/kodbox.zip
    unzip -q  /tmp/kodbox.zip  -d files/opt/kodexplorer
    rm -f /tmp/kodbox.zip
fi

./scripts/feeds update -a
./scripts/feeds install -a
