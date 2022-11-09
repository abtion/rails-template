module.exports = {
  env: {
    browser: true,
    es6: true,
    node: true,
    jest: true,
  },
  extends: [
    "eslint:recommended",
    "plugin:jest-dom/recommended",
    "plugin:@typescript-eslint/recommended",
    "prettier",
  ],
  parser: "@typescript-eslint/parser",
  rules: {
    // enable additional rules
    "linebreak-style": ["error", "unix"],
    camelcase: ["error"],

    // Don't allow console.log
    "no-console": ["error"],
  },
  overrides: [
    {
      parserOptions: {
        tsconfigRootDir: __dirname,
        project: ["./tsconfig.json"],
      },
      files: ["*.ts", "*.tsx"],
      rules: {
        "@typescript-eslint/no-floating-promises": ["error"],
      },
    },
  ],
}
