# Stop execution on error
$ErrorActionPreference = "Stop"

Write-Output " -----------------------------"
Write-Output "| Neovim Setup Script (Win)   |"
Write-Output " -----------------------------"

# Get the script's directory (assuming it's inside the repo)
$RepoDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ConfigPath = "$env:LOCALAPPDATA\nvim"
$LazyPath = "$env:LOCALAPPDATA\nvim-data\lazy\lazy.nvim"

# Function to check if a command exists
function Test-CommandExists {
    param ($command)
    $exists = $false
    try {
        if (Get-Command $command -ErrorAction Stop) {
            $exists = $true
        }
    } catch {
        $exists = $false
    }
    return $exists
}

# Install Scoop if missing
if (-Not (Test-CommandExists scoop)) {
    Write-Output "🔄 Scoop not found. Installing..."
    try {
        Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
        # Add main and extras buckets
        scoop bucket add main
        scoop bucket add extras
        scoop bucket add nerd-fonts
        scoop bucket add versions
    } catch {
        Write-Error "Failed to install Scoop. Error: $_"
        exit 1
    }
} else {
    Write-Output "✓ Scoop already installed"
}

# Install dependencies using Scoop
Write-Output "🔄 Checking dependencies..."
$packages = @("neovim", "git", "ripgrep", "fd", "nodejs-lts", "gcc", "fzf", "cmake", "make")

foreach ($pkg in $packages) {
    if (-Not (scoop list $pkg -q)) {
        Write-Output "  Installing $pkg..."
        scoop install $pkg
    } else {
        Write-Output "  ✓ $pkg is already installed"
    }
}

# Install Nerd Font
if (-Not (scoop list SauceCodePro-NF -q)) {
    Write-Output "🔄 Installing SauceCodePro Nerd Font..."
    scoop install SauceCodePro-NF
} else {
    Write-Output "✓ SauceCodePro Nerd Font already installed"
}

# Create undodir for persistent undo history
$UndoDir = "$env:LOCALAPPDATA\nvim-data\undodir"
if (-Not (Test-Path $UndoDir)) {
    Write-Output "🔄 Creating undodir for persistent undo history..."
    New-Item -ItemType Directory -Path $UndoDir -Force | Out-Null
}

# Backup existing Neovim config if present
if (Test-Path $ConfigPath) {
    if (-Not (Get-Item $ConfigPath).LinkType) {
        Write-Output "🔄 Existing Neovim config found. Backing up..."
        $backupName = "$ConfigPath.bak.$(Get-Date -Format 'yyyyMMddHHmmss')"
        Rename-Item -Path $ConfigPath -NewName $backupName -Force
        Write-Output "  Backup created at $backupName"
    } else {
        Write-Output "🔄 Removing existing symlink..."
        Remove-Item -Path $ConfigPath -Force
    }
}

# Create parent directories if needed
$parentDir = Split-Path -Parent $ConfigPath
if (-Not (Test-Path $parentDir)) {
    New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
}

# Create symbolic link to the repo's nvim config
Write-Output "🔄 Linking Neovim config..."
try {
    New-Item -ItemType SymbolicLink -Path $ConfigPath -Target "$RepoDir\nvim" -Force
} catch {
    Write-Warning "Failed to create symbolic link. Trying with Admin permissions..."
    Start-Process powershell -ArgumentList "-Command New-Item -ItemType SymbolicLink -Path $ConfigPath -Target '$RepoDir\nvim' -Force" -Verb RunAs
}

# Install lazy.nvim if not already installed
if (-Not (Test-Path $LazyPath)) {
    Write-Output "🔄 Installing lazy.nvim..."
    git clone --filter=blob:none --branch=stable https://github.com/folke/lazy.nvim.git $LazyPath
}

Write-Output "✅ Neovim setup complete!"
Write-Output "🚀 Launch Neovim by typing 'nvim' to automatically install plugins"
Write-Output "NOTE: On first launch, Mason will automatically install LSP servers."
