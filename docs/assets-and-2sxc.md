# Assets and 2sxc

## Media

Source media is organized under `src/media/`. The image Rolldown configuration selects common raster image formats under `images/` and SVGs under `svg/`, with output directed to the skin's `dist/media/` tree. Inspect the actual output and paths after running `npm run images`; the configuration is not evidence of image resizing or optimization.

The favicon inputs, markup, and settings live in `src/media/favicon/`; `npm run favicons` invokes `ps/AccuTheme-Favicons.ps1`. Read that script and the folder README for its requirements and output before replacing a site's icons. Fonts and videos have their own source folders and notes.

`dnn/App_Code/AccuTheme.cshtml` defines skin media paths and SVG sprite helpers such as `AccuIcon`. Ensure the referenced sprite is available in the deployed media path before using a helper. The source SVG files provide examples of reusable graphics.

## 2sxc examples

The `dnn/Portals/0/2sxc/` tree contains Content App views and examples for other apps, including AccuTabs, AccuScroller, and AccuTrack. These are starting points for site-specific structured content and may depend on corresponding installed apps, content types, APIs, and data. Copying the Razor files alone does not establish those dependencies. Review the relevant app's README and test against the site's installed versions.

The imported `2sxc-content-app-bs5.css` provides styling for some Bootstrap-oriented Content App markup. The project aims to support themes without 2sxc, but the existing documentation says that path still needs verification. See [Development and deployment](development-and-deployment.md) for the separate runtime dependency on AccuLadder used by the skin.
