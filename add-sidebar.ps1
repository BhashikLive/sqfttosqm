$sidebar = @"
    <main class="container">
        <!-- Two Column Layout -->
        <div class="page-layout">
            <!-- Left Sidebar -->
            <aside class="calculators-sidebar">
                <h2>All Calculators</h2>
                <nav class="sidebar-nav">
                    <a href="index.html" class="sidebar-link"><strong>sqft to sqm</strong><span>Square Feet to Meters</span></a>
                    <a href="sqm-to-sqft.html" class="sidebar-link"><strong>sqm to sqft</strong><span>Square Meters to Feet</span></a>
                    <a href="sqft-to-acres.html" class="sidebar-link"><strong>sqft to Acres</strong><span>Land measurement</span></a>
                    <a href="acres-to-sqft.html" class="sidebar-link"><strong>Acres to sqft</strong><span>Reverse conversion</span></a>
                    <a href="sqft-to-sqyd.html" class="sidebar-link"><strong>sqft to sqyd</strong><span>Square Feet to Yards (gaj)</span></a>
                    <a href="sqyd-to-sqft.html" class="sidebar-link"><strong>sqyd to sqft</strong><span>Yards to Feet (gaj)</span></a>
                    <a href="sqm-to-acres.html" class="sidebar-link"><strong>sqm to Acres</strong><span>Meters to Acres</span></a>
                    <a href="acres-to-sqm.html" class="sidebar-link"><strong>Acres to sqm</strong><span>Acres to Meters</span></a>
                    <a href="sqyd-to-sqm.html" class="sidebar-link"><strong>sqyd to sqm</strong><span>Yards to Meters</span></a>
                    <a href="land-area-calculator.html" class="sidebar-link"><strong>Land Calculator</strong><span>Plot area calculator</span></a>
                    <a href="house-area-calculator.html" class="sidebar-link"><strong>House Calculator</strong><span>Room area calculator</span></a>
                    <a href="carpet-vs-built-up-area.html" class="sidebar-link"><strong>Carpet vs Built-up</strong><span>RERA area guide</span></a>
                </nav>
            </aside>
            <div class="main-content">
"@

$files = @{
    'sqm-to-acres.html' = 'sqm-to-acres.html'
    'acres-to-sqm.html' = 'acres-to-sqm.html'
    'sqft-to-sqyd.html' = 'sqft-to-sqyd.html'
    'sqyd-to-sqft.html' = 'sqyd-to-sqft.html'
    'sqyd-to-sqm.html' = 'sqyd-to-sqm.html'
    'land-area-calculator.html' = 'land-area-calculator.html'
    'house-area-calculator.html' = 'house-area-calculator.html'
    'carpet-vs-built-up-area.html' = 'carpet-vs-built-up-area.html'
}

foreach ($file in $files.Keys) {
    if (Test-Path $file) {
        $content = Get-Content $file -Raw
        
        # Replace opening
        $content = $content -replace '(\s*<main class="container">)\s*<div class="calculator-card">', "`$1`n$sidebar`n        <div class=`"calculator-card`""
        
        # Replace closing
        $content = $content -replace '</article>\s*</main>', "</article>`n        </div></div>`n    </main>"
        
        # Add active class
        $activeLink = $files[$file]
        $content = $content -replace "href=`"$activeLink`" class=`"sidebar-link`"", "href=`"$activeLink`" class=`"sidebar-link active`""
        
        $content | Set-Content $file -Encoding UTF8
        Write-Host "Updated: $file" -ForegroundColor Green
    }
}

Write-Host "`nAll pages updated with sidebar!" -ForegroundColor Cyan
