module.exports = function (api) {
  const defaultConfigFunc = require("shakapacker/package/babel/preset.js")
  const resultConfig = defaultConfigFunc(api)
  const isDevelopmentEnv = api.env("development")
  const isTestEnv = api.env("test")

  const changesOnDefault = {
    presets: [
      [
        "@babel/preset-react",
        {
          development: isDevelopmentEnv || isTestEnv,
          useBuiltIns: true,
        },
      ],
    ].filter(Boolean),
  }

  resultConfig.presets = [...resultConfig.presets, ...changesOnDefault.presets]

  return resultConfig
}
