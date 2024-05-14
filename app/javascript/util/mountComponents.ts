import React from "react"
import { createRoot } from "react-dom/client"

interface RequireContext {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  (id: string): any
  keys(): string[]
}

function getValidPaths(contexts: RequireContext[]): string[] {
  return contexts.reduce(
    (res, context) => res.concat(Object.keys(context)),
    [] as string[]
  )
}

function getModule(
  requirePath: string,
  contexts: Record<string, Record<string, any>>[]
) {
  for (const context of contexts) {
    try {
      // Loading a component will raise an error if it fails
      // but we want to be able to try multiple contexts
      const path = Object.keys(context).find((key) => key.includes(requirePath))

      if (!path) continue

      return context[path]
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

async function getConstructor(
  className: string,
  contexts: Record<string, Record<string, any>>[]
) {
  const parts = className.split(".")
  const filename = parts.shift()
  const keys = parts

  // Load the module:
  const module = getModule(filename, contexts)

  if (!module) {
    console.error(`Cannot find module "${filename}"`) // eslint-disable-line
    console.log("Valid paths are:", getValidPaths(contexts)) // eslint-disable-line
    return
  }

  // Then access each key:
  let component = module
  keys.forEach(function (k) {
    component = component[k]
  })

  // support `export default`
  if (component.default) {
    component = component.default
  }
  return component
}

export default async function mountComponents(...eagerLoadedContexts: RequireContext[]) {
  const nodes = document.querySelectorAll("[data-react-component]")

  for (let i = 0; i < nodes.length; ++i) {
    const node = nodes[i]
    const className = node.getAttribute("data-react-component") as string

    const constructor = await getConstructor(className, eagerLoadedContexts)

    if (!constructor) continue

    const propsJson = node.getAttribute("data-react-props")
    const props = propsJson && JSON.parse(propsJson)

    const component = React.createElement(constructor, props)
    const root = createRoot(node)
    root.render(component)
  }
}
