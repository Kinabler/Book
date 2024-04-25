Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Hàm để chụp màn hình và lưu thành tập tin ảnh trong thư mục cụ thể
function CaptureScreen {
    $folderPath = "C:\Users\$env:USERNAME\Music\Mydata\"
    
    # Kiểm tra xem thư mục đã tồn tại chưa
    if (-not (Test-Path $folderPath)) {
        # Nếu thư mục chưa tồn tại, tạo mới
        New-Item -Path $folderPath -ItemType Directory -Force
    }

    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $filename = "$folderPath\screenshot_$timestamp.png"

    $bitmap = New-Object System.Drawing.Bitmap([System.Windows.Forms.Screen]::PrimaryScreen.Bounds.width, [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.height)
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    $graphics.CopyFromScreen([System.Windows.Forms.Screen]::PrimaryScreen.Bounds.X, [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Y, 0, 0, $bitmap.Size)
    $graphics.Dispose()
    $bitmap.Save($filename, [System.Drawing.Imaging.ImageFormat]::Png)
    $bitmap.Dispose()
    Write-Host "Screenshot saved as '$filename'"
}

# Gọi hàm chụp màn hình
CaptureScreen
