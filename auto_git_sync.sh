#!/bin/bash

cd ~/my_project

while true; do
    sleep 300  # Every 5 minutes

    # Check if there are any changes
    if [[ -n $(git status --porcelain) ]]; then
        git add .
        git commit -m "Auto sync: $(date '+%Y-%m-%d %H:%M')"
        git push
        echo "✅ Auto synced to GitHub at $(date '+%H:%M')"
    fi
done
