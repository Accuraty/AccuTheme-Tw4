# Styling with Tailwind

`src/tailwind/index.css` is the build entry point. It imports Tailwind and the project's CSS files; the default build writes `Skin.css` in the DNN skin folder. Edit the source files and rebuild rather than treating generated CSS as the durable source of changes.

## Where to work

- `theme.css` defines project theme variables, including example fonts, colors, color variants, and an extra breakpoint. Replace the example branding for a new project.
- `reset.css`, `base.css`, and `dnn-ui-adjustments.css` contain foundational and DNN-specific styling.
- `typography.css` contains prose styling; `components.css` and `utilities.css` provide shared styling.
- `bs5-favs.css` and `2sxc-content-app-bs5.css` are imported for Bootstrap-style conveniences and 2sxc Content App compatibility. Review whether they are appropriate for the site.

The entry point uses CSS cascade layers for base, components, and utilities. The skin also contains preheader code concerned with DNN resource loading and layers. Inspect the resulting page and stylesheet order when changing imports or overriding DNN and module styles.

## Class detection

Tailwind needs complete class names in files it scans. Avoid constructing utility names from fragments in Razor or C#; use complete alternatives instead. The entry point currently imports Tailwind with automatic source detection; its explicit `@source` declarations are commented out. The skin README notes that ignored files and CSS are not scanned as content. If utilities are missing, check source detection and the actual generated CSS before adding explicit sources or other remedies.

The source contains examples and experiments, including modern color functions. Check browser support and the site's visual and accessibility requirements when choosing the final tokens. `src/tailwind/README.md` and the skin's `README--Editors-Using-Tailwind.md` provide additional project notes.
