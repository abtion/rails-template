// This file uses js and commonjs to be compatible with tailwind config

/* eslint-disable @typescript-eslint/no-var-requires */
const colors = require("../../../colors.json")
const prepareColorVariables = require("../util/prepareColorVariables")
/* eslint-enable @typescript-eslint/no-var-requires */

// Prepare colors for usage in tailwind config and as css variables
const { cssVariables, tailwindConfig } = prepareColorVariables(colors)

module.exports = {
  colors,
  cssVariables,
  tailwindConfig,
}
