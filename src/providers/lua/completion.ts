import * as vscode from "vscode";

export class DebugSnippetCompletionItemProvider implements vscode.CompletionItemProvider {
  public static triggerCharacters = ['D', 'DE', 'DEB', 'DEBU', 'DEBUG']

  private snippet: vscode.CompletionItem;
  constructor(private extensionPath: string) {
    const debugSnippetCompletionItem = new vscode.CompletionItem("reaper_debug", vscode.CompletionItemKind.Snippet);

    debugSnippetCompletionItem.insertText = new vscode.SnippetString(`local VSDEBUG = dofile("${this.extensionPath}/debugger/LoadDebug.lua")$1`);
    this.snippet = debugSnippetCompletionItem
  }


  provideCompletionItems(
    document: vscode.TextDocument,
    position: vscode.Position,
  ): vscode.ProviderResult<vscode.CompletionItem[] | vscode.CompletionList> {


    // Check if the user is typing 'DEBUG'
    const range = document.getWordRangeAtPosition(position, /DE?B?U?G?/);
    if (range) {
      return [this.snippet];
    }

    return [];
  }

  register() {
    return vscode.languages.registerCompletionItemProvider(
      "lua",
      this,
      ...DebugSnippetCompletionItemProvider.triggerCharacters
    )
  }
}
