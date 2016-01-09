Param ([string]$DEST = $HOME)
Write-Host "Destination - $DEST" -Foreground "green"

Set-Variable -Name CUR_DIR -Value (Get-Item -Path ".\" -Verbose).FullName
Set-Variable -Name BACKUP_DIR -Value "$CUR_DIR\backup"

if (!(Test-Path -Path $BACKUP_DIR)) {
    Write-Host "Create backup dir" -Foreground "yellow"
    New-Item -ItemType directory -Path $BACKUP_DIR > $null
}

# If destination exists backup it, then link destination to source.
#\param Source path.
#\param Destination path.
#\param Is destination directory or not. If it is directory then it will be
#       deleted instead of backuped.
function Backup-And-Link
{
    Param(
        [string]$s = $(throw "Source path required."),
        [string]$d = $(throw "Dest path required."),
        [switch]$isDir = $false
    )

    if (Test-Path -Path $d) {
        Write-Host "Backup $d" -Foreground "yellow"

        if ($isDir) {
            cmd /c rmdir $d
        } else {
            Move-Item $d $BACKUP_DIR -Force
        }
    }

    if ($isDir) {
        cmd /c mklink /d $d $s > $null
    } else {
        cmd /c mklink $d $s > $null
    }
}

Write-Host "Linking .bashrc" -Foreground "green"
Backup-And-Link -s "$CUR_DIR\shells\.bashrc" -d "$DEST\.bashrc"

Write-Host "Linking .zshrc" -Foreground "green"
Backup-And-Link -s "$CUR_DIR\shells\.zshrc" -d "$DEST\.zshrc"

Write-Host "Linking aliases" -Foreground "green"
Backup-And-Link -s "$CUR_DIR\shells\.my_aliases" -d "$DEST\.my_aliases"

Write-Host "Linking .tmux.conf" -Foreground "green"
Backup-And-Link -s "$CUR_DIR\.tmux.conf" -d "$DEST\.tmux.conf"

Write-Host "Linking .git*" -Foreground "green"
Backup-And-Link -s "$CUR_DIR\git\.gitconfig" -d "$DEST\.gitconfig"
Backup-And-Link -s "$CUR_DIR\git\.gitignore_global" -d "$DEST\.gitignore_global"

Write-Host "Linking vim" -Foreground "green"
Backup-And-Link -s "$CUR_DIR\editors\vim\.vimrc" -d "$DEST\.vimrc"
Backup-And-Link -s "$CUR_DIR\editors\vim\.vim" -d "$DEST\vimfiles" -isDir $true

#Write-Host "Installing vim plugins" -Foreground "green"
#git submodule init && git submodule update

