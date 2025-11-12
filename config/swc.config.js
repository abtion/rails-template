// eslint-disable-next-line @typescript-eslint/no-require-imports
const { env } = require("shakapacker")

const customConfig = {
  options: {
    jsc: {
      parser: {
        // jsx and syntax is inferred by shakapacker, but needed by jest
        jsx: true,
        syntax: "typescript",
      },
      transform: {
        react: {
          development: env.isDevelopment,
          runtime: "automatic",
        },
      },
    },
  },
}

module.exports = customConfig
