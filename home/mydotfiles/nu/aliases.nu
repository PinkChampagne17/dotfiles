alias cwd = code .
alias md = mkdir
alias ni = touch
alias pn = pnpm
alias pi = pn i
alias zwd = match $nu.os-info.name {
	"linux" => { zeditor . },
	_ => { zed . },
}

def pnl [] {
	git restore -SW pnpm-lock.yaml
	pnpm i --lockfile-only
	pnpm dedupe --lockfile-only
	git add pnpm-lock.yaml
}

def pipd [] {
	pi; pn dev;
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
