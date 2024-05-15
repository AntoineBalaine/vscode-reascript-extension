import * as vscode from 'vscode';

/**
 * Provider for cat scratch editors.
 * 
 * Cat scratch editors are used for `.cscratch` files, which are just json files.
 * To get started, run this extension and open an empty `.cscratch` file in VS Code.
 * 
 * This provider demonstrates:
 * 
 * - Setting up the initial webview for a custom editor.
 * - Loading scripts and styles in a custom editor.
 * - Synchronizing changes between a text document and a custom editor.
 */
export class reaperFlameGraph implements vscode.CustomTextEditorProvider {

	public static register(context: vscode.ExtensionContext): vscode.Disposable {
		const provider = new reaperFlameGraph(context);
		const providerRegistration = vscode.window.registerCustomEditorProvider(reaperFlameGraph.viewType, provider);
		return providerRegistration;
	}

	public static readonly viewType = 'flamegraph.View';

	constructor(
		private readonly context: vscode.ExtensionContext
	) { }

	/**
	 * Called when our custom editor is opened.
	 * 
	 * 
	 */
	public async resolveCustomTextEditor(
		document: vscode.TextDocument,
		webviewPanel: vscode.WebviewPanel,
		_token: vscode.CancellationToken
	): Promise<void> {
		// Setup initial content for the webview
		webviewPanel.webview.options = {
			enableScripts: true,
		};
		
		webviewPanel.webview.html = this.getHtmlForWebview(webviewPanel.webview, document.uri);

		const updateWebview = (path: vscode.Uri) => {
			webviewPanel.webview.html = this.getHtmlForWebview(webviewPanel.webview, path);		
			}
			
			// Hook up event handlers so that we can synchronize the webview with the text document.
			//
			// The text document acts as our model, so we have to sync change in the document to our
			// editor and sync changes in the editor back to the document.
			// 
			// Remember that a single text document can also be shared between multiple custom
			// editors (this happens for example when you split a custom editor)
			
			const changeDocumentSubscription = vscode.workspace.onDidChangeTextDocument(e => {
				if (e.document.uri.toString() === document.uri.toString()) {
				updateWebview(e.document.uri);
			}


		});

		// Make sure we get rid of the listener when our editor is closed.
		webviewPanel.onDidDispose(() => {
			changeDocumentSubscription.dispose();
		});

		updateWebview(document.uri);
	}

	/**
	 * Get the static html used for the editor webviews.
	 */
	private getHtmlForWebview(webview: vscode.Webview, path: vscode.Uri): string {
		// Local path to script and css for the webview		
		const file_json = webview.asWebviewUri(path)
		const d3 = webview.asWebviewUri(vscode.Uri.joinPath(this.context.extensionUri, "d3", "d3.js"))
		const flcss = webview.asWebviewUri(vscode.Uri.joinPath(this.context.extensionUri, "d3", "d3-flamegraph.css"))
		const flcjs = webview.asWebviewUri(vscode.Uri.joinPath(this.context.extensionUri, "d3", "d3-flamegraph.js"))
		const flctt = webview.asWebviewUri(vscode.Uri.joinPath(this.context.extensionUri, "d3", "d3-flamegraph-tooltip.js"))

		return `<html> 
		<head>
		<link rel="stylesheet" type="text/css" href="${flcss}">
	  </head>
	  <body>
		<div id="chart"></div>
		<!-- D3.js -->
		<script type="text/javascript" src="${d3}"></script>

		<!-- d3-flamegraph -->
		<script type="text/javascript" src="${flcjs}"></script>

		<!-- d3-tip -->
		<script type="text/javascript" src="${flctt}"></script>
		
		<script type="text/javascript">		
		var chart = flamegraph()
		  .width(960)
		  .cellHeight(28)
		  .inverted(true)

		var tip = flamegraph.tooltip.defaultFlamegraphTooltip().html(d => 
			"Name: " + d.data.name + 
			"<br> Source: "   + (d.data.source) +
			"<br> Line: "   + (d.data.line) +
			"<br> <progress value=" + (d.data.time_frac) + " max='100'></progress>  " + (d.data.time_frac) + "% of Total" +
			"<br> <progress value=" + (d.data.time_frac_parent) + " max='100'></progress>  " + (d.data.time_frac_parent) + "% of Parent" +
			"<table style='width:100%'>" +
				"<tr>" +
					"<th>Time</th>" +
					"<th>Calls</th>" +
					"<th>Frames</th>" +
				"</tr>" +
				"<tr>" +
					"<td>" + (d.data.time) + "</td>"+
					"<td>" + (d.data.count) + "</td>"+
					"<td>" + (d.data.frames) + "</td>"+
				"</tr>" +
			"</table>" +
			//"<br> Time: "   + (d.data.time) +
			//"<br> Calls: "  + (d.data.count) +
			//"<br> Frames: " + (d.data.frames) +
			"<table style='width:100%'>" +
				"<tr>" +
					"<th>Min</th>" +
					"<th>Avg</th>" +
					"<th>Max</th>" +
					"<th></th>" +
				"</tr>" +
				"<tr>" +
					"<td>" + (d.data.tpcmin) + "</td>"+
					"<td>" + (d.data.tpcavg) + "</td>"+
					"<td>" + (d.data.tpcmax) + "</td>"+
					"<td>T/c</td>"+
				"</tr>" +
				"<tr>" +
					"<td>" + (d.data.tpfmin) + "</td>"+
					"<td>" + (d.data.tpfavg) + "</td>"+
					"<td>" + (d.data.tpfmax) + "</td>"+
					"<td>T/f</td>" +
				"</tr>" +
				"<tr>" +
					"<td>" + (d.data.cpfmin) + "</td>" +
					"<td>" + (d.data.cpfavg) + "</td>" +
					"<td>" + (d.data.cpfmax) + "</td>" +
					"<td>C/f</td>" +
				"</tr>" +
			"</table>"
		);
		
		chart.tooltip(tip);

		d3.json("${file_json}")
		  .then(data => {
			d3.select("#chart")
			  .datum(data)
			  .call(chart)
		  }).catch(error => {
			return console.warn(error);
		  });
		</script>
		</body>
		</html>`;
	}
}
