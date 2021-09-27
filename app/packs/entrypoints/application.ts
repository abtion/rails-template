import * as ujs from "@rails/ujs"
import * as activestorage from "@rails/activestorage"

import { cssVariables } from "../const/colors"
import "../application.scss"

ujs.start()
activestorage.start()

// Make all images available for image_pack_tag
require.context("../images", true)

// Define CSS variables for all colors
// These variables are used by tailwind.
// We use variables because they are easy to override in dev tools or in local selectors
const cssRoot: HTMLElement = document.querySelector(":root")
Object.entries(cssVariables).forEach(([name, value]) =>
  cssRoot.style.setProperty(name, value)
)
