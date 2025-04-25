scrape-posh-previews.sh 🕸️

This is a simple Bash script designed to scrape the Oh My Posh documentation website for theme preview image URLs and save them to a local JSON file. This local file can then be used by other scripts (like the select-posh-theme.sh theme switcher) to provide faster access to theme previews without needing to fetch the website content every time.
Features ✨

    Fetches the Oh My Posh themes documentation page.

    Extracts image URLs that appear to be theme previews.

    Formats the extracted URLs into a JSON array.

    Saves the JSON data to a local file.

Requirements 🛠️

This script requires the following command-line tools to be installed on your system:

    bash: The shell to execute the script (standard on most Linux systems).

    curl: Used to fetch the content of the Oh My Posh documentation page.

        Installation (Arch Linux):

        sudo pacman -S curl

    grep: Used to extract the image URLs from the HTML content.

        Installation (Arch Linux):

        sudo pacman -S grep # usually part of coreutils

    sed: Used to process the extracted URLs and format the JSON.

        Installation (Arch Linux):

        sudo pacman -S sed # usually part of coreutils

    find: Used to list files (though not strictly necessary for the scraping logic itself, it's a common dependency in related scripts).

        Installation (Arch Linux):

        sudo pacman -S find # usually part of findutils

    Standard Utilities: mkdir, dirname, echo, wc, sort (these are usually part of the coreutils package and are standard on most Linux systems).

Installation ⬇️

    Save the script: Copy the content of the scrape-posh-previews.sh script into a file named scrape-posh-previews.sh.

    Choose a location: Save this file to a directory that is included in your system's PATH environment variable. A standard location for user-specific scripts is ~/.local/bin/.

    mkdir -p ~/.local/bin/
    # Then save the script content to ~/.local/bin/scrape-posh-previews.sh

    Make it executable: Give the script execute permissions.

    chmod +x ~/.local/bin/scrape-posh-previews.sh

    Verify PATH: Ensure ~/.local/bin/ is in your PATH. You can check with echo $PATH. If it's not, add fish_add_path ~/.local/bin to your ~/.config/fish/config.fish and restart your terminal.

Usage 🖱️

To run the scraper script, simply open your terminal and execute it by name:

scrape-posh-previews.sh

The script will:

    Fetch the content from https://ohmyposh.dev/docs/themes.

    Extract image URLs containing /assets/images/.

    Format these URLs into a JSON array.

    Save the JSON array to ~/.config/oh-my-posh/theme_previews.json.

You should run this script periodically (e.g., weekly or monthly) to keep your local preview data up-to-date with any changes on the Oh My Posh website.
Output File 💾

The script creates or overwrites the file ~/.config/oh-my-posh/theme_previews.json. This file is a simple JSON array containing strings, where each string is a full URL to a Oh My Posh theme preview image.

Example theme_previews.json content:

[
"https://ohmyposh.dev/assets/images/1_shell-abcdef12345.png",
"https://ohmyposh.dev/assets/images/another_theme-67890abcde.jpg",
// ... more URLs
]

Integration with select-posh-theme.sh 🤝

This theme_previews.json file is designed to be read by the select-posh-theme.sh script when you choose the "Browse Local Previews" option. The theme switcher script uses jq to parse this JSON file and present the URLs in a Rofi menu, allowing you to quickly view the theme previews without hitting the network each time.

Make sure you have jq installed (sudo pacman -S jq) for the select-posh-theme.sh script to be able to read this file.

This README provides a comprehensive overview of the scrape-posh-previews.sh script.
