#!/bin/bash
# RAX3000M MT7981 radio0=2.4G radio1=5G
WIFI24_SSID="${{ github.event.inputs.WIFI24_SSID }}"
WIFI24_PASS="${{ github.event.inputs.WIFI24_PASS }}"
WIFI5G_SSID="${{ github.event.inputs.WIFI5G_SSID }}"
WIFI5G_PASS="${{ github.event.inputs.WIFI5G_PASS }}"

# 写入 /etc/config/wireless
cat > files/etc/config/wireless << EOF
config wifi-device 'radio0'
        option type 'mac80211'
        option path 'platform/soc/18000000.wifi'
        option band '2g'
        option htmode 'HT20'
        option country 'CN'

config wifi-iface 'wifinet0'
        option device 'radio0'
        option mode 'ap'
        option network 'lan'
        option ssid '$WIFI24_SSID'
        option encryption 'psk2'
        option key '$WIFI24_PASS'

config wifi-device 'radio1'
        option type 'mac80211'
        option path 'platform/soc/18000000.wifi+1'
        option band '5g'
        option htmode 'HE80'
        option country 'CN'

config wifi-iface 'wifinet1'
        option device 'radio1'
        option mode 'ap'
        option network 'lan'
        option ssid '$WIFI5G_SSID'
        option encryption 'psk2'
        option key '$WIFI5G_PASS'
EOF
