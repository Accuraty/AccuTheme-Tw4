### This is how things are, they are changing rapidly though. 

#### This probably needs a quarterly (or monthly?) review 20260107 JRF

Use instruction files to automate what the agent knows: Anything in copilot-instructions.md is the “standard preloaded context” mechanism. You can add a rule like “At the start of each task, open/read /.github/2sxc-copilot-instructions.md and follow it.” That still requires the agent to read it, but it’s at least a consistent default behavior.

Create a single “context pack” file: Put the key rules/links/checklists into one short doc (and reference it from copilot-instructions). This avoids needing multiple attachments.

Reusable prompts/templates: If you keep a saved prompt template (a “bootstrap” prompt that says “read X, Y, Z then do task”), you can run/paste it at the start of chats—faster than manually attaching files, but it’s still a manual step.


Hopefully in the future the Chat+Sessions will start to have more context and features.
