# Getting Started

Its important to understand that you are not modifying DNN's core. AccuTheme is helping you manage and modify 
any/all the extensible parts of DNN like themes, modules, menus, etc. And providing you a single, 
ongoing source of truth for all the file-based additions and changes that make up your DNN-based project. 

You should not be here unless you are already familiar with or have a strong desire to learn DNN, 2sxc, 
Tailwind 4.1+, and C#/Razor.

Using this project effectively requires commitment to a process and workflow that requires these few up-front 
technology choices. The next choices are foundational, and if you are 
new to this, less obvious:

1. Adamantly fight off adding dependencies
2. Discover the built-in way something is done before you create something new (e.g. did you know we have a built-in favicon generator command?)

DNN - in a nutshell, DNN is a thowback that has survived technology changes and provides a fundamentally useful 
approach to all types of websites and applications whether the need is functionality or design.

AccuTheme will take care of almost all your website and application needs except where to host the project 
and how you manage your backups. 

## Key Concepts

OHS

One CSS to Rule Them All

DNN with no module installed

**Project Lifetime Monorepo** - thought not technically a monorepo, this project allows you to manage, edit, 
develop, and change a significant number of things in a DNN instance. Obviously one of the core parts is 
developing a custom DNN theme, but you also have complete ongoing control of every aspect of your site's 
content presentation from ad-hoc content to navigation to custom 2sxc Apps.

## Installation

**Prerequisite** - Like any project, to use AccuTheme effectively you need at least a basic orientation on 
VS Code, NodeJS (and npm/npx), Git, GitHUb, 

## If it ain't broke, don't fix it

### "JS? This project needs TypeScript because it is better!" 

We agree TS is better, but this project does not use JS in a way that could benefit from TS' advantages. 
If part of your site's plan is a significant application, then that should be a separate project.
