# Module imports and initializations
if (-not (Get-Module -ListAvailable -Name Terminal-Icons)) {
    Install-Module -Name Terminal-Icons -Scope CurrentUser -Force -SkipPublisherCheck
}
Import-Module -Name Terminal-Icons

# Aliases
Set-Alias vim nvim
Set-Alias ll Get-ChildItem
Set-Alias -Name z -Value __zoxide_z -Option AllScope -Scope Global -Force
Set-Alias -Name zi -Value __zoxide_zi -Option AllScope -Scope Global -Force

# Functions
function rem($file) { Remove-Item -Force -Recurse $file }
function which($name) { Get-Command $name | Select-Object -ExpandProperty Definition }
function cp($file) { Copy-Item -Force -Recurse $file }
function profile { & $PROFILE }

# Git functions
$gitFunctions = @{
    gs   = { git status }
    gn   = { git init }
    gc   = { param($m) git commit -m $m }
    gp   = { git push }
    gcl  = { param($repo) git clone $repo }
    lazyg = {
        param($message)
        git add .
        git commit -m $message
        git push
    }
}

$gitFunctions.GetEnumerator() | ForEach-Object {
    Set-Item -Path Function:$($_.Key) -Value $_.Value
}

# Initializations
Invoke-Expression (& { (gh completion -s powershell | Out-String) })
Invoke-Expression (& { (zoxide init powershell --cmd cd --hook pwd | Out-String) })
Invoke-Expression (& { (oh-my-posh.exe init pwsh --config $env:USERPROFILE\.config\ohmyposh\base.toml | Out-String) })
