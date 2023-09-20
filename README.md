![version](https://img.shields.io/badge/version-19%2B-5682DF)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)
[![license](https://img.shields.io/github/license/miyako/dev-poc-colored-buttons)](LICENSE)
![downloads](https://img.shields.io/github/downloads/miyako/dev-poc-colored-buttons/total)

# dev-poc-colored-buttons
a little proof-of-concept.

## Requirements

* get macOS accent colour
* take code from [4d-plugin-get-system-colors](https://github.com/miyako/4d-plugin-get-system-colors)
* [controlAccentColor](https://developer.apple.com/documentation/appkit/nscolor/3000782-controlaccentcolor)
* [MacAccentColorCatalyst](https://github.com/DylanMcD8/MacAccentColorCatalyst/tree/main)

## Note

* `controlAccentColor` is only available on macOS 10.14 or newer
* 4D SVG rendering engine does not seem to accept `hsl(0, 100%, 50%)` style color.
* the valid sytax of the [`picture`](https://developer.4d.com/docs/FormObjects/propertiesPicture#pathname) property is url`("{posix}")`

https://stackoverflow.com/questions/63159666/get-windows-10-theme-color-in-classic-c-winapi-win32-application
