import * as vscode from 'vscode';

type LuaPandaNode = {
	name: string,
	type: string,
	value: string,
	variablesReference: number,
}

type Node = { key: string };

class Key {
	constructor(readonly key: string) { }
}

export class liveGlobalView implements vscode.TreeDataProvider<Node> {
	private _onDidChangeTreeData: vscode.EventEmitter<(Node | undefined)[] | undefined> = new vscode.EventEmitter<Node[] | undefined>();
	// We want to use an array as the event type, but the API for this is currently being finalized. Until it's finalized, use any.
	public onDidChangeTreeData: vscode.Event<any> = this._onDidChangeTreeData.event;
	public tree: LuaPandaNode[] = [];
	// Keep track of any nodes we create so that we can re-use the same objects.
	private nodes: any = {};

	constructor(context: vscode.ExtensionContext) {
		const view = vscode.window.createTreeView('liveGlobalView', { treeDataProvider: this, showCollapseAll: true });
		context.subscriptions.push(view);
	}

	// Tree data provider 

	public setData(new_data: { variables: LuaPandaNode[] }) {
		this.tree = new_data.variables
		this._onDidChangeTreeData.fire(undefined);
	}

	public getChildren(element?: Node): Node[] {
		let ch: string[];
		if (!element) {
			ch = Object.keys(this.tree);
		} else {
			const treeElement = this._getTreeElement(element.key);
			if (treeElement) {
				ch = Object.keys(treeElement);
			} else {
				ch = [];
			}

		}
		const childNodes = ch.map(key => this._getNode(key));
		return childNodes;
	}

	public getTreeItem(element: Node): vscode.TreeItem {
		const treeItem = this._getTreeItem(element.key);
		treeItem.id = element.key;
		return treeItem;
	}


	_getTreeItem(key: string): vscode.TreeItem {
		const treeElement = this._getTreeElement(key);
		if (!treeElement) {
			return {}
		} else {
			let name = treeElement.name
			if (treeElement.value != "") {
				name += " = " + treeElement.value
			}
			return { label: name }
		}
	}

	_getTreeElement(element: string | undefined) {
		if (!element) {
			return this.tree;
		}
		const currentNode = this.tree;
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
