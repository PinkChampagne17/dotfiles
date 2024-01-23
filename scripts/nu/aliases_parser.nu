#!/usr/bin/env nu

echo "aliase_parser.nu is running..."

let aliases_to_exclude = [ll]

open ./home/mydotfiles/sh/aliases.sh |
    str replace -r "#.*" "" | # Remove comments
    str replace --all -r "if(.*\n)*fi" "" | # Remove if statements
    str replace --all  "\"" "" | # Remove double quotes
	str replace --all  "&&" ";" | # Convert the syntax
    str trim |
    split row "\n" |
    parse 'alias {name}={expansion}' |
	filter { $in.name not-in $aliases_to_exclude} |
    each { $"alias ($in.name) = ($in.expansion)" } |
	save -f ./home/mydotfiles/nu/aliases.nu
