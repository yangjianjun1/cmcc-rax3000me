#公用函数
source $GITHUB_WORKSPACE/Scripts/functions.sh

sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

./scripts/feeds update -a
./scripts/feeds install -a

cd package
$GITHUB_WORKSPACE/Scripts/Packages.sh
$GITHUB_WORKSPACE/Scripts/Handles.sh
