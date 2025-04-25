# posh-theme-selector ✨

This repository contains scripts for managing Oh My Posh themes and handling random wallpapers in a Hyprland environment. It includes a Rofi-based theme switcher and a script to scrape theme preview images.

## Repository Structure 📂

* `select-posh-theme/`: Contains the `select-posh-theme.sh` script and its README.

* `scrape-posh-previews/`: Contains the `scrape-posh-previews.sh` script and its README.

* `wallpaper-changer/`: Contains the `WallpaperAutoChange.sh` script.

* `README.md`: This file, providing an overview of the repository.

## Scripts 📜

* **`select-posh-theme/select-posh-theme.sh`**: A Rofi-based script to select and apply Oh My Posh themes and browse previews.

  * [README for select-posh-theme.sh](./select-posh-theme/README.md)

* **`scrape-posh-previews/scrape-posh-previews.sh`**: A script to scrape Oh My Posh theme preview image URLs.

  * [README for scrape-posh-previews.sh](./scrape-posh-previews/README.md)

* **`wallpaper-changer/WallpaperAutoChange.sh`**: A script to set random wallpapers using `swww`.

## Installation and Usage ⬇️🖱️

Refer to the individual README files in the respective subdirectories for detailed installation instructions and usage guides for each script.

**General Steps:**

1. Clone this repository to your desired location (e.g., `~/posh-theme-selector`).

2. Ensure the scripts have execute permissions (`chmod +x path/to/script.sh`).

3. Place the scripts in a directory that is in your system's `PATH` (e.g., `~/.local/bin/` or keep them in the repository and add the repository's script directories to your PATH).

4. Update your Hyprland configuration (`~/.config/hypr/UserConfigs/Startup_Apps.conf`) to execute `wallpaper-changer/WallpaperAutoChange.sh` on startup, passing your wallpaper directory as an argument.

5. Ensure all required dependencies (`rofi`, `jq`, `loupe`, `swww`, `wallust`, `xdg-open`, etc.) are installed.

## Contributing 🤝

If you'd like to contribute to these scripts, feel free to fork the repository and submit pull requests.

---

This README provides an overview of the `posh-theme-selector` repository.
