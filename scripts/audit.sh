#!/bin/bash -e

echo "@@Installed packages:"

dpkg -l

echo "@LSB_DISTRIBUTION: $(lsb_release -si)"
echo "@LSB_RELEASE: $(lsb_release -sr)"
echo "@LSB_CODENAME: $(lsb_release -sc)"
