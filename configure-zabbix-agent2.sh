
#!/usr/bin/env bash

set -e

CONFIG="/etc/zabbix/zabbix_agent2.conf"
HOSTNAME_FILE="/etc/zabbix/hostname"

if [ ! -f "$HOSTNAME_FILE" ]; then
    echo "SPOS-Dennis-Jiricka-$(cat /etc/machine-id | cut -c1-8)" > "$HOSTNAME_FILE"
fi

UNIQUE_HOSTNAME=$(cat "$HOSTNAME_FILE")

remove_config() {
    KEY="$1"
    sed -i -E "/^[[:space:]#]*${KEY}[[:space:]]*=/d" "$CONFIG"
}

remove_config "Hostname"
remove_config "Server"
remove_config "ServerActive"
remove_config "HostMetadata"

cat >> "$CONFIG" <<EOF

# Skolni konfigurace Zabbix Agent 2
Hostname=$UNIQUE_HOSTNAME
Server=enceladus.pfsense.cz
ServerActive=enceladus.pfsense.cz
HostMetadata=SPOS
EOF

systemctl enable zabbix-agent2
systemctl restart zabbix-agent2

echo "=== Zabbix konfigurace ==="
grep -E '^(Hostname|Server|ServerActive|HostMetadata)=' "$CONFIG"

systemctl status zabbix-agent2 --no-pager
