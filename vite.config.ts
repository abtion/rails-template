import { defineConfig } from "vite"
import RubyPlugin from "vite-plugin-ruby"
import postcss from "./postcss.config.ts"
import nodeSassGlobImporter from "node-sass-glob-importer"
import dynamicCssVariables from "./config/webpack/dynamicCssVariables.js"

export default defineConfig({
  plugins: [RubyPlugin()],
  css: {
    postcss,
    preprocessorOptions: {
      scss: {
        importer: nodeSassGlobImporter(),
        additionalData: (style, path) => {
          if (!path.match("application.scss")) return style

          return dynamicCssVariables + style
        },
      },
    },
  },
})
