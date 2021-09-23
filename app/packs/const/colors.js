const colors = require('../../../colors.json')

// Prepare colors for usage in tailwind config and as css variables
const tailwindConfig = {}
const cssVariables = {}

for (let [colorName, shades] of Object.entries(colors)) {
  let tailwindColor = {}

  if (typeof shades === 'string') shades = { DEFAULT: shades }

  for (let [shade, color] of Object.entries(shades)) {
    const variableName = `--color-${colorName}-${shade}`
    tailwindColor[shade] = `var(${variableName})`
    cssVariables[variableName] = color
  }

  tailwindConfig[colorName] = tailwindColor
}

// We use commonjs to be compatible with both node and webpack
module.exports = {
  colors,
  tailwindConfig,
  cssVariables,
}
