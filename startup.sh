#!/bin/bash
protonvpn connect $ProtonServer
sockd -N $SOCKD_WORKERS &
bash
