// This file uses js and commonjs to be compatible with tailwind config

// eslint-disable-next-line @typescript-eslint/no-var-requires, @typescript-eslint/no-require-imports
const getLuminance = require("./getLuminance")

// Based on luminance, pick the best suited contrast color (dark/light) to the target color
module.exports = function getContrastColor(target, dark, light) {
  const targetLuminance = getLuminance(target)
  const darkLuminance = getLuminance(dark)
  const lightLuminance = getLuminance(light)

  const darkDiff = Math.abs(targetLuminance - darkLuminance)
  const lightDiff = Math.abs(targetLuminance - lightLuminance)

  return darkDiff > lightDiff ? dark : light
}
