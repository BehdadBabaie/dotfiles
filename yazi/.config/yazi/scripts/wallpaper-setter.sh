#!/bin/env bash

file_path="$1"
NEW_NAME=$(basename "$file_path")
TARGET_SCRIPT=~/.local/bin/start-dwm.sh

# Apply the current wallpaper
feh --no-fehbg --bg-fill file_path &

if [ ! -f "$TARGET_SCRIPT" ]; then
    exit 1
fi

TMP_FILE=$(mktemp)

while IFS= read -r line; do
    if [[ "$line" =~ ^file_name= ]]; then
        CURRENT_PATH=$(echo "$line" | cut -d'"' -f2)
        DIR_PATH=$(dirname "$CURRENT_PATH")
        echo "file_name=\"$DIR_PATH/$NEW_NAME\"" >> "$TMP_FILE"
    else
        echo "$line" >> "$TMP_FILE"
    fi
done < "$TARGET_SCRIPT"

mv "$TMP_FILE" "$TARGET_SCRIPT"
chmod +x "$TARGET_SCRIPT"

echo "done"
