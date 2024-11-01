/* eslint-disable @typescript-eslint/no-var-requires */
const colors = require("./colors.json")
const { getTailwindColors } = require("@abtion-oss/design-system-colors")
/* eslint-enable @typescript-eslint/no-var-requires */

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
      ...getTailwindColors(colors),
    },
    fontFamily: {
      sans: ["Inter", "sans-serif"],
    },
  },
  plugins: [],
}
