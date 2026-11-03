# Getting started

This draft assumes familiarity with DNN administration, HTML/CSS, a code editor, Git, and the basics of Tailwind. Razor and C# are useful for the included views and helpers. A working DNN environment must be provisioned separately.

It is important to understand that the you work locally in VS Code against a working remote DNN website. At the simplest level, you make changes or compile things or run scripts locally and each file - on save - auto-uploads to the running remote DNN website. This can take a little getting used to both conceptually and in practice, but quickly becomes second nature.

## First time workstation prep

### Required

You should already have installed and working locally

- NodeJs (includes NPM), usually latest LTS (or look in package.json)
- NVM or similar tool for managing Node/NPM versions
- PowerShell latest

### Recommended or Helpful (according to Accuraty)

- MS SQL Server Developer Edition
- SSMS
- Windows Features - add IIS and related tools, exclude FTP (or disable service startup)
- nvQuickSITE

## Prepare the environment

1. Create a project from this repository and establish a Git history for the site.
2. Install Node.js and npm. `package.json` specifies Node `>=24.14.1`; install a compatible version. PowerShell 7 (`pwsh`) is used by the supplied PowerShell npm scripts.
3. Run `npm install` in the project root. Its `postinstall` runs the CSS build and writes the generated skin stylesheet. Use `npm run install:nobuild` if installation without that build is needed.
4. Arrange access to a suitable DNN instance and decide how project files will reach it. Check the runtime dependencies and environment-specific paths described in [Development and deployment](development-and-deployment.md).

## Make the first theme changes

1. Review `src/tailwind/theme.css` and replace example fonts and colors with the project's design tokens. Check any external font references in the skin includes.
2. Review `Main.ascx`, `MainPlus.ascx`, their `panes/` includes, and the header and footer in `includes/`. Adapt the layout and module regions to the design.
3. Replace example branding, links, social information, and hard-coded DNN page IDs in the header and footer. Review the other client-specific examples before using them.
4. Run `npm start` while editing to rebuild `dnn/Portals/_default/Skins/AccuTheme-Tw4/Skin.css`; stop the watcher with Ctrl+C. Run `npm run build` for a minified build.
5. Transfer the necessary files to the DNN instance, apply the theme and container through DNN, and inspect both visitor and editing views. Verify navigation, panes, responsive layouts, fonts, and content from the actual site.

The CSS watcher only builds a local file. It does not itself publish or synchronize files to DNN. Renaming the theme requires updating paths and references throughout the project; see `ps/AccuTheme-FolderRename.md` as a starting reference and verify its guidance before relying on it.

For deeper guidance, continue with [theme structure](theme-structure-and-layouts.md) and [styling](styling-with-tailwind.md).
