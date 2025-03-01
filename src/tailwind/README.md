# Forced Content

Put any CSS or HTML file(s) in this folder (`src/tailwind`) and they will be used
as additional content sources.

In other words, even if your theme files somehow don't generate some tailwind
classes you need or want in your production CSS, add them here in plain .html
files.

# Presets [WIP]

Docs on [Presets](https://tailwindcss.com/docs/presets)

TODO: include 1 or 2 sample cool-preset.js files as well as a sample
tailwind.config.js showing how to use it...

```
module.exports = {
  presets: [
    require('./cool-preset.js')
  ],
  // (Post Preset) Customizations specific to this project would go here
  theme: {
    extend: {
      minHeight: {
        48: '12rem',
      }
    }
  },
}
```
