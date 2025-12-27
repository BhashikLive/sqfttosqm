// Conversion factors to square meters
const conversionFactors = {
    sqft: 0.092903,      // Square feet to square meters
    sqm: 1,              // Square meters (base unit)
    sqyd: 0.836127,      // Square yards to square meters
    sqin: 0.00064516,    // Square inches to square meters
    acre: 4046.86,       // Acres to square meters
    hectare: 10000       // Hectares to square meters
};

// DOM Elements
const fromValue = document.getElementById('fromValue');
const toValue = document.getElementById('toValue');
const fromUnit = document.getElementById('fromUnit');
const toUnit = document.getElementById('toUnit');
const swapBtn = document.getElementById('swapBtn');
const convertBtn = document.getElementById('convertBtn');
const resultDisplay = document.getElementById('resultDisplay');
const currentYear = document.getElementById('currentYear');

// Initialize - perform initial conversion
window.addEventListener('DOMContentLoaded', () => {
    convert();
    if (currentYear) {
        currentYear.textContent = new Date().getFullYear();
    }
});

// Convert function
function convert() {
    const inputValue = parseFloat(fromValue.value);
    
    if (isNaN(inputValue) || inputValue < 0) {
        toValue.value = '';
        resultDisplay.classList.remove('show');
        resultDisplay.textContent = '';
        return;
    }

    const fromUnitValue = fromUnit.value;
    const toUnitValue = toUnit.value;

    // Convert to square meters first, then to target unit
    const valueInSquareMeters = inputValue * conversionFactors[fromUnitValue];
    const result = valueInSquareMeters / conversionFactors[toUnitValue];

    // Format result
    const formattedResult = formatNumber(result);
    toValue.value = formattedResult;

    // Display result message
    displayResult(inputValue, fromUnitValue, formattedResult, toUnitValue);
}

// Format number with appropriate decimal places
function formatNumber(num) {
    if (num === 0) return '0';
    
    // For very small numbers, use more decimal places
    if (Math.abs(num) < 0.01) {
        return num.toFixed(6).replace(/\.?0+$/, '');
    }
    
    // For small numbers, use 4 decimal places
    if (Math.abs(num) < 1) {
        return num.toFixed(4).replace(/\.?0+$/, '');
    }
    
    // For regular numbers, use 2 decimal places
    if (Math.abs(num) < 1000) {
        return num.toFixed(2).replace(/\.?0+$/, '');
    }
    
    // For large numbers, add comma separators
    return num.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

// Display result message
function displayResult(input, fromUnit, output, toUnit) {
    const unitNames = {
        sqft: 'square feet',
        sqm: 'square meters',
        sqyd: 'square yards',
        sqin: 'square inches',
        acre: 'acres',
        hectare: 'hectares'
    };

    resultDisplay.innerHTML = `${formatNumber(input)} ${unitNames[fromUnit]} = <strong>${output} ${unitNames[toUnit]}</strong>`;
    resultDisplay.classList.add('show');
    
    // Track the conversion event
    trackConversion(fromUnit, toUnit);
}

// Swap units
function swapUnits() {
    const tempUnit = fromUnit.value;
    fromUnit.value = toUnit.value;
    toUnit.value = tempUnit;

    const tempValue = fromValue.value;
    fromValue.value = toValue.value;
    
    convert();
}


// Event Listeners
fromUnit.addEventListener('change', convert);
toUnit.addEventListener('change', convert);
convertBtn.addEventListener('click', convert);
swapBtn.addEventListener('click', swapUnits);

// Allow Enter key to trigger conversion
fromValue.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') {
        convert();
    }
});

// Real-time conversion with validation
fromValue.addEventListener('input', () => {
    if (fromValue.value < 0) {
        fromValue.value = Math.abs(fromValue.value);
    }
    convert();
});

// Smooth scroll behavior and section tracking
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            const sectionName = target.id || 'unknown';
            trackSectionView(sectionName);
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// Track conversion for analytics
function trackConversion(fromUnit, toUnit) {
    if (typeof gtag !== 'undefined') {
        gtag('event', 'area_conversion', {
            'event_category': 'calculator',
            'event_label': `${fromUnit}_to_${toUnit}`,
            'value': 1
        });
    }
}

// Track page section views
function trackSectionView(sectionName) {
    if (typeof gtag !== 'undefined') {
        gtag('event', 'page_section_view', {
            'event_category': 'engagement',
            'event_label': sectionName
        });
    }
}

// Add focus styles for accessibility
const inputs = document.querySelectorAll('input, select, button');
inputs.forEach(input => {
    input.addEventListener('focus', function() {
        this.style.outline = '2px solid #2563eb';
    });
    
    input.addEventListener('blur', function() {
        this.style.outline = 'none';
    });
});
