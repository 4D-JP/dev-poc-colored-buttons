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
