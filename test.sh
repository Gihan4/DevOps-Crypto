#!/bin/bash

testip=$(aws ec2 describe-instances --region eu-central-1 --filters 'Name=tag:Environment,Values=Test' --query 'Reservations[].Instances[].PublicIpAddress' --output text | tr -d '[:space:]')

response=$(curl -I -s "http://${testip}:5000/")
if [[ $response == *"HTTP/1.1 200 OK"* ]]; then
    echo "Curl check successful. App is running."
else
    echo "Curl check failed. App is not running or encountered an error."
fi
