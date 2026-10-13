#!/bin/bash

echo "========================================"
echo "       Jenkins Task-2 Build started successfully from GitHub webhook."
echo "========================================"

echo ""
echo "Application: Jenkins Task-2"
echo "Build Status: Started"

echo ""
echo "System Information"
echo "------------------"

echo "Hostname:"
hostname

echo ""
echo "Current User:"
whoami

echo ""
echo "Current Date and Time:"
date

echo ""
echo "Operating System:"
cat /etc/os-release | grep PRETTY_NAME

echo ""
echo "========================================"
echo "       Jenkins Task-2 Build Completed"
echo "========================================"
