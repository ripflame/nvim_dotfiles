# Stop execution on error
$ErrorActionPreference = "Stop"

Write-Output "Starting Neovim setup for Windows..."

# Get the script's directory (assuming it's inside the repo)
$RepoDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ConfigPath = "$env:LOCALAPPDATA\nvim"
$LazyPath = "$env:LOCALAPPDATA\nvim-data\lazy\lazy.nvim"

# Install Scoop if missing
if (-Not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Output "Scoop not found. Installing..."
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
    # Add main bucket
    scoop bucket add main
}

# Install dependencies using Scoop
Write-Output "Checking dependencies..."
$packages = @("neovim", "git", "ripgrep", "fd")

foreach ($pkg in $packages) {
    if (-Not (scoop list $pkg -q)) {
        Write-Output "Installing $pkg..."
        scoop install $pkg
    } else {
        Write-Output "$pkg is already installed."
    }
}

# Backup existing Neovim config if present
if (Test-Path $ConfigPath) {
    Write-Output "Existing Neovim config found. Backing up..."
    Rename-Item -Path $ConfigPath -NewName "$ConfigPath.bak" -Force
}

# Create symbolic link to the repo's nvim config
Write-Output "Linking Neovim config..."
New-Item -ItemType SymbolicLink -Path $ConfigPath -Target "$RepoDir\nvim" -Force

# Install lazy.nvim if not already installed
if (-Not (Test-Path $LazyPath)) {
    Write-Output "Installing lazy.nvim..."
    git clone --depth 1 https://github.com/folke/lazy.nvim.git $LazyPath
}

Write-Output "Neovim setup complete!"
