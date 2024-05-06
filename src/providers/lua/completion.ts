import * as vscode from "vscode"

export class DebugSnippetCompletionItemProvider implements vscode.CompletionItemProvider {
  public static triggerCharacters = ["D", "E", "B", "U", "G"]

  private snippet: vscode.CompletionItem
  constructor(private extensionPath: string) {
    const debugSnippetCompletionItem = new vscode.CompletionItem(
      "REAPER DEBUGGER",
      vscode.CompletionItemKind.Snippet
    )

    // check the os of the user


    let string_snippet;
    if (process.platform === 'win32') {
      string_snippet = `local VSDEBUG = dofile("${this.extensionPath.replace(/\\/g, "/")}/debugger/LoadDebug.lua")$1`
    } else {
      string_snippet = `local VSDEBUG = dofile("${this.extensionPath}/debugger/LoadDebug.lua")$1`
    }

    debugSnippetCompletionItem.insertText = new vscode.SnippetString(
      string_snippet)
    this.snippet = debugSnippetCompletionItem
  }

  provideCompletionItems(
    document: vscode.TextDocument,
    position: vscode.Position
  ): vscode.ProviderResult<vscode.CompletionItem[] | vscode.CompletionList> {
    // Check if the user is typing 'DEBUG'
    const range = document.getWordRangeAtPosition(position, /DE?B?U?G?/)
    if (range) {
      return [this.snippet]
    }

    return []
  }

  register() {
    return vscode.languages.registerCompletionItemProvider(
      "lua",
      this,
      ...DebugSnippetCompletionItemProvider.triggerCharacters
    )
  }
}
