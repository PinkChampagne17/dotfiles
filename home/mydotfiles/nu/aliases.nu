alias cwd = code .
alias md = mkdir
alias ni = touch
alias grhu = git reset --hard @{u}
alias pn = pnpm
alias pi = pn i

def pipd [] {
	pi; pn dev;
}

def pips [] {
	pi; pn start;
}

def l [] {
	ls . | get name | grid
}

def ll [pattern: string = "."] {
	let baseColumns = [name type target readonly]
	let columns = match $nu.os-info.name {
		"windows" => $baseColumns,
		_ => [...$baseColumns mode user group],
	}

	ls -alms ($pattern | str replace -r "^~" $env.HOME) | select ...$columns
}

# Full term reset, cls, clear buffer, attributes off,
# https://github.com/nushell/nushell/issues/11693
def clear [] {
	$"(ansi esc)c(ansi clsb)(ansi cls)(ansi reset)(ansi home)"
}
