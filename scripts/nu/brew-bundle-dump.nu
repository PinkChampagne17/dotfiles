if ("./Brewfile" | path exists) {
	rm ./Brewfile
}

brew bundle dump

let editedContent = open ./Brewfile |
	lines |
	filter { not ($in | str starts-with "vscode") }

$editedContent | save -f ./Brewfile
