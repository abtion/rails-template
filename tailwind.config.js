// tailwind.config.js
module.exports = {
  purge: ["./app/packs/**/*.{js,jsx,ts,tsx,scss,css}", "./app/views/**/*.erb"],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {},
  },
  variants: {},
  plugins: [],
}
