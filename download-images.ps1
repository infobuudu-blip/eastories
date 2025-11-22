# download-images.ps1
# Télécharge les images recommandées dans le dossier ./images
# Exécutez depuis le dossier du projet :
#   powershell.exe -ExecutionPolicy Bypass -File .\download-images.ps1

$images = @(
    @{ url = 'https://images.pexels.com/photos/1454360/pexels-photo-1454360.jpeg'; file = 'images/hero-campus.jpg' },
    @{ url = 'https://images.pexels.com/photos/733856/pexels-photo-733856.jpeg'; file = 'images/writing-close.jpg' },
    @{ url = 'https://images.pexels.com/photos/1157557/pexels-photo-1157557.jpeg'; file = 'images/confetti.jpg' },
    @{ url = 'https://images.pexels.com/photos/3762800/pexels-photo-3762800.jpeg'; file = 'images/student-smile.jpg' },
    @{ url = 'https://images.pexels.com/photos/3184163/pexels-photo-3184163.jpeg'; file = 'images/cv-review.jpg' }
)

Write-Host "Downloading images to ./images (will overwrite existing files with same name)" -ForegroundColor Cyan

foreach ($img in $images) {
    try {
        $url = $img.url
        $out = $img.file
        Write-Host "Downloading $url -> $out"
        Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing -Headers @{ 'User-Agent' = 'Mozilla/5.0' }
    } catch {
        Write-Warning "Failed to download $($img.url) : $($_.Exception.Message)"
    }
}

Write-Host "Done. You may optionally convert images to WebP with ImageMagick (if installed):" -ForegroundColor Green
Write-Host "magick convert images/hero-campus.jpg -quality 80 images/hero-campus.webp" -ForegroundColor DarkCyan
Write-Host "Tip: Resize or optimize images for production to reduce page weight." -ForegroundColor Yellow
