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
#sed -i 's/192.168.124.1/192.168.1.1/g' package/base-files/files/bin/config_generate

#2.设置ttyd免帐号登录
sed -i 's/\/bin\/login/\/bin\/login -f root/' feeds/packages/utils/ttyd/files/ttyd.config
# Hostname
sed -i 's/OpenWrt/OpenWrt-Tao/g' package/base-files/files/bin/config_generate
# sed -i 's/UTC/UTC+8/g' package/base-files/files/bin/config_generate

# 移除重复软件包
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/themes/luci-theme-netgear
rm -rf feeds/luci/applications/luci-app-dockerman
rm -rf feeds/luci/applications/luci-app-pushbot
rm -rf feeds/luci/applications/luci-app-qbittorrent
rm -rf feeds/luci/applications/luci-app-smartdns 

# 添加额外软件包
git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
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
svn co https://github.com/lisaac/luci-app-dockerman/trunk/applications/luci-app-dockerman package/luci-app-dockerman
svn co https://github.com/doushang/luci-app-shortcutmenu/trunk/luci-app-shortcutmenu package/luci-app-shortcutmenu
svn co https://github.com/Ermyderis/mqttcleint/trunk/mqttapp package/mqttapp
svn co https://github.com/Ermyderis/mqttcleint/trunk/luci_mqtt package/luci_mqtt
svn co https://github.com/op4packages/pdnsd-alt/trunk  package/pdnsd-alt

svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
pushd package/luci-app-openclash/tools/po2lmo
make && sudo make install
popd
# 花生壳内网穿透
svn export https://github.com/teasiu/dragino2/trunk/devices/common/diy/package/teasiu/luci-app-phtunnel package/new/luci-app-phtunnel
svn export https://github.com/teasiu/dragino2/trunk/devices/common/diy/package/teasiu/phtunnel package/new/phtunnel
svn export https://github.com/QiuSimons/dragino2-teasiu/trunk/package/teasiu/luci-app-oray package/new/luci-app-oray
# 增加shortcutmenu默认配置
#curl -fsSL  https://github.com/Tao173/Auto-Update-Router/blob/master/DIY/files/etc/config/shortcutmenu > ./package/luci-app-shortcutmenu/root/etc/config/shortcutmenu

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
#sed -i 's/可爱动漫主题/可爱动漫主题/g' package/luci-theme-argon_armygreen/luasrc/view/themes/argon_armygreen/footer.htm
#sed -i 's#https://github.com/openwrt/luci#https://jq.qq.com/?_wv=1027&k=s7GHUQ4e#g' package/luci-theme-argon_armygreen/luasrc/view/themes/argon_armygreen/footer.htm
#主机名右上角符号❤
#sed -i 's/❤/❤/g' package/luci-theme-argon_armygreen/luasrc/view/themes/argon_armygreen/header.htm
#修改主题多余版本信息
sed -i "s|Powered by <%= ver.luciname %>|Powered by <%= ver.luciname %><\/a> \/|g" package/luci-theme-argon/luasrc/view/themes/argon/footer.htm
sed -i "/(<%= ver.luciversion %>)<\/a> \//d" package/luci-theme-argon/luasrc/view/themes/argon/footer.htm
#去除固件版本小尾巴
#sed -i "s| (<%=pcdata(ver.luciversion)%>)||g" feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm
sed -i "s| + (luciversion \|\| '')||g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#状态系统增加个性信息
sed -i "s/exit 0//" package/default-settings/files/zzz-default-settings
echo "sed -i '/CPU usage/a\<tr><td width=\"33%\">关于</td><td><a class=\"author-website\" href=\"https://NOMCAI.ML\">菜菜的壁纸库</a>&nbsp;&nbsp;&nbsp;<a class=\"author-blog\" href=\"https://github.com/Joecaicai/Actions-OpenWrt-AX6.git\">固件编译源地址</a>&nbsp;&nbsp;&nbsp;<a class=\"author-blog\" href=\"https://space.bilibili.com/15669979\">菜菜的哔哩哔哩</a></td></tr>' /usr/lib/lua/luci/view/admin_status/index.htm" >> package/default-settings/files/zzz-default-settings
#简化版关于作者
echo "sed -i '/CPU usage/a\<tr><td width=\"33%\">关于</td><td><a class=\"author-website\" href=\"https://NOMCAI.ML\">菜菜的壁纸库</a></td></tr>' /usr/lib/lua/luci/view/admin_status/index.htm" >> package/default-settings/files/zzz-default-settings
echo "sed -i '/关于/a\<tr><td width=\"33%\">天气</td><td><iframe width=\"640\" scrolling=\"no\" height=\"75\" frameborder=\"0\" allowtransparency=\"true\" src=\"https://i.tianqi.com?c=code&id=39&color=%23FF7600&icon=3&num=2&site=12\"></iframe></td></tr>' /usr/lib/lua/luci/view/admin_status/index.htm" >> package/default-settings/files/zzz-default-settings
echo "sed -i '/天气/a\<tr><td width=\"33%\"> </td><td class=\"container\" style=\"height:200px;\"><canvas class=\"illo\" width=\"640\" height=\"640\" style=\"max-width: 200px; max-height: 200px; touch-action: none; width: 640px; height: 640px;\"></canvas></td></tr>' /usr/lib/lua/luci/view/admin_status/index.htm" >> package/default-settings/files/zzz-default-settings
#动漫旋转双人组
echo "echo '<script src=\"https://cdn.jsdelivr.net/gh/XXKDB/img_cdn/js/twopeople1.js\"></script>' >> /usr/lib/lua/luci/view/admin_status/index.htm" >> package/default-settings/files/zzz-default-settings
echo "echo '<script src=\"https://cdn.jsdelivr.net/gh/XXKDB/img_cdn/js/zdog.dist.js\"></script>' >> /usr/lib/lua/luci/view/admin_status/index.htm" >> package/default-settings/files/zzz-default-settings
echo "echo '<script id=\"rendered-js\" src=\"https://cdn.jsdelivr.net/gh/XXKDB/img_cdn/js/pen.js\"></script>' >> /usr/lib/lua/luci/view/admin_status/index.htm" >> package/default-settings/files/zzz-default-settings
echo "echo '<script src=\"https://cdn.jsdelivr.net/gh/XXKDB/img_cdn/js/ginkgo-leaf.js\"></script>' >> /usr/lib/lua/luci/view/footer.htm" >> package/default-settings/files/zzz-default-settings
#嵌入看板娘
echo "echo '<script src=\"https://cdn.jsdelivr.net/npm/jquery/dist/jquery.min.js\"></script>' >> /usr/lib/lua/luci/view/footer.htm" >> package/default-settings/files/zzz-default-settings
echo "echo '<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/font-awesome/css/font-awesome.min.css\"/>' >> /usr/lib/lua/luci/view/footer.htm" >> package/default-settings/files/zzz-default-settings
echo "echo '<script src=\"https://cdn.jsdelivr.net/gh/stevenjoezhang/live2d-widget/autoload.js\"></script>' >> /usr/lib/lua/luci/view/footer.htm" >> package/default-settings/files/zzz-default-settings
echo "" >> package/default-settings/files/zzz-default-settings
echo "" >> package/default-settings/files/zzz-default-settings
echo "exit 0" >> package/default-settings/files/zzz-default-settings

# MosDNS
svn co https://github.com/QiuSimons/openwrt-mos/trunk/luci-app-mosdns package/luci-app-mosdns
svn co https://github.com/QiuSimons/openwrt-mos/trunk/v2ray-geodata package/v2ray-geodata
svn co https://github.com/QiuSimons/openwrt-mos/trunk/mosdns package/mosdns

# DDNS.to & 易有云 & 添加istore
svn co https://github.com/linkease/nas-packages-luci/trunk/luci/luci-app-ddnsto package/luci-app-ddnsto
svn co https://github.com/linkease/nas-packages/trunk/network/services/ddnsto package/ddnsto
svn co https://github.com/linkease/nas-packages-luci/trunk/luci/luci-app-linkease package/luci-app-linkease
svn co https://github.com/linkease/nas-packages/trunk/network/services/linkease package/linkease
svn co https://github.com/linkease/istore-ui/trunk/app-store-ui package/app-store-ui
svn co https://github.com/linkease/istore/trunk/luci/luci-app-store package/luci-app-store
sed -i 's/luci-lib-ipkg/luci-base/g' package/luci-app-store/Makefile

#airplay2&#打印机服务
svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-airplay2 package/luci-app-airplay2

# MQTT服务
# svn co https://github.com/Ermyderis/mqttcleint/trunk/mqttapp package/mqttapp
# svn co https://github.com/Ermyderis/mqttcleint/trunk/luci_mqtt package/luci_mqtt
# svn co https://github.com/ErikasMasaitis/MQTT_subscriber/trunk/luci-app-mqtt-sub package/luci-app-mqtt-sub
# svn co https://github.com/ErikasMasaitis/MQTT_subscriber/trunk/mqtt_subscriber package/mqtt_subscriber
# git clone https://github.com/khongpt/luci-app-zigbee2mqtt.git package/luci-app-zigbee2mqtt
# git clone https://github.com/khongpt/luci-app-homeassistant.git package/luci-app-homeassistant

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
