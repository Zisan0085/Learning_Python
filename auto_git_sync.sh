#!/bin/bash

cd ~/my_project

# Install inotifywait if not present
if ! command -v inotifywait &> /dev/null; then
    sudo apt install -y inotify-tools
fi

echo "👀 Watching for file changes..."

while true; do
    # Watch for any file save
    inotifywait -r -e close_write,moved_to,create ~/my_project \
        --exclude '(jupyter_env|\.git|__pycache__|\.ipynb_checkpoints)' \
        2>/dev/null

    sleep 2  # Small delay to batch rapid saves

    if [[ -n $(git status --porcelain) ]]; then
        git add .
        git commit -m "Auto sync: $(date '+%Y-%m-%d %H:%M:%S')"
        git push
        echo "✅ Pushed to GitHub at $(date '+%H:%M:%S')"
    fi
done

