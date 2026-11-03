# SEE JRF

In brief: we remove various DNN CSS files and add back (minimally) customized versions in CSS Layers.

This is done so Tailwind works (well or better) by putting DNN's stuff in the `base` layer.

Note: JRF does this manually every few releases, typically when DNN has changes to default.css, admin.css, etc.

## Future?

- Find other DNN CSS files that can be redone this way.
- Automate updating, because its a bit tedious.
- Redo the Remove/Add using CDF.
- Ideas?

## Important to know:

The project's `.gitignore` is affecting this folder

```
...
**/AccuTheme-Tw4/dist/**/*.*
!**/AccuTheme-Tw4/dist/layers/*.css
!**/AccuTheme-Tw4/dist/layers/*.md
...
```
