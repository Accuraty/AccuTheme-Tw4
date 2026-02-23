# Dependencies

Additional DLLs for this project that will provide VS Code IntelliSense

## Important

Please check the [project].props file carefully first and make sure any DLLs you put in this folder are not already covered via C:\dev\dlls or the NuGet PackageReference(s).

Realistically, the DLLs in this folder should be a copy and version match for something you needed to add (already added) to the running/remote DNN instance's /bin folder. An obvious example might be `ClosedXML.dll` or `Select.HtmlToPdf.dll`.

Further, this folder is custom for THIS project, if this is always the case, the dependency should be moved to AccuTheme and follow the pattern in [project].props where we established pattern so we are not setting this up post-deploy for every project. Existing examples: 

1. We want a DNN DLL that is not in the handful of NuGet packages. We made the DDR Menu DLL always IntelliSense available by putting the DLL in the dev/dlls/{best version} system which makes the DLL available using <ENV_BestVersion_Dnn>.

2. We want to use AccuKit (was AccuLadder), see `A:\dev\dlls\AccuKit` and <ENV_BestVersion_AccuKit> in [project].props.

Note: the dev/dlls system is manually maintained (mostly by JRF as of 202602) and only works if users periodically run `npm run updateDLLs`.

## Better?

If its worth having IntelliSense, please also consider updating your theme's `__debug.aspx` with `.GetVersion("ClosedXML")` so that this DLLs version is output is included in the footer details (and therefore surfaced, a good reminder that future you or others might actually see).
