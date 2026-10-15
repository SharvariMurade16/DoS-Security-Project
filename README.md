Denial of Service Attacks and Security Mechanisms for Ensuring Availability
1. Project Description
This project demonstrates web-server request-rate limiting using Nginx and basic TCP traffic analysis using tcpdump. ApacheBench is used to measure HTTP request-handling performance under different local testing configurations.
The project was implemented on macOS using a local Nginx server running on port 8080.
2. Requirements
	•	macOS
	•	Homebrew
	•	Nginx
	•	ApacheBench (ab)
	•	tcpdump
	•	Terminal
3. Installation and Setup
Step 1: Install the required tools
Install Homebrew if it is not already installed: https://brew.sh/
Install Nginx:
brew install nginx
Start the Nginx service:
brew services start nginx
Check that Nginx is running:
curl -I http://127.0.0.1:8080/
Step 2: Configure Nginx
Open the Nginx configuration file:
open -e /opt/homebrew/etc/nginx/nginx.conf
Inside the http block, add:
limit_req_zone $binary_remote_addr zone=local_limit:10m rate=5r/s;
limit_conn_zone $binary_remote_addr zone=conn_limit:10m;
Inside the relevant server block, add:
limit_req zone=local_limit burst=5 nodelay;
limit_conn conn_limit 10;
Save the file, validate the configuration, and restart Nginx:
nginx -t
brew services restart nginx
Verify the configured rules:
nginx -T 2>&1 | grep -E 'limit_req_zone|limit_req |limit_conn_zone|limit_conn '
Step 3: Run HTTP benchmark tests
Baseline test:
ab -n 20 -c 1 http://127.0.0.1:8080/
Rate-limiting test:
ab -n 20 -c 1 -s 3 http://127.0.0.1:8080/
Higher-concurrency test:
ab -n 100 -c 15 -s 3 http://127.0.0.1:8080/
Run the baseline test with request-rate limiting disabled. Enable request-rate limiting for the protected test. The higher-concurrency test in the reported experiment was performed with rate limiting disabled.
Step 4: Capture TCP traffic
Run the following command in Terminal:
sudo tcpdump -i lo0 -c 10 tcp
While packet capture is running, open another Terminal window and execute:
curl -I --max-time 3 http://127.0.0.1:8080/
The capture displays TCP packet information for normal local communication.
4. Experimental Results
The recorded tests produced the following results:
Test configuration
Requests
Concurrency
Average time per request
HTTP 200 responses
HTTP 503 responses
Baseline
20
1
0.625 ms
20
0
Rate limiting enabled
20
1
0.492 ms
6
14
Higher-concurrency test
100
15
3.045 ms
100
0
The TCP packet capture recorded 10 packets, including the TCP handshake and an HTTP 200 OK response.
5. Limitations
The experiments were conducted on localhost and were not full-scale DoS or DDoS simulations. The connection-limit configuration was added but not independently benchmarked. SYN-flood protection mechanisms were studied theoretically; no SYN-flood attack was performed.
6. GitHub Repository
GitHub link: [https://github.com/SharvariMurade16/DoS-Security-Project]
The repository should contain the README, relevant source and configuration files, and any supporting screenshots or documentation required for execution.
7. Execution Files
The project uses Nginx configuration directives, ApacheBench commands, and tcpdump commands. These should be documented and included in the submitted project package where applicable.
No standalone executable was developed for this implementation.
