# Theme structure and layouts

The skin lives under `dnn/Portals/_default/Skins/AccuTheme-Tw4/`. DNN loads `.ascx` layouts, which include shared markup and pane definitions. Start with the layout applied to the page and follow its includes when changing the structure.

## Layouts and panes

- `Main.ascx` includes a hero banner, `ContentPane`, main/sidebar, left/right, and bottom pane groups.
- `MainPlus.ascx` adds hero, sidebar/main, and three-column pane groups to the basic layout.
- `Edit.ascx` has a similar basic structure; `Auth.ascx` and `Popup.ascx` provide additional specialized layouts. Review their markup and DNN assignment before changing them.

The individual pane groups are in `panes/`. Each defines server-side regions and their surrounding layout markup. Changing pane names or removing panes can affect existing module placement; coordinate those changes with the DNN site. Test empty and populated panes in both view and edit modes.

## Shared pieces

`includes/vars.ascx` loads common page state and skin settings. The layouts include `header.ascx` and `footer.ascx`; the header includes the preheader and other pieces. Separate includes cover the logo, breadcrumb, social links, metadata, and diagnostics. `preheader` files register resources and address CSS layers. Review the actual include chain when adding resources or changing shared markup.

The checked-in header, footer, menu IDs, logo, and text include examples specific to Accuraty or a particular site. Replace them as part of a new design. The mobile navigation include is currently commented out in `header.ascx`; inspect and test the selected navigation approach rather than assuming it is active.

The container folder currently includes `Plain.ascx`. Review it alongside the modules and 2sxc views used on the site. See the skin's own README files for additional notes intended for maintainers and editors.
