module.exports = {
  collectCoverage: true,
  roots: [
    "spec/javascript",
  ],
  moduleNameMapper: {
    "^.+\\.(css|less|scss)$": "babel-jest"
  }
}
