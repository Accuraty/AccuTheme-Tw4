# Development and deployment

## Build commands

Run these from the repository root:

| Command | Purpose |
| --- | --- |
| `npm start` | Watch Tailwind input and rebuild the skin's `Skin.css`. |
| `npm run build` | Build a minified `Skin.css`. |
| `npm run images` | Run the Rolldown image configuration. Review its output before using it in a deployment. |
| `npm run favicons` | Run the PowerShell favicon workflow. |
| `npm run accutheme` | Run the interactive skin configuration script. |

`npm test` is a placeholder. `npm run dnnpackage` invokes a configuration that deliberately throws an error: a DNN install package is not implemented. Some other scripts in `package.json` are marked experiments or placeholders. Do not assume all listed commands are production workflows.

## Local and remote DNN

The `dnn/` directory is a project-side file tree, not a live website. The local watcher in `ps/AccuTheme-Watch-LocalDnn.ps1` watches that tree and copies changes to a DNN website directory. Its default target is specific to the author's environment; pass an appropriate `TargetRootRel` and inspect the script before use. It handles deletes and renames as well as changes, so it can remove files from the target. It only starts in development mode, and it is not an initial full synchronization.

For remote work, `npm run push:file -- <path>` invokes `ps/Push-FileToRemote.ps1`. The script expects a local `.vscode/sftp.json` configuration by default and uses WinSCP; it supports `-DryRun` to inspect the mapping and `-Verify` to check the uploaded file. Inspect connection settings and the script before using it. A transfer is a live change to the target site. Keep credentials out of committed files.

## Editor and runtime dependencies

The .NET project is described as an IntelliSense aid, not a deployment package. `dnn-accutheme.props` contains versions to align with the target DNN and modules; the project references DLL locations under `C:\dev\dlls` as well as NuGet packages and `dependencies/`. These paths and version choices are environment-specific. `global.json` describes the SDK selection.

The skin imports `Accuraty.Libraries.AccuLadder` and uses `Accu.Dev`; `dnn/App_Code/AccuTheme.cshtml` supplies additional helpers. Ensure the required assemblies and files exist on the target DNN instance. Although the repository describes 2sxc as optional, the no-2sxc path is explicitly marked unverified in the existing getting-started README; the included 2sxc views obviously require it.

Review the target site, backups, file permissions, and deployment process before copying files. Changes to the site database, installed extensions, and server configuration are outside the CSS build.
