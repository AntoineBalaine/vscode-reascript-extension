import * as vscode from 'vscode';

export class liveGlobalView implements vscode.TreeDataProvider<Node> {
	private _onDidChangeTreeData: vscode.EventEmitter<(Node | undefined)[] | undefined> = new vscode.EventEmitter<Node[] | undefined>();
	// We want to use an array as the event type, but the API for this is currently being finalized. Until it's finalized, use any.
	public onDidChangeTreeData: vscode.Event<any> = this._onDidChangeTreeData.event;
	public tree: any = {
		1 : {
			"name": "Waiting for incomming data",
			"value": ""
		}		
	};
	// Keep track of any nodes we create so that we can re-use the same objects.
	private nodes: any = {};

	constructor(context: vscode.ExtensionContext) {
		const view = vscode.window.createTreeView('liveGlobalView', { treeDataProvider: this, showCollapseAll: true });
		context.subscriptions.push(view);
	}

	// Tree data provider 

	public setData(new_data: any): any {
		this.tree = new_data["variables"]
		this._onDidChangeTreeData.fire(undefined);
	}

	public getChildren(element: Node): Node[] {
		return this._getChildren(element ? element.key : undefined).map(key => this._getNode(key));
	}

	public getTreeItem(element: Node): vscode.TreeItem {
		const treeItem = this._getTreeItem(element.key);
		treeItem.id = element.key;
		return treeItem;
	}	

	_getChildren(key: string | undefined): string[] {
		if (!key) {
			return Object.keys(this.tree);
		}
		const treeElement = this._getTreeElement(key);
		if (treeElement) {
			return Object.keys(treeElement);
		}
		return [];
	}

	_getTreeItem(key: string): vscode.TreeItem {
		const treeElement = this._getTreeElement(key);
		// if (treeElement["type"]==="table"){
		// 	return {
		// 		label: /**vscode.TreeItemLabel**/<any>{ label: treeElement["name"] + " = " + treeElement["value"]}, //, highlights: key.length > 1 ? [[key.length - 2, key.length - 1]] : void 0 },
		// 		//tooltip,
		// 		collapsibleState: treeElement && Object.keys(treeElement).length ? vscode.TreeItemCollapsibleState.Collapsed : vscode.TreeItemCollapsibleState.None,
		// 	};
		// }
		// else{
			var name = treeElement["name"]
			if (treeElement["value"]!= ""){
				name += " = " + treeElement["value"]
			}
			return { label: name}
		// }		
	}

	_getTreeElement(element: string | undefined, tree?: any): any {
		if (!element) {
			return this.tree;
		}
		const currentNode = tree ?? this.tree;
		for (const prop in currentNode) {
			if (prop === element) {
				return currentNode[prop];			
			}
		}
	}

	_getNode(key: string): Node {
		if (!this.nodes[key]) {
			this.nodes[key] = new Key(key);
		}
		return this.nodes[key];
	}
}

type Node = { key: string };

class Key {
	constructor(readonly key: string) { }
}