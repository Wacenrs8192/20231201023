Write-Host "=== GitHub Auto Commit Script ===" -ForegroundColor Green
Write-Host "Setting up Git and committing to GitHub automatically..." -ForegroundColor Yellow
Write-Host ""

# Check if Git is installed
function Test-GitInstalled {
    try {
        $gitVersion = git --version 2>$null
        return $true
    } catch {
        return $false
    }
}

# Function to install Git
function Install-Git {
    Write-Host "Git not detected, downloading Git..." -ForegroundColor Yellow
    
    # Download Git installer
    $gitInstallerUrl = "https://github.com/git-for-windows/git/releases/download/v2.45.1.windows.1/Git-2.45.1-64-bit.exe"
    $installerPath = "$env:TEMP\git-installer.exe"
    
    Write-Host "Downloading Git installer..." -ForegroundColor Yellow
    try {
        Invoke-WebRequest -Uri $gitInstallerUrl -OutFile $installerPath
        Write-Host "Download complete, installing Git..." -ForegroundColor Green
        
        # Silent install Git
        Start-Process -FilePath $installerPath -ArgumentList "/VERYSILENT", "/NORESTART", "/NOCANCEL", "/SP", "/CLOSEAPPLICATIONS", "/COMPONENTS=""icons,ext\shellhere,ext\guihere,assoc,assoc_sh""" -Wait
        Write-Host "Git installation completed!" -ForegroundColor Green
        
        # Add Git to PATH
        $gitPath = "C:\Program Files\Git\bin"
        if (-not ($env:PATH -contains $gitPath)) {
            $env:PATH += ";$gitPath"
            [Environment]::SetEnvironmentVariable("PATH", $env:PATH, [EnvironmentVariableTarget]::User)
        }
        
        return $true
    } catch {
        Write-Host "Git installation failed, please install manually: https://git-scm.com/download/win" -ForegroundColor Red
        return $false
    }
}

# Configure Git
function Configure-Git {
    Write-Host "Configuring Git user info..." -ForegroundColor Yellow
    
    # Set global configuration
    git config --global user.name "Wacenrs8192"
    git config --global user.email "wacenrs8192@users.noreply.github.com"
    git config --global init.defaultBranch "main"
    
    Write-Host "Git configuration completed" -ForegroundColor Green
}

# Initialize Git repository and commit
function Initialize-GitRepository {
    Write-Host "Initializing Git repository..." -ForegroundColor Yellow
    
    # Initialize Git
    git init
    
    # Add all files
    git add .
    
    # Commit changes
    git commit -m "Initial commit: Django Developer Info Project - Chen Yiming 20231201023"
    
    Write-Host "Local commit completed" -ForegroundColor Green
}

# Connect to GitHub repository
function Connect-ToGitHub {
    param(
        [string]$repoUrl = "https://github.com/Wacenrs8192/20231201023.git"
    )
    
    Write-Host "Connecting to GitHub repository..." -ForegroundColor Yellow
    
    # Add remote repository
    git remote add origin $repoUrl
    
    # Verify connection
    $remotes = git remote -v
    Write-Host "Remote repository configuration:" -ForegroundColor Cyan
    Write-Host $remotes
}

# Push to GitHub
function Push-ToGitHub {
    Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
    
    try {
        # Try to push
        git push -u origin main
        Write-Host "Push successful!" -ForegroundColor Green
        Write-Host "Visit: https://github.com/Wacenrs8192/20231201023" -ForegroundColor Cyan
        return $true
    } catch {
        Write-Host "Push failed, may need to handle conflicts or permissions" -ForegroundColor Red
        Write-Host "Please check:" -ForegroundColor Yellow
        Write-Host "1. Ensure you have write permissions to the repository" -ForegroundColor Yellow
        Write-Host "2. Or pull changes first: git pull origin main --allow-unrelated-histories" -ForegroundColor Yellow
        return $false
    }
}

# Main execution flow
Write-Host "Step 1: Checking Git installation..." -ForegroundColor Cyan
if (-not (Test-GitInstalled)) {
    Write-Host "Git not installed, starting installation..." -ForegroundColor Yellow
    $installSuccess = Install-Git
    if (-not $installSuccess) {
        Write-Host "Please install Git manually and run this script again" -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit 1
    }
} else {
    Write-Host "Git is already installed" -ForegroundColor Green
}

Write-Host "Step 2: Configuring Git..." -ForegroundColor Cyan
Configure-Git

Write-Host "Step 3: Initializing repository..." -ForegroundColor Cyan
Initialize-GitRepository

Write-Host "Step 4: Connecting to GitHub..." -ForegroundColor Cyan
Connect-ToGitHub

Write-Host "Step 5: Pushing to GitHub..." -ForegroundColor Cyan
$pushSuccess = Push-ToGitHub

if ($pushSuccess) {
    Write-Host ""
    Write-Host "🎉 GitHub commit completed!" -ForegroundColor Green
    Write-Host "Project successfully committed to: https://github.com/Wacenrs8192/20231201023" -ForegroundColor Cyan
} else {
    Write-Host ""
    Write-Host "⚠️  Manual GitHub push handling required" -ForegroundColor Yellow
    Write-Host "Please run the following commands to complete the push:" -ForegroundColor Yellow
    Write-Host "git pull origin main --allow-unrelated-histories" -ForegroundColor White
    Write-Host "git push -u origin main" -ForegroundColor White
}

Write-Host ""
Write-Host "Current Django server status:" -ForegroundColor Cyan
Write-Host "Running: http://127.0.0.1:8000/developer/" -ForegroundColor Green
Write-Host "Contains: Chen Yiming (20231201023) developer information" -ForegroundColor Green

Read-Host "Press Enter to exit"