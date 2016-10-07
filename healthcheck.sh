#!/bin/bash

ps aux | grep "[d]ocker-entrypoint" > /dev/null
if [ $? -eq 0 ]; then
    echo "Scheduler is running."
else 
    echo "Scheduler is not running."
    exit 1
fi

