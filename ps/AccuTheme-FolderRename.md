[This pull on Bs4](https://github.com/Accuraty/AccuTheme-Bs4/pull/55) should have 95% or more of the changes needed for renaming the `.../Skins/AccuTheme-XxN folder` for the project, summarized below.

The plan is to have an `/ps/AccuTheme-FolderRename.ps1` so we can simply `npm run AccuTheme:FolderRename` to get the job done (at project start).

.vscode/sftp.json.example L23
    "files": "**/[AccuTheme-FolderRename]/**/*",
