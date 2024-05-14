import postcss, { PluginCreator } from "postcss"

// PostCSS plugin for wrapping matching CSS files in a cascade layer
type PluginOptions = {
  fileNameMatcher: RegExp
  layerName: string
}

export const cascadeLayerPrefixer: PluginCreator<PluginOptions> = (
  options
) => ({
  postcssPlugin: "postcss-layer",
  Once(root) {
    if (!options) return
    const { fileNameMatcher, layerName } = options

    // Ignore files that don't match the file matcher

    if (
      fileNameMatcher &&
      !fileNameMatcher?.test(root.source?.input.file || "")
    ) {
      return
    }

    // Create a new layer rule
    const layerRule = postcss.atRule({ name: "layer", params: layerName })

    // Move all other rules into the layer rule
    root.each((node) => {
      // Only actual rules (not atrules)
      if (node.type === "rule") {
        root.removeChild(node)
        layerRule.append(node)
      }
    })

    // Append layer rule
    root.append(layerRule)
  },
})

cascadeLayerPrefixer.postcss = true
