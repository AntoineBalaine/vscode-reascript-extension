import * as vscode from 'vscode'
import { reaperFlameGraph } from './reaperflameGraphEditor';
import * as defs from "./api-scraper/lua/results.json"
const definitions = defs as ReaScriptUSDocML[]

import { ReaScriptUSDocML } from "./api-scraper/typescript/reascript-USDocML.types"
import { EelCompletionItemProvider } from "./providers/eel/completion"
import { EelHoverProvider } from "./providers/eel/hover"
import { EelSignatureHelpProvider } from "./providers/eel/signature"
import { DebugSnippetCompletionItemProvider } from "./providers/lua/completion"
import { updateWorkspaceSettings } from "./utils"

export function activate(context: vscode.ExtensionContext) {
	context.subscriptions.push(reaperFlameGraph.register(context));

  // Send custom request to debugger (profile button)
  //const dbgSession = vscode.debug.activeDebugSession
	let start_profiler = vscode.commands.registerCommand("reaper.StartProfiler", () => {
    // if debug session is active
		if (vscode.debug.activeDebugSession) {     
      // Show message in lower right corner that profile is being collected
      vscode.window.withProgress(
        { location: vscode.ProgressLocation.Notification },
        async (progress) => {
          const steps = 200;
          const delay = 8 / steps;
    
          for (let i = 0; i <= steps; i++) {
            await new Promise<void>((resolve) => {
              setTimeout(() => {
                progress.report({ increment: 1, message: "Collecting profile, please wait..." });
                resolve();
              }, delay);
            });
          }
        }
      );
       // little hacky but send evaluate command with non existing stack value to detect our custom command
      // this is handled in LuaPanda (stackId == -999 then run_profiler)
			vscode.debug.activeDebugSession.customRequest('evaluate', {expression: "PROFILER START", frameId: -999, context:'watch'})
		}
	})	
	context.subscriptions.push(start_profiler)

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

  // Watch custom file types for creating/modifying for automatic opening on genearion
	let watcher = vscode.workspace.createFileSystemWatcher("**/*.ReaProfile");
	context.subscriptions.push(watcher);
	// Auto open newly created .ReaProfile files
	watcher.onDidCreate(uri => {
		vscode.commands.executeCommand("vscode.openWith", uri, reaperFlameGraph.viewType);
	});
	// Auto open modifed .ReaProfile files
	watcher.onDidChange(uri => {
		vscode.commands.executeCommand("vscode.openWith", uri, reaperFlameGraph.viewType);
	});

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
