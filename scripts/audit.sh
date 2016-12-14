#!/bin/bash

echo "@@Installed packages:"

dpkg -l

echo "@LSB_RELEASE: $(lsb_release -sr)"
echo "@LSB_CODENAME: $(lsb_release -sc)"
