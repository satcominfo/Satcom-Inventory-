#!/bin/bash

# 1. GATHER DATA: Extract current disk utilization percentage
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
THRESHOLD=80

echo "=========================================================="
echo "🎬 MEDIA STARTUP INFRASTRUCTURE: STORAGE MONITOR ACTIVE"
echo "Current System Disk Utilization: $DISK_USAGE%"
echo "=========================================================="

# 2. CONDITIONAL LOGIC & ACTION
if [ "$DISK_USAGE" -gt "$THRESHOLD" ]; then
    echo "🚨 [CRITICAL ALERT] Media storage has breached the safe limit!"
    echo "Current usage is at $DISK_USAGE%. Video rendering may fail."
    
    # Save alert to an external log file
    echo "[$(date)] CRITICAL: Storage space is low ($DISK_USAGE%)." >> ~/storage_emergency.log
    echo "👉 Emergency log generated successfully at ~/storage_emergency.log"
else
    echo "✅ Storage capacity is healthy. Video editors can safely save projects."
fi
echo "=========================================================="
