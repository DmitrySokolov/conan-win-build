param(
  [string] $Path = '',
  [string] $Branch = 'origin/release/2.19',
  [switch] $WhatIf = $false
)

function Invoke-Cmd
{
    Write-Host "`n##  $($args -join ' ')`n"
    $a = @()
    if ($args.Count -ge 2) { $a = $args[1..($args.Count-1)] }
    if (-not $WhatIf) {
        & $args[0] @a
        if (-not $?) {
            Write-Host "Failed: $($args -join ' ')" -ForegroundColor Red
            exit 1
        }
    } else {
        Write-Host "Will perform the command $($args[0]) ..." -ForegroundColor DarkGray
    }
}


function Push-WD
{
  Push-Location $args[0]
  [Environment]::CurrentDirectory = $PWD
}


$needCheckout = $false

$conanDir = $PSScriptRoot
if ($Path.Length -gt 0) {
  $conanDir = $Path
}
if (-not (Test-Path "$conanDir\conan\__init__.py")) {
  $conanDir = "$conanDir\conan.git"
}
if (-not (Test-Path $conanDir)) {
  Invoke-Cmd  git clone https://github.com/conan-io/conan.git $conanDir
  $needCheckout = $true
}
if ($needCheckout -or (Test-Path "$conanDir\.git")) {
  Invoke-Cmd  git -C $conanDir checkout -B my_branch $Branch
}

$installerDir = "$conanDir\installer"
if (Test-Path $installerDir) {
  Invoke-Cmd  Remove-Item -Recurse $installerDir
}

Invoke-Cmd  New-Item $installerDir -ItemType Directory
Invoke-Cmd  Push-WD $installerDir
try {
  Invoke-Cmd  py -3 -m venv .venv
  Invoke-Cmd  .\.venv\Scripts\Activate.ps1
  Invoke-Cmd  pip install -U wheel pyinstaller
  Invoke-Cmd  pip install -U -r ..\conans\requirements.txt
  Invoke-Cmd  python ..\pyinstaller.py --onefile
}
finally {
  Invoke-Cmd  Pop-Location
}
