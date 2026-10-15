
#!/bin/bash

# HTTP benchmark tests for the local Nginx server
URL="http://127.0.0.1:8080/"

echo "=== Baseline test ==="
echo "Run this with request-rate limiting disabled."
ab -n 20 -c 1 -s 3 "$URL"

echo ""
echo "=== Rate-limiting test ==="
echo "Enable the Nginx rate-limiting rule before running this test."
ab -n 20 -c 1 -s 3 "$URL"

echo ""
echo "=== Higher-concurrency test ==="
echo "Run this with request-rate limiting disabled."
ab -n 100 -c 15 -s 3 "$URL"
