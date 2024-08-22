# Ensure Terminal-Icons module is installed before importing
if (-not (Get-Module -ListAvailable -Name Terminal-Icons)) {
    Install-Module -Name Terminal-Icons -Scope CurrentUser -Force -SkipPublisherCheck }
Import-Module -Name Terminal-Icons

# Aliases & Functions
Set-Alias -Name vim -Value nvim
function rem($file) {
    Remove-Item -Force -Recurse $file
}
function which($name) {
    Get-Command $name | Select-Object -ExpandProperty Definition
}
function ll { Get-ChildItem -Path $pwd }
#
# Git Shortcuts
function gs { git status }

function gn { git init }

function ga { git add . }

function gc { param($m) git commit -m "$m" }

function gp { git push }

function g { __zoxide_z github }

function gcl { git clone "$args" }

function gcom {
    git add .
    git commit -m "$args"
}
function lazyg {
    git add .
    git commit -m "$args"
    git push
}

Invoke-Expression (& { (zoxide init powershell --cmd cd --hook pwd | Out-String) })
Set-Alias -Name z -Value __zoxide_z -Option AllScope -Scope Global -Force
Set-Alias -Name zi -Value __zoxide_zi -Option AllScope -Scope Global -Force

# the prompt

$env:POSH_GIT_ENABLED = $true
$previousOutputEncoding = [Console]::OutputEncoding
[Console]::OutputEncoding = [Text.Encoding]::UTF8
try {
    oh-my-posh.exe init pwsh --config $env:USERPROFILE\.config\ohmyposh\base.toml | Invoke-Expression
} finally {
    [Console]::OutputEncoding = $previousOutputEncoding
}
