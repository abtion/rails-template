/* eslint-disable @typescript-eslint/no-var-requires */
const colors = require("./colors.json")
const prepareColorVariables = require("./app/javascript/util/prepareColorVariables")
/* eslint-enable @typescript-eslint/no-var-requires */

const tailwindConfig = prepareColorVariables(colors).tailwindConfig

module.exports = {
  content: [
    "./app/javascript/**/*.{js,jsx,ts,tsx,scss,css}",
    "./app/views/**/*.erb",
  ],
  theme: {
    container: {
      center: true,
      padding: "1rem",
    },
    colors: {
      transparent: "transparent",
      white: "white",
      black: "black",
      current: "currentColor",
      ...tailwindConfig,
    },
    fontFamily: {
      sans: ["Inter", "sans-serif"],
    },
  },
  plugins: [],
}
