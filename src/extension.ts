import * as vscode from "vscode"
import * as defs from "./api-scraper/lua/results.json"
const definitions = defs as ReaScriptUSDocML[]

import { LiveGlobalView } from "./liveglobalview"
import { ReaScriptUSDocML } from "./api-scraper/typescript/reascript-USDocML.types"
import { EelCompletionItemProvider } from "./providers/eel/completion"
import { EelHoverProvider } from "./providers/eel/hover"
import { EelSignatureHelpProvider } from "./providers/eel/signature"
import { DebugSnippetCompletionItemProvider } from "./providers/lua/completion"
import { updateWorkspaceSettings } from "./utils"

import { InitializeFFI } from './osc';
var oscLib: ReturnType<typeof InitializeFFI>

export let extensionBasePath: string = "";

export function activate(context: vscode.ExtensionContext) {
	const treeDataProvider = new LiveGlobalView(context);
	vscode.window.registerTreeDataProvider('liveGlobalView', treeDataProvider);
	extensionBasePath = context.extensionUri.fsPath;

	// Initialize FFI
	oscLib = InitializeFFI()

	// Executes debugger and reascript task after lua debugger has started.
	vscode.debug.onDidStartDebugSession(e => {
		launchDebuggerTask()
		launchReaperOsc()
	})


	let updateLiveVariables = function () {
		if (vscode.debug.activeDebugSession) {
			vscode.debug.activeDebugSession.customRequest('variables', { variablesReference: -20000 }).then(result => {
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
			vscode.debug.activeDebugSession.customRequest('evaluate', { expression: "KILL", frameId: -9999, context: 'watch' })
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


function launchDebuggerTask() {
	const variables: { [key: string]: string } = {};
	const workspaceFolders = vscode.workspace.workspaceFolders;
	if (!workspaceFolders) return variables;
	for (const folder of workspaceFolders) {
		const taskname = vscode.workspace.getConfiguration('launch', folder.uri).configurations[0].debuggerTask;
		try {
			vscode.tasks.fetchTasks().then((tasks: vscode.Task[]) => {
				const taskToExecute = tasks.find(task => task.name === taskname);
				if (taskToExecute) {
					try {
						vscode.tasks.executeTask(taskToExecute).then((execution) => { })
					}
					catch (err) {
						console.error('Failed to execute task:', err);
						vscode.window.showErrorMessage('Failed to execute task');
					}
				} else {
					vscode.window.showErrorMessage(`Task "${taskname}" not found`);
				}
			})
		}
		catch (err) {
			console.error('Error fetching tasks:', err);
		};
	}
	return variables;
}



function launchReaperOsc() {
	const variables: { [key: string]: string } = {};
	const workspaceFolders = vscode.workspace.workspaceFolders;
	if (!workspaceFolders) return variables;
	for (const folder of workspaceFolders) {
		const ids = (vscode.workspace.getConfiguration('launch', folder.uri).configurations[0].reaperDebugActionID as string).split(";");
		const ip = vscode.workspace.getConfiguration('launch', folder.uri).configurations[0].reaperOscIp ?? "127.0.0.1";
		const port = vscode.workspace.getConfiguration('launch', folder.uri).configurations[0].reaperOscPort ?? 8000;

		try {
			ids.forEach(function(e) {
				const x = e.trim().split("-")
				const id = (x[0] ?? "").trim() as string
				const delay = Number((x[1] ?? "").trim()) as number

				(async function doSomeStuff(i:string, d: number) {
					await new Promise(resolve => setTimeout(resolve, d))
					oscLib.osc.sendOscMessageString(ip.trim(), 8783, "/action", i.trim())
				})(id, delay);
			});
		}
		catch (err) {
			console.error('Error executing Reaper ID using OSC:', err);
		};
	}
	return variables;
}