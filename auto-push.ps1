$folder = "C:\Users\배훈기(HunkiBae)\Desktop\Html\dashbord-1"
Set-Location $folder

$file = Get-ChildItem "$folder\*.html" | Select-Object -First 1
$lastWrite = $file.LastWriteTime

Write-Host "Watching for changes... Press Ctrl+C to stop." -ForegroundColor Green

while ($true) {
    Start-Sleep -Seconds 3
    $file = Get-ChildItem "$folder\*.html" | Select-Object -First 1
    $current = $file.LastWriteTime
    if ($current -ne $lastWrite) {
        $lastWrite = $current
        Write-Host "Change detected. Pushing to GitHub..." -ForegroundColor Yellow
        git add .
        git commit -m "update"
        git push origin main
        Write-Host "Done." -ForegroundColor Cyan
    }
}
