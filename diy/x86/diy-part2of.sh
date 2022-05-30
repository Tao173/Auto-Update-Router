#!/bin/bash
#===============================================
# Description: DIY script part 2
# File name: diy-part2.sh
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#===============================================
#git clone -b openwrt-21.02 https://github.com/openwrt/openwrt.git
# 修改默认IP
sed -i 's/192.168.1.1/10.10.10.10/g' package/base-files/files/bin/config_generate

#2.设置ttyd免帐号登录
sed -i 's/\/bin\/login/\/bin\/login -f root/' feeds/packages/utils/ttyd/files/ttyd.config
# Hostname
sed -i 's/OpenWrt/OpenWrt-Tao/g' package/base-files/files/bin/config_generate
# sed -i 's/UTC/UTC+8/g' package/base-files/files/bin/config_generate

# 移除重复软件包
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
rm -rf feeds/luci/applications/luci-app-adguardhome
rm -rf feeds/luci/applications/luci-app-netdata 
rm -rf feeds/luci/applications/luci-app-smartdns 
rm -rf feeds/luci/applications/luci-app-timecontrol 
rm -rf feeds/luci/applications/luci-app-usb-printer 
rm -rf feeds/luci/applications/luci-app-wrtbwmon

# 添加额外软件包
git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
git clone https://github.com/kongfl888/luci-app-adguardhome.git package/luci-app-adguardhome
git clone https://github.com/tty228/luci-app-serverchan.git package/luci-app-serverchan
git clone https://github.com/sirpdboy/luci-app-advanced package/luci-app-advanced
git clone https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff
git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
git clone https://github.com/siwind/luci-app-wolplus package/luci-app-wolplus
git clone https://github.com/zzsj0928/luci-app-pushbot package/luci-app-pushbot
git clone https://github.com/pymumu/luci-app-smartdns package/luci-app-smartdns
git clone https://github.com/TorBoxCode/luci-app-eqos package/luci-app-eqos
git clone https://github.com/big-tooth/luci-app-socatg package/luci-app-socatg
svn co https://github.com/destan19/OpenAppFilter/trunk/oaf package/oaf
svn co https://github.com/4IceG/luci-app-timecontrol/trunk/luci-app-timecontrol package/luci-app-timecontrol
svn co https://github.com/lisaac/luci-app-dockerman/trunk/applications/luci-app-dockerman package/luci-app-dockerman
svn co https://github.com/doushang/luci-app-shortcutmenu/trunk/luci-app-shortcutmenu package/luci-app-shortcutmenu
svn co https://github.com/Ermyderis/mqttcleint/trunk/mqttapp package/mqttapp
svn co https://github.com/Ermyderis/mqttcleint/trunk/luci_mqtt package/luci_mqtt
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
pushd package/luci-app-openclash/tools/po2lmo
make && sudo make install
popd

# 增加shortcutmenu默认配置
curl -fsSL  https://github.com/Tao173/Auto-Update-Router/blob/master/DIY/files/etc/config/shortcutmenu > ./package/luci-app-shortcutmenu/root/etc/config/shortcutmenu

# Themes
git clone https://github.com/thinktip/luci-theme-neobird package/luci-theme-neobird
git clone https://github.com/jerrykuku/luci-theme-argon.git  package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
git clone https://github.com/XXKDB/luci-theme-argon_armygreen package/luci-theme-argon_armygreen
git clone https://github.com/davinyue/luci-theme-edge package/luci-theme-edge
git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/luci-theme-infinityfreedom
git clone https://github.com/sirpdboy/luci-theme-opentopd package/luci-theme-opentopd
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
#sed -i "s| (<%=pcdata(ver.luciversion)%>)||g" feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm
sed -i "s| + (luciversion \|\| '')||g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js


# MosDNS
svn co https://github.com/QiuSimons/openwrt-mos/trunk/luci-app-mosdns package/luci-app-mosdns
svn co https://github.com/QiuSimons/openwrt-mos/trunk/v2ray-geodata package/v2ray-geodata
svn co https://github.com/QiuSimons/openwrt-mos/trunk/mosdns package/mosdns

# DDNS.to& # 易有云
svn co https://github.com/linkease/nas-packages-luci/trunk/luci/luci-app-ddnsto package/luci-app-ddnsto
svn co https://github.com/linkease/nas-packages/trunk/network/services/ddnsto package/ddnsto
svn co https://github.com/linkease/nas-packages-luci/trunk/luci/luci-app-linkease package/luci-app-linkease
svn co https://github.com/linkease/nas-packages/trunk/network/services/linkease package/linkease

# 实时监控& # 流量监控
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netdata package/luci-app-netdata
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/netdata package/netdata
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-wrtbwmon package/luci-app-wrtbwmon
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/wrtbwmon package/wrtbwmon


#airplay2&#打印机服务
svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-airplay2 package/luci-app-airplay2
svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-usb-printer package/luci-app-usb-printer

# MQTT服务
svn co https://github.com/Ermyderis/mqttcleint/trunk/mqttapp package/mqttapp
svn co https://github.com/Ermyderis/mqttcleint/trunk/luci_mqtt package/luci_mqtt

# 修改插件名字
# 修改插件名字
sed -i 's/"挂载 SMB 网络共享"/"挂载共享"/g' `grep "挂载 SMB 网络共享" -rl ./`
sed -i 's/"Argon 主题设置"/"Argon 设置"/g' `grep "Argon 主题设置" -rl ./`
sed -i 's/"USB 打印服务器"/"USB 打印"/g' `grep "USB 打印服务器" -rl ./`
sed -i 's/"BaiduPCS Web"/"百度网盘"/g' `grep "BaiduPCS Web" -rl ./`
sed -i 's/解锁网易云灰色歌曲/解锁灰色歌曲/g' `grep "解锁网易云灰色歌曲" -rl ./`
sed -i 's/网页快捷菜单/端口访问/g' `grep "网页快捷菜单" -rl ./`
sed -i 's/AirPlay 2 音频接收器/AirPlay/g' `grep "AirPlay 2 音频接收器" -rl ./`
sed -i 's/Argon 主题设置/主题设置/g' `grep "Argon 主题设置" -rl ./`
sed -i 's/Turbo ACC 网络加速/ACC网络加速/g' `grep "Turbo ACC 网络加速" -rl ./`

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
