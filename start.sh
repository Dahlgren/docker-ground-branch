#!/bin/bash
wine64 GroundBranchServer.exe MultiHome=$(hostname -I | awk '{print $1}')
