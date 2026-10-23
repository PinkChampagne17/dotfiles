$env.config.abbreviations = {
	cwd: "code ."
	md: "mkdir"
	ni: "touch"
	pn: "pnpm"
	pi: "pnpm i"
	px: "pnpm exec"
	zwd: (match $nu.os-info.name {
		"linux" => "zeditor .",
		_ => "zed .",
	})
	pnl: "git restore -SW pnpm-lock.yaml; pnpm i --lockfile-only; pnpm dedupe --lockfile-only; git add pnpm-lock.yaml"
	pipd: "pnpm i; pnpm dev"
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
