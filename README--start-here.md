# Getting Started

Its important to understand that you are not modifying DNN's core. AccuTheme is helping you manage and modify 
any/all the extensible parts of DNN like themes, modules, menus, etc. And providing you a single, 
ongoing source of truth for all the file-based additions and changes that make up your DNN-based project. 

Hopefully you are here because you find that the above (implied) workflows might be beneficial to your DNN 
related projects or you have a strong interest in theming DNN using Tailwind CSS. You should already be somewhat 
familiar with or have a strong desire to learn C#/Razor, 2sxc, Tailwind CSS 4.1+, very modern CSS, and DNN.

**2sxc note:** 2sxc is not required and you can use AccuTheme w/o ever installing 2sxc and ignoring the 2sxc files 
and folders in the project. [we need to test and prove this 20251230 JRF]

Using this project effectively requires commitment to a process and workflow with these few up-front 
technology choices. These are foundational, and if you are new to this, less obvious:

1. Actively fight adding dependencies
2. Discover the built-in way something is done, before you create something new 

For 2, here are some less obvious examples. AccuTheme has:

- a built-in favicon generator 
- examples of and follows a modern CSS-friendly pattern optimizing SVGs
- SVG re-use examples and patterns (`<symbol ...>` and `<use ...>`)
- preheader has both Code and SkinObject examples for including all kinds of scripts, stylesheets, fonts, and other things
- a custom, styleable Login page
- a workable pattern for moving DNN's legacy CSS into CSS Cascade Layers
- 

DNN - in a nutshell, DNN is a thowback that has survived technology changes and provides a fundamentally useful 
approach to all types of websites and applications whether the need is functionality or design.

AccuTheme will take care of almost all your website and application needs except a) where to host the project 
and b) how you manage your backups. 

## Key Concepts

OHS = Open Heart Surgery, Local Project vs. Remote running DNN instance

All your CSS is in one highly optimized file, /Skin.css

DNN with no more than 3 add-ons installed (modules, libraries, etc.)

**Project Lifetime Monorepo** - though not technically a monorepo, this project allows you to manage, edit, 
develop, and change a significant number of things in a DNN instance. Obviously one of the core parts is 
developing a custom DNN theme, but you also have complete ongoing control of every aspect of your site's 
presentation from ad-hoc content to navigation to custom structured data.

## Installation

**Prerequisite** - Like any project, to use AccuTheme effectively you need at least a basic orientation on 
VS Code, NodeJS (and npm/npx and managing Node version with NVM), Git, GitHub, 

## If it ain't broke, don't fix it

### "JS? This project needs TypeScript because it is better!" 

We agree TS is better, but this project does not use JS in a way that could benefit from TS' advantages. 
If part of your site's plan is a significant application, then that should be a separate project.
 
### "But... TypeScript??" 
 
Okay, fine. As of Dec 2025 we are proceeding with an (optional) TS config. What changed our mind? We want 
JSX available without adding any dependencies. Impossible? Yes, but NOT if you already have TS (because TSX 
comes with TypeScript). Also, enabling TS when we already have Vite in place is trivial.

## Long-Term Client Projects with Detailed History

AccuTheme grew from an Accuraty DNN Skin Template (Bootstrap v3, 2018+) to the best way to work on a client 
project from the start and over very long periods of time. Git (GitHub) provide an excellent history of 
changes to the project, especially when all client work is either GitHub Issue or specific quoted Projects. 

### SiteMaps

See README--SiteMaps.md - whether doing recurring SEO/SERP work or fixing URLs transitioning a client project 
to a new domain, it starts with a GitHub Issue and the majority of the work is done in the project - whether 
its manual custom sitemaps or writing code to generate sitemaps from slugged dynamic pages, the work and 
testing are done in VS Code and when complete, merged into the project with Issues linked and closed.
