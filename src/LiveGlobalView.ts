import * as vscode from 'vscode';
import { deepEqual } from './utils';

type LuaPandaNode = {
  name: string,
  type: string,
  value: string,
  variablesReference: number,
}

export class LiveGlobalView implements vscode.TreeDataProvider<LuaPandaNode> {

  constructor(context: vscode.ExtensionContext) {
    const view = vscode.window.createTreeView('liveGlobalView', { treeDataProvider: this, showCollapseAll: true });
    context.subscriptions.push(view);
  }

  public tree: LuaPandaNode[] = [];

  private changeEmitter: vscode.EventEmitter<LuaPandaNode | LuaPandaNode[] | undefined | null | void> = new vscode.EventEmitter<LuaPandaNode[] | undefined>();
  public onDidChangeTreeData: vscode.Event<LuaPandaNode | LuaPandaNode[] | undefined | null | void> = this.changeEmitter.event;

  public setData(new_data: { variables: LuaPandaNode[] }) {
    if (!deepEqual(new_data.variables, this.tree)) {
      this.tree = new_data.variables
      this.changeEmitter.fire(undefined);

    }
  }

  getTreeItem(element: LuaPandaNode): vscode.TreeItem {
    const treeItem = new vscode.TreeItem(element.name);
    treeItem.id = element.name;
    treeItem.collapsibleState = vscode.TreeItemCollapsibleState.None;
    treeItem.tooltip = `${element.name} (${element.type})`;
    treeItem.description = element.value;

    let name = element.name
    if (element.value != "") {
      name += " = " + element.value
    }
    treeItem.label = name;
    return treeItem;
  };



  getChildren(element?: LuaPandaNode): vscode.ProviderResult<LuaPandaNode[]> {
    if (!element) {
      return this.tree;
    } else {
      const node = this.tree.find((node) => (node.name === element.name));
      if (!node) {
        return [];
      } else {
        return [node];
      }
    }

  };
}
