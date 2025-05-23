# ReaScript VS Code Extension

An extension for Reaper's ReaScript API methods in VS Code.
Provides type-checking in lua, intellisense/Autocomplete, and doc-comments on hover for all functions.
Libraries that also have type-checking:
- ReaImGui
- Reawwise

## Using the definitions with another editor?
…is possible. Requires luals to work with your editor. 

Create a `.luarc.json` at the root of your lua project, and point it to where the extension’s definitions file is located:

```json
{
    "runtime.version": "Lua 5.4",
    "diagnostics.globals": [
        "reaper",
    ],
    "workspace": {
        "library": [
            "~/.vscode/extensions/antoinebalaine.reascript-docs-0.1.13/resources/Sexan_reaper_defs.lua",
            "~/.vscode/extensions/antoinebalaine.reascript-docs-0.1.13/resources/imgui_defs_0.9.lua",
            "~/.vscode/extensions/antoinebalaine.reascript-docs-0.1.13/resources/reawwise_defs.lua"
        ]
    }
}
```


### How to use the debugger:

1. Create a launch.json config, and include the following:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "lua",
      "request": "attach",
      "name": "LuaPanda",
      "cwd": "${workspaceFolder}",
      "connectionPort": 8818,
      "stopOnEntry": false,
      "useCHook": true,
      "address": "localhost"
    }
  ]
}
```

2. Start the debugger - it will list for incoming connections
3. Include the REAPER-DEBUGGER snippet at the start of your script:

```lua
local VSDEBUG = dofile("<extensionPath>/debugger/LoadDebug.lua")
```

TIP: This snippet is auto-completed - if you type `DEBUG` in the editor, the auto-completion should trigger, and you’ll see the snippet called `REAPER DEBUGGER`. Also, the snippet will auto-fill the extensionPath with the correct path on your computer.

4. run your script from reaper.

If your script runs on a defer loop inside reaper, you may attach the debugger while it’s running.

#### Sexan's debugger tutorial: 
To add and start debugging is really simple, just on first line of your script write
`DEBUGGER` and select `REAPER_DEBUGGER` and you are ready to go.

![completion](./resources/images/completion.gif)

1. Error Catching
Debugger can only catch errors if the function is called by reaper.defer(func). Your function does not need to be in loop it just needs to be called with it. Looped deferred scripts have this automatically

![error](./resources/images/error.gif)

2. Conditional break points.
Normal breakpoints just halt the script when they are hit. Conditional do same but with as their name imply with condition:
In the first run I've set condition to not be met so nothing happens. But on second part it halts the script since condition is met.

![breakpoints](./resources/images/breakpoints.gif)


3. LogPoints
Unlike breakpoints which halt the script, LogPoints work while script is live.
With them you can:
1. Check is your function triggering (are we in the function)
2. You can evaluate expressions by adding "{x}" in the line. Everything inside of it will be evaluated like check the value of variable, some condition etc.

![logpoints](./resources/images/logpoints.gif)

1. Setting/Changing variables in memory
You can change any variable and it will change permanently in your script/memory while debugging. This can be also done via REPL

![vars](./resources/images/vars.gif)

1. REPL In Console
Script needs to be halted in order to use it.

![repl](./resources/images/repl2.gif)

1. Watch Variable tab
As it implies here you can set variables you like to watch, expressions etc. Script needs to be halted in order to see them

![watch](./resources/images/watch.gif)

### Credits:

[Sexan](https://github.com/GoranKovac) - integrated the debugger, created the parser we’re currently using to generate the reaper types.

[Cfillion](https://github.com/cfillion) - provided the types for ImGui

[Mespotine](https://github.com/mespotine) - Maintains the thorough reaper documentation that we initially used

[Gavin Ray](https://github.com/GavinRay97) - initial creator of the extension

## Changelog

- 0.1.14 (May 12th 2025)
  - readme docs for using defs with neovim
- 0.1.13 (May 10th 2025)
  - update to reaper defs
- 0.1.12 (Aug 8th 2024)
  - hotfix ImGui defs 
- 0.1.11 (Aug 7th 2024)
  - update ImGui defs to 0.9.2
- 0.1.10 (Aug 7th 2024)
  - add live global variable view
- 0.1.9 (June 6th 2024)
  - include ReaWwise types
- 0.1.8 (May 15th 2024)
  - allow updating workspaces when extension settings change mid-session
- 0.1.7 (May 6th 2024)
  - fix stack call structure in windows, update modules file structure
- 0.1.6 (May 6th 2024)
  - fix windows paths on completion items
- 0.1.5 (May 5th 2024)
  - include Debugger capability using Sexan’s modded LuaPanda functionality
  - include snippet to call LuaPanda debugger
  - include LuaPanda as extension dependency
- 0.1.4 (May 4rd 2024)
  - update reaper types
- 0.1.3 (May 3rd 2024)
  - use updated reaper types file from Sexan's api parser
  - use updated ImGui types file from Cfillion's ci
  - remove previous completion/hover/signature providers that were redundant
- 0.1.2 (Dec 13th 2023)
  - add reaper pointers to list of types, using classes in types file
- 0.1.0 (Sep 24rd 2023)
  - setup auto-highlight for Jesusonic file types
- 0.1.0 (Sep 23rd 2023)
  - remove common typos in function declarations (params finishing with "In")
  - fix some ReaImGui tyes
- 0.0.10 (July 6th 2023)
  - fix optional parameters of functions
  - rewrite lua keywords that were used as param names
  - add back ImGui function declaration
  - various bug fixes around types

- 0.0.9 (July 6th 2023)
  - temporarily remove ImGui functions that have inaccurate signatures

- 0.0.8 (July 5th 2023)
  - bug-fix when trying to find extension's path from utilities

- 0.0.7 (July 5th 2023)
  - add extension icon

- 0.0.6 (July 5th 2023)
  - update extension credentials to activate only for lua/eel/jsfx/txt files
  - declare extension dependency using [Lua-LSP](https://github.com/LuaLS/lua-language-server)
  - create type declaration files for reaper-api, including reaImGui functions
  - update documentation to [ultraschall's api docs v.4.9](https://github.com/Ultraschall/ultraschall-lua-api-for-reaper/releases/tag/4.9)
  - bring type declaration files into workspace scope when the extension activates
- 0.0.5 (1/18/21)
  - Fixed bug with signature completion
  - Refactored providers to classes by feature, in individual folders, implementing the provider API for that feature:
    - ```ts
      // In "src/providers/eel/completion.ts"
      class EelCompletionItemProvider implements vscode.CompletionItemProvider {}
      ```

- 0.0.4 (1/18/21)

  - **Added syntax highlighting for Eel/Jesusonic/WALTER (all credit to Breeder's TextMate grammar file, see copyright notice in repo)**
  - **Added intellisense/autocomplete for Eel/Jesusonic**
  - Method signatures now show the return types. IE, when pressing `(` to invoke `reaper.AddMediaItemToTrack`, it shows `MediaItem tr = reaper.AddMediaItemToTrack()`
  - Large internal refactor for the shape of the JSON document used to store ReaScript functions. Better parser in Lua using Ultraschall API methods for USDocML to generate this.

- 0.0.3 (1/10/21)

  - Fixed issue where autocomplete was case-sensitive if trying to autocomplete a method preceeding a dot, IE "getmedia" expected to trigger "reaper.GetMedia\*\* but didn't

- 0.0.2 (1/6/2021)

  - Added scraper and parser to grab docs from Ultraschall ReaScript API, and process the important stringified fields into JSON
  - As a byproduct of using Ultraschall as a docs source, the extension now has:
    - SWS methods
    - JS methods
    - Better descriptions
    - Comments about parameter and returns values on many functions
  - Updated formatting on the doc blocks, so that it looks much nicer. Important things are bolded, items are logically spaced, markdown used instead of plain text, etc
  - Intellisense/Autocomplete now works without having to prefix the method with "reaper." and "gfx." (still need to make this a toggleable option)
  - **NOTE**: A big thank-you to Meo-Mespotine for writing/maintaining the Ultraschall docs, and also Extremeraym for his Node function that sanitizes the XML format so that it's properly parseable.

- 0.0.1
  - Initial version
