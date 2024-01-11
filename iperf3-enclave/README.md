# iperf3-enclave

This directory contains an example application;
an Alpine Linux container that runs
[iperf3](https://iperf.fr)
to measure throughput between this enclave application
and an iperf3 instance running on the EC2 host.

To run this example,
set up
[nitriding-proxy](https://github.com/Amnesic-Systems/nitriding-proxy)
on your EC2 host and start an iperf3 server by running:

    iperf3 --verbose -s

Then, build and run this enclave image by running:

    make
