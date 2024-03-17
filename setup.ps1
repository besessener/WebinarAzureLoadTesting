$Env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$missingTools = @()

if (-Not (Get-Command 'code' -ErrorAction SilentlyContinue)) {
  $missingTools += 'vscode'
}

if (-Not (Get-Command 'python' -ErrorAction SilentlyContinue)) {
  $missingTools += 'python310'
}

if (-Not (Get-Command 'az' -ErrorAction SilentlyContinue)) {
  $missingTools += 'azure-cli'
}

if (-Not (Get-Command 'jmeter' -ErrorAction SilentlyContinue)) {
  $missingTools += 'jmeter'
}

if (-Not (Get-Command 'scoop' -ErrorAction SilentlyContinue)) {
  [Environment]::SetEnvironmentVariable("SCOOP", "C:\scoop", "User")
  $Env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
  irm get.scoop.sh | iex
  scoop config autostash_on_conflict $true
}

if ($missingTools) {
  scoop bucket add extras
  scoop bucket add versions
  
  Write-Host "Installing: $missingTools"
  scoop install $missingTools
}

$Env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
python3 -m venv .venv
.\.venv\Scripts\activate
python -m pip install -r .\automation\requirements.txt
deactivate

$extensions = (Get-Content .vscode/extensions.json | ConvertFrom-Json).recommendations

foreach ($extension in $extensions) {
  code --install-extension $extension
}

Push-Location .\presentation
npm install
Pop-Location

Write-Host "Setup completed."