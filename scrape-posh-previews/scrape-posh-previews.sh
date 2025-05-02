#!/bin/bash

# Ensure pup is installed. If not, install it.
# For Ubuntu or Debian-based systems:
# sudo apt install pup

# Define your base URL and output file (make sure these are set)
OHMYPOSH_BASE_URL="https://ohmyposh.dev"
OUTPUT_JSON_FILE="theme_previews.json"

# Check if pup is installed
if ! command -v pup &>/dev/null; then
  echo "Error: pup is not installed. Please install it using: sudo apt install pup"
  exit 1
fi

# Fetch the HTML content from the URL using curl
html_content=$(curl -s "$OHMYPOSH_BASE_URL/docs/themes")
curl_status=$? # Capture the exit status of curl

# Check if curl was successful
if [ "$curl_status" -ne 0 ]; then
  echo "Error: Failed to fetch HTML content from $OHMYPOSH_BASE_URL/docs/themes."
  exit 1
fi

# Use pup to scrape image URLs that contain /assets/images/
image_urls=$(echo "$html_content" | pup 'img[src*="/assets/images/"] attr{src}' | sort -u)
pup_status=$? # Capture the exit status of pup

# Check if pup was successful
if [ "$pup_status" -ne 0 ]; then
  echo "Error: Failed to extract image URLs using pup."
  exit 1
fi

# Check if any image URLs were found
if [ -z "$image_urls" ]; then
  echo "No theme preview images found on the documentation page using the current pattern."
  exit 1
fi

# Format the list of URLs into a JSON array
json_array="[\n"
first=true
while IFS= read -r url; do
  if [ "$first" = false ]; then
    json_array+=",\n"
  fi
  # Escape quotes within URLs using native Bash string manipulation
  escaped_url="${url//\"/\\\"}"
  json_array+="  \"$escaped_url\""
  first=false
done <<<"$image_urls"
json_array+="\n]"

# Save the JSON array to the output file
echo "Saving image URLs to $OUTPUT_JSON_FILE..."
echo -e "$json_array" >"$OUTPUT_JSON_FILE"
write_status=$? # Capture the exit status of the file-writing operation

# Check if the file was written successfully
if [ "$write_status" -ne 0 ]; then
  echo "Error: Failed to write to $OUTPUT_JSON_FILE."
  exit 1
fi

echo "Successfully scraped and saved $(echo "$image_urls" | wc -l) image URLs to $OUTPUT_JSON_FILE."
echo "Run the theme switcher script to browse previews from the local file."

exit 0
