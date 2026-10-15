
#!/bin/bash

# Capture 10 TCP packets on the macOS loopback interface
echo "Starting TCP packet capture..."
echo "Run a curl request in another Terminal window."

sudo tcpdump -i lo0 -c 10 tcp
