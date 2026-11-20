
#!/usr/bin/env bash

set -e

apt-get update

apt-get install -y wget ca-certificates

wget -O /tmp/zabbix-release.deb \
https://repo.zabbix.com/zabbix/8.0/release/debian/pool/main/z/zabbix-release/zabbix-release_latest_8.0+debian13_all.deb

dpkg -i /tmp/zabbix-release.deb

apt-get update

apt-get install -y zabbix-agent2

systemctl enable zabbix-agent2

zabbix_agent2 -V

systemctl status zabbix-agent2 --no-pager || true
