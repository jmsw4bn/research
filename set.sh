#!/bin/bash

# Disable ufw
sudo ufw disable

# Install curl (if not already installed)
sudo apt install -y curl

# Install V2Ray
sudo bash -c 'bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)'

# Install V2Ray geoip and geosite data
sudo bash -c 'bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-dat-release.sh)'

# Update V2Ray config
sudo touch /usr/local/etc/v2ray/config.json
sudo tee /usr/local/etc/v2ray/config.json > /dev/null <<EOF
{
    "inbounds": [
        {
            "port": 18181,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "e44554d9-91e6-4099-8b0b-c73a89e7305a"
                    }
                ]
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

# Restart and enable V2Ray
sudo systemctl restart v2ray
sudo systemctl enable v2ray

# Check V2Ray status
sudo systemctl status v2ray
