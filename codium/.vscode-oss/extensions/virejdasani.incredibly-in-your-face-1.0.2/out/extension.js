// A lot of the code used to make this extension is from the following repos:
// https://github.com/phindle/error-lens/blob/master/src/extension.ts
// https://github.com/microsoft/vscode-extension-samples/tree/main/webview-sample
// https://github.com/microsoft/vscode-extension-samples/tree/main/webview-view-sample
// https://code.visualstudio.com/api/extension-guides/webview
// and more that I can't find anymore
"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.deactivate = exports.activate = void 0;
// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
const vscode = require("vscode");
// this method is called when your extension is activated
// your extension is activated the very first time the command is executed
function activate(context) {
    console.log("Extension activated");
    const provider = new CustomSidebarViewProvider(context.extensionUri);
    context.subscriptions.push(vscode.window.registerWebviewViewProvider(CustomSidebarViewProvider.viewType, provider));
    let _statusBarItem;
    let errorLensEnabled = true;
    // Use the console to output diagnostic information (console.log) and errors (console.error)
    // console.log('Visual Studio Code Extension "errorlens" is now active');
    // Commands are defined in the package.json file
    let disposableEnableErrorLens = vscode.commands.registerCommand("ErrorLens.enable", () => {
        errorLensEnabled = true;
        const activeTextEditor = vscode.window.activeTextEditor;
        if (activeTextEditor) {
            updateDecorationsForUri(activeTextEditor.document.uri);
        }
    });
    context.subscriptions.push(disposableEnableErrorLens);
    let disposableDisableErrorLens = vscode.commands.registerCommand("ErrorLens.disable", () => {
        errorLensEnabled = false;
        const activeTextEditor = vscode.window.activeTextEditor;
        if (activeTextEditor) {
            updateDecorationsForUri(activeTextEditor.document.uri);
        }
    });
    context.subscriptions.push(disposableDisableErrorLens);
    vscode.languages.onDidChangeDiagnostics((diagnosticChangeEvent) => {
        onChangedDiagnostics(diagnosticChangeEvent);
    }, null, context.subscriptions);
    // Note: URIs for onDidOpenTextDocument() can contain schemes other than file:// (such as git://)
    vscode.workspace.onDidOpenTextDocument((textDocument) => {
        updateDecorationsForUri(textDocument.uri);
    }, null, context.subscriptions);
    // Update on editor switch.
    vscode.window.onDidChangeActiveTextEditor((textEditor) => {
        if (textEditor === undefined) {
            return;
        }
        updateDecorationsForUri(textEditor.document.uri);
    }, null, context.subscriptions);
    function onChangedDiagnostics(diagnosticChangeEvent) {
        if (!vscode.window) {
            return;
        }
        const activeTextEditor = vscode.window.activeTextEditor;
        if (!activeTextEditor) {
            return;
        }
        // Many URIs can change - we only need to decorate the active text editor
        for (const uri of diagnosticChangeEvent.uris) {
            // Only update decorations for the active text editor.
            if (uri.fsPath === activeTextEditor.document.uri.fsPath) {
                updateDecorationsForUri(uri);
                break;
            }
        }
    }
    function updateDecorationsForUri(uriToDecorate) {
        if (!uriToDecorate) {
            return;
        }
        // Only process "file://" URIs.
        if (uriToDecorate.scheme !== "file") {
            return;
        }
        if (!vscode.window) {
            return;
        }
        const activeTextEditor = vscode.window.activeTextEditor;
        if (!activeTextEditor) {
            return;
        }
        if (!activeTextEditor.document.uri.fsPath) {
            return;
        }
        let numErrors = 0;
        let numWarnings = 0;
        if (errorLensEnabled) {
            let aggregatedDiagnostics = {};
            let diagnostic;
            // Iterate over each diagnostic that VS Code has reported for this file. For each one, add to
            // a list of objects, grouping together diagnostics which occur on a single line.
            for (diagnostic of vscode.languages.getDiagnostics(uriToDecorate)) {
                let key = "line" + diagnostic.range.start.line;
                if (aggregatedDiagnostics[key]) {
                    // Already added an object for this key, so augment the arrayDiagnostics[] array.
                    aggregatedDiagnostics[key].arrayDiagnostics.push(diagnostic);
                }
                else {
                    // Create a new object for this key, specifying the line: and a arrayDiagnostics[] array
                    aggregatedDiagnostics[key] = {
                        line: diagnostic.range.start.line,
                        arrayDiagnostics: [diagnostic],
                    };
                }
                switch (diagnostic.severity) {
                    case 0:
                        numErrors += 1;
                        break;
                    case 1:
                        numWarnings += 1;
                        break;
                    // Ignore other severities.
                }
            }
        }
    }
}
exports.activate = activate;
class CustomSidebarViewProvider {
    constructor(_extensionUri) {
        this._extensionUri = _extensionUri;
    }
    resolveWebviewView(webviewView, context, token) {
        this._view = webviewView;
        webviewView.webview.options = {
            // Allow scripts in the webview
            enableScripts: true,
            localResourceRoots: [this._extensionUri],
        };
        // default webview will show doom face 0
        webviewView.webview.html = this.getHtmlContent0(webviewView.webview);
        // This is called every second is decides which doom face to show in the webview
        setInterval(() => {
            let errors = getNumErrors();
            if (errors === 0) {
                webviewView.webview.html = this.getHtmlContent0(webviewView.webview);
            }
            else if (errors < 5) {
                webviewView.webview.html = this.getHtmlContent1(webviewView.webview);
            }
            else if (errors < 10) {
                webviewView.webview.html = this.getHtmlContent2(webviewView.webview);
            }
            else {
                webviewView.webview.html = this.getHtmlContent3(webviewView.webview);
            }
        }, 1000);
    }
    // This is doom face 0
    getHtmlContent0(webview) {
        const stylesheetUri = webview.asWebviewUri(vscode.Uri.joinPath(this._extensionUri, "assets", "main.css"));
        const face0 = webview.asWebviewUri(vscode.Uri.joinPath(this._extensionUri, "assets", "incredible0.png"));
        return getHtml(face0);
    }
    // This is doom face 1
    getHtmlContent1(webview) {
        const stylesheetUri = webview.asWebviewUri(vscode.Uri.joinPath(this._extensionUri, "assets", "main.css"));
        const face1 = webview.asWebviewUri(vscode.Uri.joinPath(this._extensionUri, "assets", "incredible1.png"));
        return getHtml(face1);
    }
    // This is doom face 2
    getHtmlContent2(webview) {
        const stylesheetUri = webview.asWebviewUri(vscode.Uri.joinPath(this._extensionUri, "assets", "main.css"));
        const face2 = webview.asWebviewUri(vscode.Uri.joinPath(this._extensionUri, "assets", "incredible2.png"));
        return getHtml(face2);
    }
    // This is doom face 3
    getHtmlContent3(webview) {
        const stylesheetUri = webview.asWebviewUri(vscode.Uri.joinPath(this._extensionUri, "assets", "main.css"));
        const face3 = webview.asWebviewUri(vscode.Uri.joinPath(this._extensionUri, "assets", "incredible3.png"));
        return getHtml(face3);
    }
}
CustomSidebarViewProvider.viewType = "in-your-face.openview";
function getHtml(doomFace) {
    return `
    <!DOCTYPE html>
			<html lang="en">
			<head>

			</head>

			<body>
			<section class="wrapper">
      <img class="doomFaces" src="${doomFace}" alt="" >
      <h1 id="errorNum">${getNumErrors() + " errors"}</h1>
			</section>
      </body>

		</html>
  `;
}
// function to get the number of errors in the open file
function getNumErrors() {
    const activeTextEditor = vscode.window.activeTextEditor;
    if (!activeTextEditor) {
        return 0;
    }
    const document = activeTextEditor.document;
    let numErrors = 0;
    let numWarnings = 0;
    let aggregatedDiagnostics = {};
    let diagnostic;
    // Iterate over each diagnostic that VS Code has reported for this file. For each one, add to
    // a list of objects, grouping together diagnostics which occur on a single line.
    for (diagnostic of vscode.languages.getDiagnostics(document.uri)) {
        let key = "line" + diagnostic.range.start.line;
        if (aggregatedDiagnostics[key]) {
            // Already added an object for this key, so augment the arrayDiagnostics[] array.
            aggregatedDiagnostics[key].arrayDiagnostics.push(diagnostic);
        }
        else {
            // Create a new object for this key, specifying the line: and a arrayDiagnostics[] array
            aggregatedDiagnostics[key] = {
                line: diagnostic.range.start.line,
                arrayDiagnostics: [diagnostic],
            };
        }
        switch (diagnostic.severity) {
            case 0:
                numErrors += 1;
                break;
            case 1:
                numWarnings += 1;
                break;
            // Ignore other severities.
        }
    }
    return numErrors;
}
// this method is called when your extension is deactivated
function deactivate() { }
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map