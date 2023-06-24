#!/bin/bash

response=$(curl -I -s "http://${testip}:5000/")
if [[ $response == *"HTTP/1.1 200 OK"* ]]; then
    echo "Curl check successful. App is running."
else
    echo "Curl check failed. App is not running or encountered an error."
fi
