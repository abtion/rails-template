module.exports = {
  roots: ["app/javascript"],
  testRegex: ".*test.(t|j)sx?$",
  testEnvironment: "jsdom",
  collectCoverageFrom: [
    "app/javascript/**/*.{js,ts,tsx}",
    "!app/javascript/entrypoints/*",
    "!app/javascript/**/*.d.ts",
    "!app/javascript/const/**/*",
  ],
  coverageThreshold: {
    "app/javascript/**/*.{js,ts,tsx}": {
      branches: 100,
      functions: 100,
      lines: 100,
      statements: 100,
    },
  },
  setupFilesAfterEnv: ["./app/javascript/jest.setup.ts"],
  moduleFileExtensions: ["js", "ts", "json", "tsx", "scss"],
  moduleNameMapper: {
    "\\.(css|less|scss)$": "identity-obj-proxy",

    // These are all the static file formats that shakapacker comes preconfigured with support for:
    // https://github.com/shakacode/shakapacker/blob/64aee9530877f16f671bc21cf4c2eb1ec1047960/package/rules/file.js
    "\\.(bmp|gif|jpe?g|png|tiff|ico|avif|webp|eot|otf|ttf|woff|woff2|svg)":
      "<rootDir>/app/javascript/__mocks__/staticFileMock.js",
    "~/(.*)$": "<rootDir>/app/javascript/$1",
  },
}
