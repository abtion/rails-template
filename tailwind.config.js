/* eslint-disable @typescript-eslint/no-var-requires */
const colors = require("./colors.json")
const prepareColorVariables = require("./app/packs/util/prepareColorVariables")
/* eslint-enable @typescript-eslint/no-var-requires */

const tailwindConfig = prepareColorVariables(colors).tailwindConfig

module.exports = {
  purge: ["./app/packs/**/*.{js,jsx,ts,tsx,scss,css}", "./app/views/**/*.erb"],
  darkMode: false, // or 'media' or 'class'
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
  variants: {
    extend: {
      backgroundColor: ["odd", "active"],
      boxShadow: ["active"],
    },
  },
  plugins: [],
}
