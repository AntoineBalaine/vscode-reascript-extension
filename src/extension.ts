import * as vscode from "vscode"
import * as defs from "./api-scraper/lua/results.json"
const definitions = defs as ReaScriptUSDocML[]

import { ReaScriptUSDocML } from "./api-scraper/typescript/reascript-USDocML.types"
import { EelCompletionItemProvider } from "./providers/eel/completion"
import { EelHoverProvider } from "./providers/eel/hover"
import { EelSignatureHelpProvider } from "./providers/eel/signature"
import { DebugSnippetCompletionItemProvider } from "./providers/lua/completion"
import { updateWorkspaceSettings } from "./utils"

export function activate(context: vscode.ExtensionContext) {
  const eelSignatureProvider = new EelSignatureHelpProvider(definitions).register()
  const eelCompletionProvider = new EelCompletionItemProvider(definitions).register()
  const eelHoverProvider = new EelHoverProvider(definitions).register()

  const debugSnippetCompletionItemProvider = new DebugSnippetCompletionItemProvider(
    context.extensionPath
  ).register()

  updateWorkspaceSettings()

  context.subscriptions.push(
    eelSignatureProvider,
    eelCompletionProvider,
    eelHoverProvider,
    debugSnippetCompletionItemProvider
  )
}
