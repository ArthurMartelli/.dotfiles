$Programs =
"alexcvzz.vscode-sqlite",
"batisteo.vscode-django",
"chrmarti.regex",
"DavidAnson.vscode-markdownlint",
"donjayamanne.python-environment-manager",
"donjayamanne.python-extension-pack",
"eamodio.gitlens",
"fnando.linter",
"frhtylcn.pythonsnippets",
"GitHub.github-vscode-theme",
"KevinRose.vsc-python-indent",
"marcbruederlin.mint-theme",
"marp-team.marp-vscode",
"mblode.zotero",
"ms-azuretools.vscode-docker",
"ms-python.python",
"ms-python.vscode-pylance",
"ms-vscode-remote.remote-containers",
"njpwerner.autodocstring",
"oderwat.indent-rainbow",
"ritwickdey.LiveServer",
"sasa.vscode-sass-format",
"syler.sass-indented",
"tomoki1207.pdf",
"Tyriar.lorem-ipsum",
"VisualStudioExptTeam.vscodeintellicode",
"vscode-icons-team.vscode-icons",
"wholroyd.jinja",
"yzhang.markdown-all-in-one"

foreach ($programItem in $Programs) {
    code --install-extension $programItem
}