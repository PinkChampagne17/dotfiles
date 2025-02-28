if ("./Brewfile" | path exists) {
	rm ./Brewfile
}

brew bundle dump

let keywordsToExclude = [
	"android-studio"
	"cocoapods"
	"cursor"
	"vscode"
	"watchman"
	"wireshark"
	"Xcode"
	"zulu"
]

let editedContent = open ./Brewfile |
	lines |
	filter { |line| not ( $keywordsToExclude | any { |keyword| $line | str contains $keyword }) }

$editedContent | save -f ./Brewfile
