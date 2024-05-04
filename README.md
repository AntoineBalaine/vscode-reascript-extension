# ReaScript VS Code Extension

An extension for Reaper's ReaScript API methods in VS Code.
Provides type-checking in lua, intellisense/Autocomplete, and doc-comments on hover for all functions.

## Changelog
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
