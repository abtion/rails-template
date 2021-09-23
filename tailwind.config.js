// tailwind.config.js

console.log(require("./app/packs/const/colors").tailwindConfig)

module.exports = {
  purge: ["./app/packs/**/*.{js,jsx,ts,tsx,scss,css}", "./app/views/**/*.erb"],
  darkMode: false, // or 'media' or 'class'
  theme: {
    colors: {
      transparent: "transparent",
      current: "currentColor",
      ...require("./app/packs/const/colors").tailwindConfig,
    },
    fontFamily: {
      sans: ["Inter", "sans-serif"],
    },
  },
  variants: {},
  plugins: [],
}
