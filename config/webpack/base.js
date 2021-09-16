const { webpackConfig } = require("@rails/webpacker")

const webpack = require("webpack")

webpackConfig.plugins.unshift(
  new webpack.ProvidePlugin({
    $: "jquery",
    jQuery: "jquery",
  })
)

module.exports = webpackConfig
