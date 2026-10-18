#公用函数
source $GITHUB_WORKSPACE/Scripts/functions.sh

sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

./scripts/feeds update -a
./scripts/feeds install -a

# homeproxy
rm -rf feeds/luci/applications/luci-app-homeproxy
merge_package main https://github.com/VIKINGYFY/packages package luci-app-homeproxy

# helloworld ssr-plus
rm -rf feeds/luci/applications/luci-app-ssr-plus
git clone --depth=1 https://github.com/stupidloud/helloworld package/helloworld

# 替换 hysteria / xray-core / v2ray-core
rm -rf feeds/packages/net/hysteria/*
rm -rf feeds/packages/net/xray-core/*
rm -rf feeds/packages/net/v2ray-core/*
cp -rf package/helloworld/hysteria/* feeds/packages/net/hysteria
cp -rf package/helloworld/xray-core/* feeds/packages/net/xray-core
cp -rf package/helloworld/v2ray-core/* feeds/packages/net/v2ray-core

# v2ray-geodata
rm -rf feeds/packages/net/v2ray-geodata
rm -rf package/helloworld/v2ray-geodata
git clone --depth=1 https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# sing-box
rm -rf feeds/packages/net/sing-box
merge_package main https://github.com/VIKINGYFY/packages  feeds/packages/net sing-box

cd package
$GITHUB_WORKSPACE/Scripts/Packages.sh
$GITHUB_WORKSPACE/Scripts/Handles.sh
