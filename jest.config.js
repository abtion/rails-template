module.exports = {
  roots: ["app/packs"],
  testRegex: ".*test.(t|j)sx?$",
  testEnvironment: "jsdom",
  collectCoverageFrom: [
    "app/packs/**/*.{js,ts,tsx}",
    "!app/packs/entrypoints/*",
    "!app/packs/**/*.d.ts",
  ],
  coverageThreshold: {
    "app/packs/**/*.{js,ts,tsx}": {
      branches: 100,
      functions: 100,
      lines: 100,
      statements: 100,
    },
  },
  setupFilesAfterEnv: ["./app/packs/jest.setup.ts"],
  moduleFileExtensions: ["js", "ts", "json", "tsx", "scss"],
  moduleNameMapper: {
    "\\.(css|less|scss)$": "identity-obj-proxy",

    // These are all the static file formats that webpacker comes preconfigured with support for:
    // https://github.com/rails/webpacker/blob/e039a2f27e6bb684e921081295d3408625d25799/package/rules/file.js
    "\\.(bmp|gif|jpeg|jpg|png|tiff|ico|avif|webp|eot|otf|ttf|woff|woff2|svg)":
      "<rootDir>/app/packs/__mocks__/staticFileMock.js",
  },
}
