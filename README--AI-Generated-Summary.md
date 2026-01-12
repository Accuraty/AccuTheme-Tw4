# AccuTheme-Tw4 — Project Summary (AI-Generated)

This document provides a high-level overview of the AccuTheme-Tw4 project, its architecture, technology stack, and development workflows.

## Project Overview
AccuTheme-Tw4 is a template project used as a starting point for web design and development of agency projects for clients. It is designed to work within the **DNN Platform (Framework)** and leverages **2sxc** for content management and application development.

### Key Goals
- Create and manage custom **Tailwind-based themes** (skins, containers, menus).
- Develop and customize **2sxc module Apps** with project-specific Razor views and components.
- Manage project-specific modifications (App_Code, RazorHost scripts, web.config customizations).

## Technology Stack & Constraints

### Backend / .NET
- **C# Language:** Version **8.0** (strictly enforced).
- **Frameworks:** **.NET Framework 4.8.1** and **.NET Standard 2.0**.
- **JSON Library:** **System.Text.Json** (preferred over Newtonsoft.Json).
- **Compiler:** DNN uses **Roslyn 4.1** for Razor compilation.

### Frontend / Styling
- **Tailwind CSS:** Version **v4.1+** using the **modern CSS config** (`@theme`).
- **CSS Generation:** All theme and project CSS is generated into a single `/Skin.css` file.
- **Icons:** Modern HTML approach using `<svg>`, `<symbol>`, and `<use>`.

### CMS & Modules
- **DNN Platform:** The host environment.
- **2sxc:** Used for structured content and hybrid Razor views.
- **DDR Menu:** Standard DNN menu system used with custom Razor templates.

## Workspace Layout
- **Root Solution (`dnn10.sln`):** An IntelliSense/tooling project, not a standalone web app.
- **Theme Assets:** Located in `dnn/Portals/_default/Skins/AccuTheme-Tw4/`.
- **2sxc Views:** Located in `dnn/Portals/0/2sxc/`.
- **Tailwind Sources:** Located in `src/tailwind/` (`index.css`, `theme.css`).

## Development Workflow: Open Heart Surgery (OHS)
The project follows an **Open Heart Surgery (OHS)** approach:
1. **Local Development:** All editing and Tailwind compilation happen on the local workstation.
2. **Synchronization:** Changed files are automatically copied to a remote staging/live DNN instance via **SFTP** (using the Natizyskunk extension).
3. **Immediate Testing:** Changes are immediately available for preview and testing on the remote instance.

## Key Patterns & Conventions

### Component Patterns (Shadcn Model)
- Moving towards a modern, reusable component pattern for 2sxc Views.
- Components are server-side Razor partials (with potential for front-end TSX).
- Components use **Props** with defaults and are customized per project rather than upgraded.

### Navigation (DDR Menu)
- Built recursively using `MenuNode` objects.
- Uses `<details>/<summary>` for pure CSS dropdowns.
- Accessibility-focused with `aria-current` and proper link roles.

### Tailwind v4.1 Usage
- Avoid `@apply` in Razor views; use utilities directly.
- Dynamic classes must be listed in comments or handled via switch statements to ensure they are picked up by the Tailwind scanner.
- Prefer **Flexbox** for content and **CSS Grid** for overall theme structure.

## Build & Packaging
- **npm scripts:** Used for Tailwind compilation (`npm start`, `npm run build`), image processing, and DNN theme packaging.
- **DNN Package:** An `npm run dnnpackage` script bundles the theme into an installable ZIP.

## Important Notes
- **Experimental Files:** Files with `NX` or `-gitignore` in the name, as well as `ps/AccuTheme-Watch-LocalDnn.ps1`, are experimental or unused and should be ignored.
- **Web.config:** Customizations are managed for connection strings, app settings, MIME types, and module removals (e.g., WebDAV).

---
*Last updated: December 24, 2025*
