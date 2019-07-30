# JPG PowerShell profile

Write-Host -ForegroundColor Magenta "PowerShell Core: Stranger in a Strange Land`n"
Import-Module posh-git

# Fix colors for visibility with my iTerm2 color scheme
Set-PSReadlineOption -Colors @{
    "Operator" = [ConsoleColor]::Magenta
    "Parameter" = [ConsoleColor]::Magenta
}
