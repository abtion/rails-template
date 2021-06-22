module.exports = {
  "env": {
    browser: true,
    es6: true,
    node: true,
  },
  "extends": "eslint:recommended",
  "parserOptions": {
    sourceType: "module",
  },
  "rules": {
    // enable additional rules
    "indent": ["error", 2],
    "linebreak-style": ["error", "unix"],
    "quotes": ["error", "double"],
    "quote-props": ["error", "consistent"],
    "camelcase": ["error"],

    // Don't allow console.log
    "no-console": ["error"]
  },
};
