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
  },
}
