#!/bin/bash

sleep 10
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y redis-server nginx php
