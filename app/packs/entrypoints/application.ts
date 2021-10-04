import * as ujs from "@rails/ujs"
import * as activestorage from "@rails/activestorage"

import mountComponents from "../util/mountComponents"
import prepareColorVariables from "../util/prepareColorVariables"
import colors from "../../../colors.json"

import "../application.scss"

ujs.start()
activestorage.start()

// Make all images available for image_pack_tag
require.context("../images", true)

// Add all component CSS files to bundle (required for components with no JS files)
require.context("../components", true, /(?<=\.scss)$/) // Only include scss files

// Define CSS variables for all colors
// These variables are used by tailwind.
// We use variables because they are easy to override in dev tools or in local selectors
const cssRoot: HTMLElement = document.querySelector(":root")
const cssVariables = prepareColorVariables(colors).cssVariables
Object.entries(cssVariables).forEach(([name, value]) =>
  cssRoot.style.setProperty(name, value)
)

// Make components available for react_component helper
const componentsContext = require.context(
  "../components",
  true,
  /(?<!(test|test\.[jt]sx?|\.scss))$/ // Exclude tests and scss files
)
mountComponents(componentsContext)
