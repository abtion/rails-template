const { Compilation } = require("webpack")

module.exports = class PrependCssPlugin {
  constructor(css) {
    this.css = css
  }

  apply(compiler) {
    compiler.hooks.thisCompilation.tap("PrependCssPlugin", (compilation) => {
      compilation.hooks.processAssets.tap(
        {
          name: "PrependCssPlugin",
          stage: Compilation.PROCESS_ASSETS_STAGE_ADDITIONS,
        },
        (assets) => {
          for (const filename of Object.keys(assets)) {
            if (filename.endsWith("application.css")) {
              const originalSource = compilation.assets[filename].source()
              compilation.updateAsset(
                filename,
                new compiler.webpack.sources.RawSource(
                  [this.css, originalSource].join("\n"),
                ),
              )
            }
          }
        },
      )
    })
  }
}
