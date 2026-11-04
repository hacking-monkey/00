
Remove-Item -Path src/_data -Recurse -Force -ErrorAction SilentlyContinue
Get-ChildItem -Path src -Directory |
Remove-Item -Path { $_.FullName + "\toc.yml" } -ErrorAction SilentlyContinue
