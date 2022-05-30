shopt -s extglob
rm -rfv !(README.md|pull.sh|backup|diy)
shopt -u extglob

#临时备份本仓库readme
mv README.md back.md
#删除旧库
rm -rf ./backup
mkdir -p ./backup

#拉取储存库
echo '备份L大LEDE库'
svn export https://github.com/coolsnowwolf/lede/trunk/ ./backup/lede/coolsnowwolf_lede --force
svn export https://github.com/coolsnowwolf/packages/trunk/ ./backup/lede/coolsnowwolf_lede_packages --force
svn export https://github.com/coolsnowwolf/luci/trunk/ ./backup/lede/coolsnowwolf_lede_luci --force
svn export https://github.com/coolsnowwolf/routing/trunk/ ./backup/lede/coolsnowwolf_lede_routing --force
svn export https://github.com/openwrt/telephony/trunk/ ./backup/lede/coolsnowwolf_lede_telephony --force
echo '备份官方openwrt库'
svn export https://github.com/openwrt/openwrt/trunk/ ./backup/official/openwrt_official --force
svn export https://github.com/openwrt/packages/trunk/ ./backup/official/openwrt_official_packages --force
svn export https://github.com/openwrt/luci/trunk/ ./backup/official/openwrt_official_luci --force
svn export https://github.com/openwrt/routing/trunk/ ./backup/official/openwrt_official_routing --force
svn export https://github.com/openwrt/telephony/trunk/ ./backup/official/openwrt_official_telephony --force
cd ./backup
#zip -r -9 OpenWrt-official-$(date +%Y-%m-%d).zip official
#zip -r -9 OpenWrt-lede-$(date +%Y-%m-%d).zip lede
tar -cjvf OpenWrt-official-$(date +%Y-%m-%d).tar.bz2 official
split -a 2 -d -b 30m OpenWrt-official-$(date +%Y-%m-%d).tar.bz2 OpenWrt-official-$(date +%Y-%m-%d).tar.
tar -cjvf OpenWrt-lede-$(date +%Y-%m-%d).tar.bz2 lede
split -a 2 -d -b 30m OpenWrt-lede-$(date +%Y-%m-%d).tar.bz2  OpenWrt-lede-$(date +%Y-%m-%d).tar.
rm -rf  official
rm -rf  lede
rm -rf  OpenWrt-official-$(date +%Y-%m-%d).tar.bz2
rm -rf  OpenWrt-lede-$(date +%Y-%m-%d).tar.bz2
cd ..
echo '备份杂七杂八'
svn export https://github.com/breakings/OpenWrt/trunk/opt/kernel/ ./backup/breakings_kernel --force
svn export https://github.com/ophub/kernel/trunk/ ./backup/ophub_kernel --force
svn export https://github.com/unifreq/openwrt_packit/trunk/ ./backup/openwrt_packit --force
svn export https://github.com/ophub/flippy-openwrt-actions/trunk/ ./backup/flippy-openwrt-actions --force
svn export https://github.com/ophub/amlogic-s9xxx-openwrt/trunk/ ./backup/amlogic-s9xxx-openwrt --force
svn export https://github.com/ophub/amlogic-s9xxx-armbian/trunk/ ./backup/amlogic-s9xxx-armbian --force
svn export https://github.com/haiibo/OpenWrt/trunk/ ./backup/haiibo-OpenWrt --force
svn export https://github.com/ophub/luci-app-amlogic/trunk/ ./backup/ophub_luci-app-amlogic --force


#编译OP
svn export https://github.com/unifreq/openwrt_packit/trunk/ ./ --force
mv README.md READMEBACK.md

echo '安装Rename修改kernel名称'
echo '暂无空解决kernel名称带来的脚本问题，放弃修改，可自行摸索'
sudo apt install rename
# rename "s/flippy//" ./backup/breakings_kernel/*/*
# rename "s/flippy-//" ./backup/ophub_kernel/*/*/*/*

#修改部分文件
echo '修改部分脚本内容-----------------------------------------------------------------------------------------'
echo '删除密码'
#sed  -i '1012c   \       \ sed -e 's/root::/root::/' -i ./etc/shadow' ./public_funcs
#sed -i "s|\$1\$NA6OM0Li\$99nh752vw4oe7A\.gkm2xk1||g" ./public_funcs
sed -i "/\$1\$NA6OM0Li\$99nh752vw4oe7A\.gkm2xk1/d" ./public_funcs
sed -i "s| (<%=pcdata(ver.luciversion)%>)||g" ./files/index.htm
#sed -i 's?unameinfo.release?luci.sys.exec("cat /etc/flippy-openwrt-release | grep \\"KERNEL_VERSION=5\\" | cut -d \\"=\\" \\-f 2")?g' ./files/index.htm
sed -i "s| (<%=pcdata(ver.luciversion)%>)||g" ./files/index.htm.orig
#sed -i 's?unameinfo.release?luci.sys.exec("cat /etc/flippy-openwrt-release | grep \\"KERNEL_VERSION=5\\" | cut -d \\"=\\" \\-f 2")?g' ./files/index.htm.orig
sed -i 's?unameinfo.release?luci.sys.exec("cat /etc/flippy-openwrt-release | grep "KERNEL_VERSION=5" | cut -d "=" -f 2")?g' ./files/index.htm
sed -i 's?unameinfo.release?luci.sys.exec("cat /etc/flippy-openwrt-release | grep "KERNEL_VERSION=5" | cut -d "=" -f 2")?g' ./files/index.htm.orig
sed -i 's?unameinfo.release?luci.sys.exec("cat /etc/flippy-openwrt-release | grep "KERNEL_VERSION=5" | cut -d "=" -f 2")?g' ./files/luci-admin-status-index-html.patch
echo '修改KERNEL名称-----------------------------------------------------------------------------------------'
sed -i "/function write_release_info() {/i\var=\$\{KERNEL_VERSION}" ./public_funcs
sed -i "/function write_release_info() {/i\KERNEL_VERSIONS=\$\{var\/flippy-\/}" ./public_funcs
sed -i "/KERNEL_VERSION=\${KERNEL_VERSION}/d" ./public_funcs
#sed -i "/K510=\${K510}/i\K=\"\$\{KERNEL_VERSION}\"" ./public_funcs
#sed -i "/K510=\${K510}/i\KERNEL_VERSIONS=\"\$\{K\/flippy-\/}\"" ./public_funcs
sed -i "/K510=\${K510}/i\KERNEL_VERSION=\${KERNEL_VERSIONS}" ./public_funcs
sed -i "s|by lean & lienol||g" ./public_funcs
sed -i "/Kernel ${KERNEL_VERSION}/d" ./public_funcs
# sed -i "/\TODAY\=\$(date +%Y-%m-%d)/i\            K=\"\$\{KERNEL_VERSION}\"" ./public_funcs
# sed -i "/\TODAY\=\$(date +%Y-%m-%d)/i\            KERNEL_VERSIONS=\"\$\{K\/flippy-\/}\"" ./public_funcs
sed -i "/\TODAY\=\$(date +%Y-%m-%d)/i\            \echo \" Kernel \$\{KERNEL_VERSIONS\}\" \>\> etc\/banner" ./public_funcs

# function write_release_info() {

#https://www.csdn.net/tags/NtTakgxsNjc3NzctYmxvZwO0O0OO0O0O.html
##echo ${i/flippy-/}

echo '修改action仓库'
#sed  -i '26c SCRIPT_REPO_URL_VALUE="https://github.com/Tao173/Auto-Update-Router"' ./openwrt_flippy.sh
sed -i "s|https://github.com/unifreq/openwrt_packit|https://github.com/Tao173/Auto-Update-Router|g" ./openwrt_flippy.sh
#sed  -i '27c SCRIPT_REPO_BRANCH_VALUE="main"' ./openwrt_flippy.sh
echo '暂无空解决kernel名称带来的脚本问题，放弃修改，需要者可自行摸索'
#sed  -i '28c KERNEL_REPO_URL_VALUE="https://github.com/Tao173/Auto-Update-Router/tree/main/backup/kernel"' ./openwrt_flippy.sh
#sed  -i '55c WHOAMI_VALUE="Tao"' ./openwrt_flippy.sh


#恢复本仓库readme
mv back.md README.md

#diy文件拉取
cd ./files
rm -rf banner
svn export https://github.com/Tao173/Auto-Update-Router/trunk/diy/banner ./  --force
cd
