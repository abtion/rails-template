module.exports = {
  roots: ["app/packs"],
  testRegex: ".*test.(t|j)sx?$",
  testEnvironment: "jsdom",
  setupFilesAfterEnv: ["./app/packs/jest.setup.ts"],
  moduleFileExtensions: ["js", "ts", "json", "tsx", "scss"],
  moduleNameMapper: {
    "\\.(css|less|scss)$": "identity-obj-proxy",
  },
}
