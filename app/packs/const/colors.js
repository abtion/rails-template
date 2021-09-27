// This file uses js and commonjs to be compatible with tailwind config

/* eslint-disable @typescript-eslint/no-var-requires */
const colors = require("../../../colors.json")
const getContrastColor = require("../util/getContrastColor")
/* eslint-enable @typescript-eslint/no-var-requires */

// Prepare colors for usage in tailwind config and as css variables
const tailwindConfig = {}
const cssVariables = {}

for (let [colorName, shades] of Object.entries(colors)) {
  let tailwindColor = {}
  let colorHasShades = true

  if (typeof shades === "string") {
    shades = { DEFAULT: shades }
    colorHasShades = false
  }

  for (let [shade, color] of Object.entries(shades)) {
    let variableName = `--color-${colorName}`
    if (shade !== "DEFAULT") variableName += `-${shade}`

    tailwindColor[shade] = `var(${variableName})`
    cssVariables[variableName] = color

    // Find contrast colors only for colors with shades, and not for manually specified contrast colors
    const shadeIsContrastColor = /^(.+-|)contrast$/.test(shade)
    if (!colorHasShades || shadeIsContrastColor) continue

    const contrastVariantName =
      shade === "DEFAULT" ? "contrast" : `${shade}-contrast`

    // If a color has a manually specified contrast color, don't compute one
    if (shades[contrastVariantName] !== undefined) continue

    const contrastColor = getContrastColor(color, colors.dark, colors.light)
    const contrastVariableName =
      contrastColor === colors.dark ? "--color-dark" : "--color-light"

    if (shade === "DEFAULT") {
      tailwindColor["contrast"] = `var(${contrastVariableName})`
    } else {
      tailwindColor[`${shade}-contrast`] = `var(${contrastVariableName})`
    }
  }

  tailwindConfig[colorName] = tailwindColor
}

module.exports = {
  colors,
  tailwindConfig,
  cssVariables,
}
