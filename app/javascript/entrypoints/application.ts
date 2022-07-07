import * as ujs from "@rails/ujs"
import * as activestorage from "@rails/activestorage"

import mountComponents from "../util/mountComponents"
import prepareColorVariables from "../util/prepareColorVariables"
import colors from "../../../colors.json"

ujs.start()
activestorage.start()

// Define CSS variables for all colors
// These variables are used by tailwind.
// We use variables because they are easy to override in dev tools or in local selectors
const cssRoot: HTMLElement | null = document.querySelector(":root")
const cssVariables = prepareColorVariables(colors).cssVariables
Object.entries(cssVariables).forEach(([name, value]) =>
  cssRoot?.style.setProperty(name, value)
)

const components = import.meta.glob("../components/**/index.tsx")
mountComponents(components)
