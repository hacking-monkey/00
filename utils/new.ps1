
[string]$uuid = [Guid]::NewGuid().ToString().SubString(2)

[string]$p = $uuid.Substring(0, 2)
[string]$pl = $uuid.Substring(2)

[string]$dir = "./src/$p/"

New-Item -ItemType Directory -Path $dir -Force > $null

[string]$path = "$dir$pl.md"

if (Test-Path -Path $path) {
  throw [System.IO.IOException]"Path already exists: $path"
}

$git_name = git config user.name 2>$null
if ([string]::IsNullOrWhiteSpace($git_name)) {
  $git_name = "new.ps1"
}

@"
---
title: 00$uuid
description:
author: $git_name
license: CC BY 4.0
create_at: $(Get-Date -Format "yyyy-MM-dd")
---

##
"@ | Set-Content -Path $path -Encoding utf8

[string]$Global:path = $path
Write-Host $path
