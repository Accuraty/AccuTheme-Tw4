# Open questions and limitations

These are starting points for refining the documentation and testing the starter, not a complete issue list.

- **First installation:** Establish supported DNN and extension versions, required runtime DLLs, and a repeatable setup on a clean instance. Verify the intended workflow without 2sxc.
- **Distribution:** The DNN package command is explicitly unimplemented. Decide how a new theme should be named, transferred, installed, and upgraded.
- **Configuration:** Verify the configuration script's fallback path, runtime setting cache behavior, and which settings actually affect output. `unCache` and edit-pane height have unfinished notes.
- **Navigation:** Replace example page IDs and confirm the intended mobile navigation and accessibility behavior on a real site.
- **Synchronization:** Validate the local watcher and remote upload workflow in a disposable environment, including deletes, ignores, initial transfer, and error handling.
- **Assets:** Verify image and favicon outputs and document any external tool requirements. Confirm the target paths used by SVG helpers.
- **Documentation tracks:** Decide which material belongs in a short first-project tutorial, designer and developer feature guides, and site-maintainer reference. Existing root and nested READMEs include useful background as well as old notes and TODOs.
