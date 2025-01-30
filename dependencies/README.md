# Dependencies

Additional DLLs for this project that will provide VS Code IntelliSense

## Important

Please check the [project].csproj file carefully first and make sure any DLLs you put in this folder are not already covered via C:\dev\dlls or the NuGet PackageReference(s).
 
Realistically, the DLLs in this folder should be a copy and version match for something you needed to add to the (remote) DNN instance's /bin folder. An obvious example might be `ClosedXML.dll` or `Select.HtmlToPdf.dll`.

## Better?

If its worth having IntelliSense, please also consider updating your theme's `__debug.aspx` with `.GetVersion("ClosedXML")` so that this DLLs version is output is included in the footer details (and therefore surfaced, a good reminder that future you or others might actually see).
