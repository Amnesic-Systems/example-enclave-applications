#!/bin/sh

nitriding -fqdn example.com &
echo "[sh] Started nitriding."

# Give nitriding a second to set up.
sleep 1

iperf3 -c 10.0.0.1 --verbose
