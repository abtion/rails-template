import * as ujs from "@rails/ujs"
import * as activestorage from "@rails/activestorage"

import { cssVariables } from "../const/colors"
import "../application.scss"

// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
ujs.start()
activestorage.start()

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
require.context("../images", true)

// Define CSS variables for all colors
// These variables are used by tailwind.
// We use variables because they are easy to override in dev tools, or local selectors
const cssRoot: HTMLElement = document.querySelector(":root")
Object.entries(cssVariables).forEach(([name, value]) =>
  cssRoot.style.setProperty(name, value)
)
