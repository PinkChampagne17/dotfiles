$proxy = "127.0.0.1:7897"

# Install scoop
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
scoop config proxy $proxy

scoop bucket add extras
scoop install fancontrol

nvm install lts
nvm use lts
npm config set proxy "http://$proxy"
npm config set https-proxy "http://$proxy"
corepack enable

pnpm i -g tldr
pnpm i -g @ast-grep/cli
