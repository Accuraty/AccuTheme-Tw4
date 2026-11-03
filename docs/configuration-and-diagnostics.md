# Configuration and diagnostics

## Skin configuration

`dnn/Portals/_default/Skins/AccuTheme-Tw4/AccuTheme.config` is JSON despite its extension. `src/AccuTheme-defaults.json` is a defaults template. `npm run accutheme` runs an interactive PowerShell script to edit the skin configuration. Inspect the script if the config is missing: its fallback defaults path should be verified against the repository layout.

`includes/vars.ascx` reads string-valued entries under `settings` into a static dictionary. It provides defaults if settings cannot be read or parsed. The layouts use `BreadCrumbsEnabled` (default true) and `BreadCrumbsOnHome` (default false). The code also reads `DnnEditModeCssPaneMinHeight`, but the layout's own comment identifies its use as unfinished. The local synchronization script reads `mode` and only starts in development mode. The existence of a setting in the JSON does not establish that every intended behavior is implemented; `unCache` is described as an idea in the defaults.

The configuration script notes that the static settings survive normal page loads and DNN cache clearing and directs administrators to restart the application for changes to take effect. Verify this behavior in the target environment.

## Diagnostics

`vars.ascx` sets `isDebug` to false and logs page and configuration values through `Accu.Dev`. The footer includes `__debug.ascx`; review its conditions and output before enabling or deploying diagnostics. Debugging can expose information about the site, so confirm what is visible and to whom on the target installation. The `includes/__debug-README.md` file contains additional notes.
