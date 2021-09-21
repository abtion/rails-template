// tailwind.config.js

module.exports = {
  purge: ["./app/packs/**/*.{js,jsx,ts,tsx,scss,css}", "./app/views/**/*.erb"],
  darkMode: false, // or 'media' or 'class'
  theme: {
    colors: require("./app/packs/const/colors").tailwindConfig,
    fontFamily: {
      sans: ["Inter", "sans-serif"],
    },
  },
  variants: {},
  plugins: [],
}
