#!/usr/bin/env bash
# Test Traefik routing without relying on external DNS
SERVER_IP=${1:-"127.0.0.1"}
DOMAIN=${2:-"whoami.example.com"}

echo "Testing HTTP route: http://${DOMAIN} -> ${SERVER_IP}:80"
curl -v -H "Host: ${DOMAIN}" "http://${SERVER_IP}:80"

echo ""
echo "Testing HTTPS route: https://${DOMAIN} -> ${SERVER_IP}:443 (insecure test mode)"
curl -vk --resolve "${DOMAIN}:443:${SERVER_IP}" "https://${DOMAIN}:443"
