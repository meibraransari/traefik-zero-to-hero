#!/usr/bin/env python3
"""Inspect acme.json certificates without installing jq"""
import json, sys, os

acme_file = sys.argv[1] if len(sys.argv) > 1 else 'acme.json'

if not os.path.exists(acme_file):
    print(f'Error: {acme_file} not found.')
    sys.exit(1)

with open(acme_file, 'r', encoding='utf-8') as f:
    try:
        data = json.load(f)
    except Exception as e:
        print(f'Error reading JSON: {e}')
        sys.exit(1)

print('=== ACME Certificates Overview ===')
for resolver_name, res_data in data.items():
    print(f'Resolver: {resolver_name}')
    certs = res_data.get('Certificates', [])
    if not certs:
        print('  No certificates found.')
    for c in certs:
        domain_info = c.get('domain', {})
        main = domain_info.get('main', 'N/A')
        sans = domain_info.get('sans', [])
        print(f'  - Main Domain: {main}')
        if sans:
            print(f'    SANs: {sans}')
