import * as vscode from "vscode"
import * as defs from "./api-scraper/lua/results.json"
const definitions = defs as ReaScriptUSDocML[]

import { LiveGlobalView } from "./LiveGlobalView"
import { ReaScriptUSDocML } from "./api-scraper/typescript/reascript-USDocML.types"
import { EelCompletionItemProvider } from "./providers/eel/completion"
import { EelHoverProvider } from "./providers/eel/hover"
import { EelSignatureHelpProvider } from "./providers/eel/signature"
import { DebugSnippetCompletionItemProvider } from "./providers/lua/completion"
import { updateWorkspaceSettings } from "./utils"
export function activate(context: vscode.ExtensionContext) {
  const treeDataProvider = new LiveGlobalView(context);
  vscode.window.registerTreeDataProvider('liveGlobalView', treeDataProvider);

  let updateLiveVariables = function() {
		if (vscode.debug.activeDebugSession) { 
		  vscode.debug.activeDebugSession.customRequest('variables', {variablesReference: -20000}).then(result => {
        treeDataProvider.setData(result)
    })
    
    }
  }  
  // update live variables every 2 seconds (not sure if it can be lower but with this method vs code does not like anytihng bellow)
	setInterval(updateLiveVariables, 2000);

  // New debug button to disconnect debugger and close script in reaper
  // Close/terminate script and debugger (disconnect only kills debuger but script continues to work in bg)
  let kill_debug_and_reaper = vscode.commands.registerCommand("reaper.KillScript", () => {
    // if debug session is active
		if (vscode.debug.activeDebugSession) { 
      vscode.window.withProgress(
        { location: vscode.ProgressLocation.Notification },
        async (progress) => {
          const steps = 200;
          const delay = 8 / steps;
    
          for (let i = 0; i <= steps; i++) {
            await new Promise<void>((resolve) => {
              setTimeout(() => {
                progress.report({ increment: 1, message: "Terminating Script & Debug" });
                resolve();
              }, delay);
            });
          }
        }
      );
       // little hacky but send evaluate command with non existing stack value to detect our custom command
      // this is handled in LuaPanda (stackId == -9999 then reaper.defer = function(x) end)
			vscode.debug.activeDebugSession.customRequest('evaluate', {expression: "KILL", frameId: -9999, context:'watch'})
		}
	})	
	context.subscriptions.push(kill_debug_and_reaper)

  const eelSignatureProvider = new EelSignatureHelpProvider(definitions).register()
  const eelCompletionProvider = new EelCompletionItemProvider(definitions).register()
  const eelHoverProvider = new EelHoverProvider(definitions).register()

  const debugSnippetCompletionItemProvider = new DebugSnippetCompletionItemProvider(
    context.extensionPath
  ).register()

  updateWorkspaceSettings()

  vscode.workspace.onDidChangeConfiguration((event) => {
    updateWorkspaceSettings()
  })

  context.subscriptions.push(
    eelSignatureProvider,
    eelCompletionProvider,
    eelHoverProvider,
    debugSnippetCompletionItemProvider
  )
}
