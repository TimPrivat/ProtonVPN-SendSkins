#!/bin/bash
protonvpn connect --cc $ProtonServer
sockd -N $SOCKD_WORKERS &
bash
