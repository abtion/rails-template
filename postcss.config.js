import postcssImport from "postcss-import"
import tailwindCss from "tailwindcss"
import tailwindConfig from "./tailwind.config"

export default {
  plugins: [postcssImport, tailwindCss(tailwindConfig)],
}
