import "@rails/ujs"
import * as activestorage from "@rails/activestorage"

import mountComponents from "../util/mountComponents"

activestorage.start()

import.meta.glob("../application.scss", { eager: true })
import.meta.glob("../components/**/*.scss", { eager: true })

const components = import.meta.glob("../components/**/index.tsx", {
  eager: true,
})
mountComponents(components)
