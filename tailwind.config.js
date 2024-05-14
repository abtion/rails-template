import colors from "./colors.json"
import prepareColorVariables from "./app/javascript/util/prepareColorVariables"

const tailwindConfig = prepareColorVariables(colors).tailwindConfig

export default {
  content: [
    "./app/javascript/**/*.{js,jsx,ts,tsx,scss,css}",
    "./app/views/**/*.erb",
    // "./app/views/home/index.html.erb",
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
