import React from "react"
import { createRoot } from "react-dom/client"

interface RequireContext {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  (id: string): any
  keys(): string[]
}

function getValidPaths(contexts: RequireContext[]): string[] {
  return contexts.reduce(
    (res, context) => res.concat(context.keys()),
    [] as string[]
  )
}

function requireComponent(requirePath: string, contexts: RequireContext[]) {
  for (const context of contexts) {
    try {
      // Loading a component will raise an error if it fails
      // but we want to be able to try multiple contexts
      return context(requirePath)
    } catch (error) {
      if (
        error instanceof Error &&
        error.message.includes("Cannot find module")
      ) {
        continue
      }

      throw error
    }
  }
}

function getConstructor(className: string, contexts: RequireContext[]) {
  const parts = className.split(".")
  const filename = parts.shift()
  const keys = parts
  const requirePath = `./${filename}`

  // Load the module:
  let component = requireComponent(requirePath, contexts)

  if (!component) {
    console.error(`Cannot find module "${requirePath}"`) // eslint-disable-line
    console.log("Valid paths are:", getValidPaths(contexts)) // eslint-disable-line
    return
  }

  // Then access each key:
  keys.forEach(function (k) {
    component = component[k]
  })

  // support `export default`
  if (component.__esModule) {
    component = component["default"]
  }
  return component
}

export default function mountComponents(...contexts: RequireContext[]): void {
  const nodes = document.querySelectorAll("[data-react-component]")

  for (let i = 0; i < nodes.length; ++i) {
    const node = nodes[i]
    const className = node.getAttribute("data-react-component") as string

    const constructor = getConstructor(className, contexts)

    if (!constructor) continue

    const propsJson = node.getAttribute("data-react-props")
    const props = propsJson && JSON.parse(propsJson)

    const component = React.createElement(constructor, props)
    const root = createRoot(node)
    root.render(component)
  }
}
