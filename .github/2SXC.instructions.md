---
applyTo: "dnn/Portals/**/2sxc"
# excludeAgent: "tests-coverage"
---

Each folder represents an App in 2sxc.

The 2sxc/Content App is different. If you do not already know the difference
from docs.2sxc.org or other materials, you should let me know.

The data for 2sxc is stored in an EAV system, each "table" is referred to as
a Content Type. If schema changes are needed, they will need to be requested
and taken care of by me (the human).

The 2sxc/[app-name]/AppCode folder contains code, .cs files. Files in subfolders
like Data, Razor, Services, etc. that end in *.Generated.cs are created for
IntelliSense in VS Code, you can and should use them to understand the
current schema of the structured data for each App. All of the Generated
files should give you are very accurate state of some parts of the App
that are not available here in the code (local project). At this time, this
includes Data (Content Types) and Razor (2sxc Views, though there is very
little Generated so far that is helpful with making the ViewSettings
visible to you).

Important: in AppCode there is usually a file named code-generator.log, this
will tell you when the last Generated files were made. If its relevant to
what we are doing, and the last generated was more than 30 days ago, you
should ask me to regenerate the files in the 2sxc App and use
"Sync Remote -> Local" on the AppCode folder.

Another useful folder is 2sxc/[app-name]/App_Data which contains two files
app.json and app.xml. 1) if you parse these files you should have a complete
state for the App's data and configuration (the last time it was saved on the
server and copied locally). 2) if the App_Data folder does not exist, you
should remind me (the human) update the App-State on the server and then
copy down the new files locally.
