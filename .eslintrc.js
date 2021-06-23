module.exports = {
  "env": {
    browser: true,
    es6: true,
    node: true,
    jest: true,
  },
  "extends": [
    "eslint:recommended",
    "plugin:jest-dom/recommended",
    "prettier",
  ],
  "parserOptions": {
    sourceType: "module",
  },
  "rules": {
    // enable additional rules
    "linebreak-style": ["error", "unix"],
    "camelcase": ["error"],

    // Don't allow console.log
    "no-console": ["error"]
  },
};
