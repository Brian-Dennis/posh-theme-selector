#!/bin/bash

# This script scrapes the Oh My Posh documentation website to find
# theme preview image URLs and saves them to a JSON file.
# It requires curl and grep.

# --- Configuration ---

# URL of the Oh My Posh themes documentation page.
OHMYPOSH_THEMES_URL="https://ohmyposh.dev/docs/themes"

# Base URL for constructing absolute image URLs.
OHMYPOSH_BASE_URL="https://ohmyposh.dev"

# Path to the output JSON file where image URLs will be stored.
# This will be in the standard XDG config directory for oh-my-posh.
OUTPUT_JSON_FILE="$HOME/.config/oh-my-posh/theme_previews.json"

# --- Script Logic ---

# Check dependencies
if ! command -v curl &> /dev/null; then
    echo "Error: curl is not installed."
    echo "Please install curl (e.g., sudo pacman -S curl) to fetch web content."
    exit 1
fi

if ! command -v grep &> /dev/null; then
    echo "Error: grep is not installed."
    echo "Please install grep (usually part of coreutils) to process web content."
    exit 1
fi

# Ensure the directory for the output file exists
mkdir -p "$(dirname "$OUTPUT_JSON_FILE")"

echo "Fetching theme documentation page from $OHMYPOSH_THEMES_URL..."
# Fetch the documentation page content silently
html_content=$(curl -s "$OHMYPOSH_THEMES_URL")

# Check if curl was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to fetch content from $OHMYPOSH_THEMES_URL."
    exit 1
fi

echo "Extracting theme preview image URLs..."
# Extract image URLs that contain "/assets/images/" from img tags.
# This pattern looks for src attributes within img tags that contain "/assets/images/"
# and captures the path within the quotes.
# We then prepend the base URL to make them absolute.
# We use sort -u to get unique URLs and sort them alphabetically.
image_urls=$(echo "$html_content" | grep -oP '<img[^>]*src="\K(/assets/images/[^"]+)"' | sed "s|^|$OHMYPOSH_BASE_URL|" | sort -u)

# Check if any image URLs were found
if [ -z "$image_urls" ]; then
    echo "No theme preview images found on the documentation page using the current pattern."
    echo "The website structure might have changed."
    # Optionally, you could remove the old file if no new URLs are found
    # rm -f "$OUTPUT_JSON_FILE"
    exit 1
fi

echo "Formatting data as JSON..."
# Format the list of URLs into a JSON array.
# We wrap the list in square brackets and join lines with commas.
# We also wrap each URL in double quotes and escape any existing double quotes within the URL (though unlikely for URLs).
json_array="[\n"
first=true
while IFS= read -r url; do
    if [ "$first" = false ]; then
        json_array+=",\n"
    fi
    # Escape double quotes within the URL (just in case)
    escaped_url=$(echo "$url" | sed 's/"/\\"/g')
    json_array+="  \"$escaped_url\""
    first=false
done <<< "$image_urls"
json_array+="\n]"

echo "Saving image URLs to $OUTPUT_JSON_FILE..."
# Save the JSON array to the output file
echo -e "$json_array" > "$OUTPUT_JSON_FILE"

# Check if the file was written successfully
if [ $? -ne 0 ]; then
    echo "Error: Failed to write to $OUTPUT_JSON_FILE."
    exit 1
fi

echo "Successfully scraped and saved $(echo "$image_urls" | wc -l) image URLs to $OUTPUT_JSON_FILE."
echo "Run the theme switcher script to browse previews from the local file."

exit 0
