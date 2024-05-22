import prepareColorVariables from "../../app/javascript/util/prepareColorVariables.js"
import colors from "../../colors.json"

// const prepareColorVariables = require("../../app/javascript/util/prepareColorVariables.js")
// const colors = require("../../colors.json")

// Define CSS variables for all colors
// These variables are used by tailwind.
// We use variables because they are easy to override in dev tools or in local selectors
const cssVariables = prepareColorVariables(colors).cssVariables
const cssVariableStrings = Object.entries(cssVariables).map(
  ([name, value]) => `${name}: ${value};`
)

export default `
:root {
  ${cssVariableStrings.join("\n")}
}
`
