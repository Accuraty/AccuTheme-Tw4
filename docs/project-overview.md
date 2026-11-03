# Project overview

AccuTheme-Tw4 is a starting point for creating and maintaining a custom DNN theme with Tailwind CSS 4. It also provides a place to keep other file-based site customizations alongside the theme: DNN templates, Razor code, 2sxc views, media, and site-level files. The intent is to manage the project's files over its lifetime without changing DNN core.

The `dnn/` tree mirrors portions of a DNN website. It is not a complete DNN installation. A running DNN site and an appropriate process for transferring files to it are built in and use the VS Code extension SFTP by Natizyskunk. DNN database content and configuration are not captured simply by maintaining this repository.

Important: [SFTP by Natizyskunk](https://github.com/Natizyskunk/vscode-sftp) is abandon-ware. Last updates were June 2023. If you encounter problem, check Issues, some problems have fixes available.

## Repository map

| Path | Purpose |
| --- | --- |
| `src/tailwind/` | Tailwind input, project tokens, and hand-authored CSS. |
| `src/media/` | Source images, SVGs, fonts, videos, and favicon inputs. |
| `dnn/Portals/_default/Skins/AccuTheme-Tw4/` | DNN skin layouts, shared includes, menus, configuration, and generated `Skin.css`. |
| `dnn/Portals/_default/Containers/AccuTheme-Tw4/` | DNN container templates. |
| `dnn/App_Code/` | Shared Razor helper code used by the site. |
| `dnn/Portals/0/2sxc/` | Site-specific 2sxc views and examples. |
| `ps/` | PowerShell configuration, synchronization, upload, and asset scripts. |
| `dnn-accutheme.csproj` and `.props` | Editor/IntelliSense project and environment-specific references. |

In this project, **skin** generally refers to a DNN theme layout, **pane** to a server-side region where DNN modules can be placed, and **container** to the wrapper around a module. The existing documentation also uses **OHS** for the workflow of managing project files locally while working against a DNN instance.

The repository contains Accuraty-specific examples and environment assumptions. Treat them as starting material to review, not a finished client theme.
