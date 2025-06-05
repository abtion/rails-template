const { generateWebpackConfig, merge } = require("shakapacker")
const webpackConfig = generateWebpackConfig()

const aliasConfig = require("./alias")
const PrependCssPlugin = require("./PrependCssPlugin")
const colors = require("../../colors.json")
const { getColorStyles } = require("@abtion-oss/design-system-colors")

module.exports = merge({}, webpackConfig, aliasConfig, {
  plugins: [new PrependCssPlugin(getColorStyles(colors))],
})
