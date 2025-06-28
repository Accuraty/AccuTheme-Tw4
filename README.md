# AccuTheme-Tw4

## Public and Open Source, we hope you find this project to be the best starter for any Tailwind-based DNN theme.

This was built by Accuraty for our own in-house use, so its had significant experience-based, time-saving workflows from the start. AccuTheme emphasizes ready-to-use everything and provides an approach to your entire DNN project that we hope will become your goto development environment for many years after you project is live.

### Key features:

#### TailwindCss v4+

- Tailwind v4 from scratch (not an upgrade from Tw3)

#### DNN

- DNN Theme Package generation (DNN install zip, command line `npm run dnnpackage`)
- DDR Menus - production-ready Primary and 3+ examples for various use-cases
- Our original and unique [Disclosure-based](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements#interactive_elements) NavSite DDR Menu
- Our original and unique [Disclosure-based](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements#interactive_elements) DNN Accordion Containers // TODO fix #nn
- DNN Pane-level wrappers for Flex, Grid, Masonry layouts (optional) // TODO

#### 2sxc

- Traditional and 2sxc-friendly DNN Containers
- Makes the **2sxc Content App** look great out of the box (even using "Bs5" Views)!
- Project Constants and .env for time-saving project setup // TODO
- 2sxc-based AccuTheme Settings App for Portal Administrators (optional, installed separately) // TODO

#### Content Editors and Site Managers

- Our writer-friendly Typography styling for great prose in WYSIWYG editing of long-form articles (optional, on by default)
- No dependencies, **only devDependencies**

#### Theme Designers and Developers

- Built-in Image Processing (command line `npm run images`)
- Bootstrap v4 or v5 "tiny shim" (optional, on by default) for people moving from Bootstrap to Tailwind
- Automatic Prettier and Lint configured for always-perfect code formatting (csharp, razor, html, css, js, etc)
- Advanced Debug output Footer (on-page info for every site admin, designer, or developer's needs)
- Work using a local OR remote DNN Instance
- Modern JavaScript Bundling to both Theme and Page level usage // TODO
- Modern TypeScript Bundling ... // PLANNED

### 2sxc is Not Required

Though we embrace and use it, **2sxc is not required**. For example, all the AccuTheme Settings have defaults and per-portal, these settings can set/changed in simple [.env|.json] files. // TODO

### History

The origins of the project as an agency-friendly custom theme starting point go back to 2016-2019 and Chris Lusk. This modern version is by Jeremy Farrance, reworked and rebuilt many times across 2021-2024. Then this version was built from a clean slate starting in summer 2024 with the exciting releases of the very first TailwindCss v4 alpha ([initial working commit using Tw4 Alpha 18 was Aug 4, 2024](https://github.com/Accuraty/AccuTheme-Tw4/commits/?since=2024-04-01&until=2024-08-30)).

## Learning Tailwind v4

### Recommended 50-Minute Crash Course Video | Tailwind CSS v4 Full Course 2025

- [Master Tw in One Hour: How Does it Work, Fundamentals (12 mins)](https://youtu.be/6biMWgD6_JY?t=274)
- [Master Tw in One Hour: Layouts, Structure, Flexbox, Media Queries (12 mins)](https://youtu.be/6biMWgD6_JY?t=1028)
- [Master Tw in One Hour: Dark Mode, Custom Styles, Reusability (10 mins)](https://youtu.be/6biMWgD6_JY&t=1787)
- [Master Tw in One Hour: Tailwind CSS Tips & Tricks (6 mins)](https://youtu.be/6biMWgD6_JY&t=2793)

### Practice Your Flex and Grid

- [Flexbox Frobby: A 24 Level Game](https://flexboxfroggy.com/)
- [CSS Grid Garden: A 28 Level Game](https://cssgridgarden.com/)

### Using Tailwin v4.1+ as of 20250518 JRF

Development, Ideas, etc.

- [ACCU4: TailwindCss v4 Reference](https://accu4.com/More-/TailwindCss-v4-Reference)
- [ACCU4: AccuTheme-Tw4 Home?](https://accu4.com/More-/TailwindCss-AccuTheme-Tw4)
- other

TODO: lots and lots, this README.md file is a WIP

### Rewrite using [AccuTheme-Bs4 README.md](https://github.com/Accuraty/AccuTheme-Bs4/blob/main/README.md) as a starting reference

Status: roadmap, fixes and minor improvements from now on. AccuTheme "redux" in the works (20230305 JRF).

TODO [Maintenance](/README--maintenance.md): of THIS template project, periodic upkeep on dependencies and related

[VS Code Setup](https://www.accu4.com/H2R2S/VS-Code-Initial-Setup): from scratch, new machine, etc.

### Getting started

- Start in the `src/tailwind` folder and update theme.css with project colors
- DNN
  - update `dnn/Portals/_default/PersonaBarTheme.css` with project colors, logo, etc
  - modify initial page structure (sections, Panes) as needed for initial layout(s)
- [ Boo ya da... ]- ...
