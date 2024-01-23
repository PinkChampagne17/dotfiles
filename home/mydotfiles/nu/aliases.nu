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

alias core-ls = ls

def ls [pattern: string = "."] {
    core-ls -s $pattern | get name | grid
}

def ll [pattern: string = "."] {
	let baseColumns = [name type target readonly]
	let columns = match $nu.os-info.name {
		"windows" => $baseColumns,
		_ => [...$baseColumns mode user group],
	}
	core-ls -alms $pattern | select $columns
}
