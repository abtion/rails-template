const { generateWebpackConfig, merge } = require("shakapacker")
const webpackConfig = generateWebpackConfig()

const aliasConfig = require("./alias")
const colors = require("../../colors.json")
const { getColorStyles } = require("@abtion-oss/design-system-colors")
const nodeSassGlobImporter = require("node-sass-glob-importer")

const sassRule = webpackConfig.module.rules.find((rule) =>
  [].concat(rule.test).some((test) => test.test(".scss")),
)
const sassLoader = sassRule.use.find((use) => {
  const loader = typeof use === "object" ? use.loader : use
  return loader.includes("sass-loader")
})

sassLoader.options.sassOptions.importer = nodeSassGlobImporter()
sassLoader.options.api = "legacy"
sassLoader.options.additionalData = getColorStyles(colors)

module.exports = merge({}, webpackConfig, aliasConfig)
