import * as ujs from "@rails/ujs"
import * as activestorage from "@rails/activestorage"

import mountComponents from "../util/mountComponents"

ujs.start()
activestorage.start()

// Make all images available for image_pack_tag
require.context("../images", true)

// Add all component CSS files to bundle (required for components with no JS files)
require.context("../components", true, /(?<=\.scss)$/) // Only include scss files

// Add application wide CSS, we do this after the components
// because we want tailwind classes to override default component styling
require("../application.scss")

// Make components available for react_component helper
const componentsContext = require.context(
  "../components",
  true,
  /(?<!(test|test\.[jt]sx?|\.scss))$/ // Exclude tests and scss files
)
mountComponents(componentsContext)
