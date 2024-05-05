import * as vscode from "vscode"
import { ReaScriptUSDocML, SignaturesClass } from "./api-scraper/typescript/reascript-USDocML.types"

export function addMethodParamsToMarkdownDocs(
  markdown: vscode.MarkdownString,
  method: ReaScriptUSDocML
) {
  markdown.appendMarkdown("\n")
  markdown.appendMarkdown("---")
  markdown.appendMarkdown("\n")

  for (const param of method.params.entries) {
    markdown.appendMarkdown("\n")
    markdown.appendMarkdown(`***${param.identifier}***: ${param.description}`)
    markdown.appendMarkdown("\n")
  }

  return markdown
}

export function convertReaScriptDefinitionToSignatureInformation(
  definition: ReaScriptUSDocML,
  language: keyof SignaturesClass
): vscode.SignatureInformation {
  const markdown = new vscode.MarkdownString()

  markdown.appendMarkdown(definition.description.description)
  addMethodParamsToMarkdownDocs(markdown, definition)

  const signature = new vscode.SignatureInformation(definition.functioncall[language]!, markdown)

  if (Array.isArray(definition.signatures))
    throw new Error("Got empty signature object for function")

  const params = definition.signatures[language]?.parameters
  if (!params) throw new Error("No parameters")

  // @ts-ignore
  signature.parameters = params.map((it: any) => {
    const paramEntry = definition.params.entries.find((entry) => entry.identifier == it.identifier)
    return new vscode.ParameterInformation(it.identifier, paramEntry?.description)
  })

  return signature
}

type ExtensionUri = {
  authority: string;
  fragment: string;
  fsPath: string;
  path: string;
  query: string;
  scheme: string;
}

/** 
 * I'm reproducing the types from the extensionContext here, based on what I gathered a debug session.
 * They're meant to use in the future,
 * and also because the vscode API doesn't provide detailed types for it.
 * The most important property here is the packageJSON.
 * */
export type extensionContext = {
  exports: Function;
  extensionKind: number;
  extensionPath: string;
  extensionUri: ExtensionUri;
  id: string;
  isActive: Function;
  isFromDifferentExtensionHost: boolean;
  packageJSON: {
    activationEvents: string[];
    bugs: { url: string };
    categories: string[];
    contributes: {
      configuration: {
        order: number;
        title: string;
        properties: {
          [k: string]: {
            type: string; // type of the default property
            default: any;
            description?: string;
            markdownDescription?: string;
          }
        }
      };
      languages: { id: string; extensions: string[] }[];
      grammars: { language: string; scopeName: string; path: string }[];
    }
    dependencies: { [k: string]: string }
    devDependencies: { [k: string]: string }
    displayName: string;
    engines: { vscode: string }
    extensionDependencies: string[]
    extensionLocation: ExtensionUri
    icon: string;
    id: string;
    identifier: { value: string }
    isBuiltin: boolean
    isUnderDevelopment: boolean
    isUserBuiltin: boolean
    main: string
    name: string
    publisher: string
    repository: { type: string, url: string }
    scripts: { [K: string]: string }
    targetPlatform: string
    version: string
  }
}

/**
 * Add the lua types to the workspace settings.
 *
 * This is done by feeding the type-declarations file's path to the workspace settings.
 *
 * Lua's lsp will pick it up from there and take care of providing typechecking
 * and intellisense to the user.
 */
export const updateWorkspaceSettings = () => {
  // Define the file pattern or extension for Lua files
  const luaFilePattern = "**/*.lua"

  // Check if the workspace contains Lua files
  vscode.workspace.findFiles(luaFilePattern).then((files) => {
    if (files.length > 0) {
      // Get the configuration object for the current workspace
      const workspace_configuration = vscode.workspace.getConfiguration()
      const extensionContext = vscode.extensions.getExtension<extensionContext>(
        "antoinebalaine.reascript-docs"
      )
      if (!extensionContext) {
        return
      }

      const user_settings = vscode.workspace.getConfiguration("reascript-docs");
      const imguiVersion = user_settings.get("reaImGuiVersion")


      let luaWorkspaceLib;
      if (workspace_configuration.has("Lua.workspace.library")) {
        luaWorkspaceLib = workspace_configuration.get<string[] | undefined>("Lua.workspace.library")
      }
      /**
         * Find all the entries pertaining to reascript extension
         * save all the other entries of the workspace, if any, so they can be kept during the update
         */
      let otherEntries: string[] = []
      let reascriptEntries: string[] = []
      luaWorkspaceLib?.forEach((entry) => {
        if (/reascript/.test(entry)) {
          reascriptEntries.push(entry)
        } else {
          otherEntries.push(entry)
        }
      })
      if (imguiVersion && imguiVersion === "<0.9") {
        // mark the types file to be used by the extension
        const libraryPath = `${extensionContext.extensionPath}/resources/reaper-types.lua`;
        // merge all the pre-existing entries in the lua workspace with the reascript types we'll use
        workspace_configuration.update(
          "Lua.workspace.library",
          [...otherEntries, libraryPath],
          vscode.ConfigurationTarget.Workspace
        )
      } else {
        /** 
         * Since those types files are pretty big,
         * allow the workspace to chunk them when reading.
         * */
        // I'm not checking whether that setting already exists:
        // for some reason, the check always returns true, even when that property doesn't exist.
        // const hasPreloadFileSize = workspace_configuration.has("Lua.workspace.preloadFileSize")
        workspace_configuration.update(
          "Lua.workspace.preloadFileSize",
          1024,
          vscode.ConfigurationTarget.Workspace
        )
        /** 
         * Disable LuaPanda LS capability (sumneko is primary LS), use it only as debugger (workspace only)
         * */        
        workspace_configuration.update(
          "lua_analyzer.codeLinting.enable",
          false,
          vscode.ConfigurationTarget.Workspace
        )

        // use the corresponding imgui version types file, and the reascript api types file.
        const reaperDefsPath = `${extensionContext.extensionPath}/resources/Sexan_reaper_defs.lua`;
        const imGuiDefsPath = `${extensionContext.extensionPath}/resources/imgui_defs_${imguiVersion}.lua`;

        // merge all the pre-existing entries in the lua workspace with the reascript types we'll use
        workspace_configuration.update(
          "Lua.workspace.library",
          [...otherEntries, reaperDefsPath, imGuiDefsPath],
          vscode.ConfigurationTarget.Workspace
        )

      }
    }
  })
}
