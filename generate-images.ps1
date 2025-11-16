Add-Type -AssemblyName System.Drawing

function New-GradientImage {
    param (
        [string]$Path,
        [int]$Width,
        [int]$Height,
        [string]$Headline,
        [string]$Subtitle,
        [System.Drawing.Color]$StartColor = [System.Drawing.Color]::FromArgb(37,99,235),
        [System.Drawing.Color]$EndColor = [System.Drawing.Color]::FromArgb(30,64,175)
    )

    $bitmap = New-Object System.Drawing.Bitmap($Width, $Height)
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit

    $rect = New-Object System.Drawing.Rectangle(0, 0, $Width, $Height)
    $brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush($rect, $StartColor, $EndColor, 45)
    $graphics.FillRectangle($brush, 0, 0, $Width, $Height)

    $headlineFontSize = [Math]::Max([Math]::Round($Width * 0.08), 32)
    $subtitleFontSize = [Math]::Max([Math]::Round($Width * 0.035), 18)

    $headlineFont = New-Object System.Drawing.Font('Segoe UI', $headlineFontSize, [System.Drawing.FontStyle]::Bold)
    $subtitleFont = New-Object System.Drawing.Font('Segoe UI', $subtitleFontSize, [System.Drawing.FontStyle]::Regular)

    $graphics.DrawString($Headline, $headlineFont, [System.Drawing.Brushes]::White, 0.08 * $Width, 0.3 * $Height)
    if ($Subtitle) {
        $graphics.DrawString($Subtitle, $subtitleFont, [System.Drawing.Brushes]::WhiteSmoke, 0.08 * $Width, 0.55 * $Height)
    }

    $directory = Split-Path $Path
    if ($directory -and -not (Test-Path $directory)) {
        New-Item -ItemType Directory -Path $directory | Out-Null
    }

    $bitmap.Save($Path, [System.Drawing.Imaging.ImageFormat]::Png)

    $headlineFont.Dispose()
    $subtitleFont.Dispose()
    $graphics.Dispose()
    $brush.Dispose()
    $bitmap.Dispose()
}

New-GradientImage -Path "assets/og-image.png" -Width 1200 -Height 630 -Headline "sqft → sqm" -Subtitle "Instant area conversion calculator"
New-GradientImage -Path "icons/icon-512.png" -Width 512 -Height 512 -Headline "S ↔ M" -Subtitle ""
New-GradientImage -Path "icons/icon-192.png" -Width 192 -Height 192 -Headline "S↔M" -Subtitle ""
