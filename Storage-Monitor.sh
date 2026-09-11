
# 1. GATHER DATA: Query the C: drive storage properties
$Drive = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DeviceID='C:'"
$TotalSpace = $Drive.Size
$FreeSpace = $Drive.FreeSpace

# Calculate current usage percentage
$UsedPercent = [Math]::Round((($TotalSpace - $FreeSpace) / $TotalSpace) * 100)
$Threshold = 80

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "🎬 WINDOWS INFRASTRUCTURE: MEDIA STORAGE MONITOR ACTIVE"
Write-Host "Current Drive C: Utilization: $UsedPercent%"
Write-Host "==========================================================" -ForegroundColor Cyan

# 2. CONDITIONAL LOGIC & ACTION
if ($UsedPercent -gt $Threshold) {
    Write-Host "🚨 [CRITICAL ALERT] Media scratch disk space is running out!" -ForegroundColor Red
    $LogPath = "$Home\Desktop\Storage_Alert.txt"
    "[$(Get-Date)] CRITICAL: Storage space is dangerously low at $UsedPercent%." | Out-File -FilePath $LogPath -Append
    Write-Host "👉 Alert log generated successfully at: $LogPath"
} else {
    Write-Host "✅ Drive storage capacity is healthy. Video rendering safe." -ForegroundColor Green
}
