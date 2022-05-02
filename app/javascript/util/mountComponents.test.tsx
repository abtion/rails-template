// We cannot import from @testing-library/react in the test since it messes with our ability to test
// the behaviour of the "raw" react mounting api (testing library patches it)
// Therefore we are importing waitFor from @testing-library/dom
import { waitFor } from "@testing-library/dom"

import React from "react"
import mountComponents from "./mountComponents"

interface ComponentsByPath {
  [key: string]: Record<string, unknown>
}

const buildContextMock = (componentsByPath: ComponentsByPath) => {
  const context = (path: string) => {
    const component = componentsByPath[path]

    if (!component) throw new Error(`Cannot find module '${path}'`)

    return component
  }

  context.keys = () => Object.keys(componentsByPath)

  return context
}

function TestComponent({ title }: { title: string }) {
  return <h1 className="TestComponent">{title}</h1>
}

describe(mountComponents, () => {
  afterEach(() => {
    document.body.innerHTML = ""
  })

  it("mounts default exports", async () => {
    const element = document.createElement("div")
    element.setAttribute("data-react-component", "TestComponent")
    element.setAttribute("data-react-props", '{"title":"Title"}')
    document.body.appendChild(element)

    const context = buildContextMock({
      "./TestComponent": { __esModule: true, default: TestComponent },
    })

    mountComponents(context)

    await waitFor(() => {
      expect(document.body.querySelector(".TestComponent")?.tagName).toBe("H1")
      expect(document.body.querySelector(".TestComponent")).toHaveTextContent(
        "Title"
      )
    })
  })

  it("mounts named exports", async () => {
    const element = document.createElement("div")
    element.setAttribute("data-react-component", "List.TestComponent")
    element.setAttribute("data-react-props", '{"title":"Title"}')
    document.body.appendChild(element)

    const context = buildContextMock({
      "./List": { TestComponent },
    })

    mountComponents(context)

    await waitFor(() => {
      expect(document.body.querySelector(".TestComponent")?.tagName).toBe("H1")
      expect(document.body.querySelector(".TestComponent")).toHaveTextContent(
        "Title"
      )
    })
  })

  it("searches multiple contexts", async () => {
    const element = document.createElement("div")
    element.setAttribute("data-react-component", "List.TestComponent")
    element.setAttribute("data-react-props", '{"title":"Title"}')
    document.body.appendChild(element)

    const contextA = buildContextMock({})
    const contextB = buildContextMock({
      "./List": { TestComponent },
    })

    mountComponents(contextA, contextB)

    await waitFor(() => {
      expect(document.body.querySelector(".TestComponent")?.tagName).toBe("H1")
    })
  })

  describe("when component name is invalid", () => {
    /* eslint-disable no-console */
    const originalConsoleLog = console.log
    const originalConsoleError = console.error

    beforeEach(() => {
      console.log = jest.fn()
      console.error = jest.fn()
    })

    afterEach(() => {
      console.log = originalConsoleLog
      console.error = originalConsoleError
    })

    it("prints useful error messages", () => {
      const element = document.createElement("div")
      element.setAttribute("data-react-component", "TestComponent")
      element.setAttribute("data-react-props", '{"title":"Title"}')
      document.body.appendChild(element)

      const contextA = buildContextMock({
        "./Component1": {},
      })
      const contextB = buildContextMock({
        "./Component2": {},
        "./Component3": {},
      })

      mountComponents(contextA, contextB)

      expect(console.error).toHaveBeenCalledWith(
        'Cannot find module "./TestComponent"'
      )
      expect(console.log).toHaveBeenCalledWith("Valid paths are:", [
        "./Component1",
        "./Component2",
        "./Component3",
      ])
    })

    /* eslint-enable no-console */
  })

  describe("when component fails to load", () => {
    it("prints useful error messages", () => {
      const element = document.createElement("div")
      element.setAttribute("data-react-component", "TestComponent")
      element.setAttribute("data-react-props", '{"title":"Title"}')
      document.body.appendChild(element)

      const contextMock = () => {
        // Throw error when the context is called.
        // This is what happens if a component fails to load
        throw new Error("Uncaught ReferenceError: something is not defined")
      }
      contextMock.keys = () => []

      expect(() => {
        mountComponents(contextMock)
      }).toThrow("Uncaught ReferenceError: something is not defined")
    })
  })
})
