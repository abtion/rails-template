import { defineConfig } from "vite"
import RubyPlugin from "vite-plugin-ruby"
import postcss from "./postcss.config.js"
import nodeSassGlobImporter from "node-sass-glob-importer"

export default defineConfig({
  plugins: [RubyPlugin()],
  css: {
    postcss,
    // preprocessorOptions: {
    //   scss: {
    //     importer: nodeSassGlobImporter(),
    //   },
    // },
  },
})
