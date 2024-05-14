import postcssImport from "postcss-import"
import tailwindCss from "tailwindcss"
import tailwindConfig from "./tailwind.config"
import { cascadeLayerPrefixer } from "./app/javascript/util/cascadeLayerPrefixer"

export default {
  plugins: [
    postcssImport,
    tailwindCss(tailwindConfig),
    cascadeLayerPrefixer({
      layerName: "components",
      fileNameMatcher: /\/components\/.+/,
    }),
  ],
}
