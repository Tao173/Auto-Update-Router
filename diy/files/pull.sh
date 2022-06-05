shopt -s extglob
rm -rfv !(README.md|pull.sh|backup|diy)
shopt -u extglob

#临时备份本仓库readme
mv README.md back.md
#删除旧库
rm -rf ./backup
mkdir -p ./backup

#拉取储存库
echo '备份杂七杂八'
svn export https://github.com/breakings/OpenWrt/trunk/opt/kernel/ ./backup/breakings_kernel --force
svn export https://github.com/ophub/kernel/trunk/ ./backup/ophub_kernel --force
# svn export https://github.com/unifreq/openwrt_packit/trunk/ ./backup/openwrt_packit --force
svn export https://github.com/ophub/flippy-openwrt-actions/trunk/ ./backup/flippy-openwrt-actions --force
svn export https://github.com/ophub/amlogic-s9xxx-openwrt/trunk/ ./backup/amlogic-s9xxx-openwrt --force
svn export https://github.com/ophub/amlogic-s9xxx-armbian/trunk/ ./backup/amlogic-s9xxx-armbian --force
svn export https://github.com/haiibo/OpenWrt/trunk/ ./backup/haiibo-OpenWrt --force
svn export https://github.com/ophub/luci-app-amlogic/trunk/ ./backup/ophub_luci-app-amlogic --force

#内核备份
svn export https://github.com/Tao173/compile-kernel/trunk/ ./backup/myselfkernel --force
#编译OP
svn export https://github.com/unifreq/openwrt_packit/trunk/ ./ --force
mv README.md READMEBACK.md

echo '安装Rename修改kernel名称'
echo '暂无空解决kernel名称带来的脚本问题，放弃修改，可自行摸索'
sudo apt install rename

#修改部分文件
echo '修改部分脚本内容-----------------------------------------------------------------------------------------'
echo '删除密码'
sed -i "/\$1\$NA6OM0Li\$99nh752vw4oe7A\.gkm2xk1/d" ./public_funcs
#sed -i "s| (<%=pcdata(ver.luciversion)%>)||g" ./files/index.htm
#sed -i "s| (<%=pcdata(ver.luciversion)%>)||g" ./files/index.htm.orig
#sed -i 's?unameinfo.release?luci.sys.exec("cat /etc/flippy-openwrt-release | grep "KERNEL_VERSION=5" | cut -d "=" -f 2")?g' ./files/index.htm
#sed -i 's?unameinfo.release?luci.sys.exec("cat /etc/flippy-openwrt-release | grep "KERNEL_VERSION=5" | cut -d "=" -f 2")?g' ./files/index.htm.orig
#sed -i 's?unameinfo.release?luci.sys.exec("cat /etc/flippy-openwrt-release | grep "KERNEL_VERSION=5" | cut -d "=" -f 2")?g' ./files/luci-admin-status-index-html.patch

sed -i "s|by lean & lienol||g" ./public_funcs

echo '修改action仓库'
#sed  -i '26c SCRIPT_REPO_URL_VALUE="https://github.com/Tao173/Auto-Update-Router"' ./openwrt_flippy.sh
sed -i "s|https://github.com/unifreq/openwrt_packit|https://github.com/Tao173/Auto-Update-Router|g" ./openwrt_flippy.sh
#sed  -i '27c SCRIPT_REPO_BRANCH_VALUE="main"' ./openwrt_flippy.sh
#echo '暂无空解决kernel名称带来的脚本问题，放弃修改，需要者可自行摸索'
#sed  -i '28c KERNEL_REPO_URL_VALUE="https://github.com/Tao173/Auto-Update-Router/tree/main/backup/kernel"' ./openwrt_flippy.sh
#sed  -i '55c WHOAMI_VALUE="Tao"' ./openwrt_flippy.sh


#恢复本仓库readme
mv back.md README.md

#diy文件拉取
cd ./files
rm -rf banner
svn export https://github.com/Tao173/Auto-Update-Router/trunk/diy/banner ./  --force
cd ..
