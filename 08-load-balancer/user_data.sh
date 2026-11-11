#!/bin/bash
set -euxo pipefail

dnf update -y
dnf install -y httpd jq

systemctl enable --now httpd

TOKEN=$(curl -fsS -X PUT \
  "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

INSTANCE_ID=$(curl -fsS \
  -H "X-aws-ec2-metadata-token: $TOKEN" \
  "http://169.254.169.254/latest/meta-data/instance-id")

PRIVATE_IP=$(curl -fsS \
  -H "X-aws-ec2-metadata-token: $TOKEN" \
  "http://169.254.169.254/latest/meta-data/local-ipv4")

cat > /var/www/html/index.html <<EOF
<html>
  <body>
    <h1>Hello from EC2!</h1>
    <p>Instance ID: $INSTANCE_ID</p>
    <p>Private IP: $PRIVATE_IP</p>
  </body>
</html>
EOF
