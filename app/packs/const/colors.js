const colors = require('../../../colors.json')

const tailwindConfig = {}
const cssVariables = {}

// Prepare colors for usage in tailwind config and as css variables
for (let [colorName, shades] of Object.entries(colors)) {
  let tailwindColor = {}

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
