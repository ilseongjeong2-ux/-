$folder = "C:\Users\배훈기(HunkiBae)\Desktop\Html\dashbord-1"
Set-Location $folder

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $folder
$watcher.Filter = "*.html"
$watcher.NotifyFilter = [System.IO.NotifyFilters]::LastWrite
$watcher.EnableRaisingEvents = $true

Write-Host "Watching for changes... Press Ctrl+C to stop." -ForegroundColor Green

while ($true) {
    $result = $watcher.WaitForChanged([System.IO.WatcherChangeTypes]::Changed, 2000)
    if (-not $result.TimedOut) {
        Start-Sleep -Seconds 1
        Write-Host "Change detected. Pushing to GitHub..." -ForegroundColor Yellow
        git add .
        git commit -m "update"
        git push origin main
        Write-Host "Done." -ForegroundColor Cyan
    }
}
