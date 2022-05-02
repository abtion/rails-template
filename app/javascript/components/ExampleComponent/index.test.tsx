import React from "react"
import { render } from "@testing-library/react"
import Variants from "../../const/variant"

import ExampleComponent, { ExampleComponentProps } from "."

const defaultProps: ExampleComponentProps = {
  children: "ExampleComponent content",
}

describe(ExampleComponent, () => {
  it("displays text", () => {
    const { getByText } = render(<ExampleComponent {...defaultProps} />)

    const textParent = getByText(defaultProps.children as string)

    expect(textParent).toBeInTheDocument()
  })

  it("displays an image", () => {
    const { getByAltText } = render(<ExampleComponent {...defaultProps} />)

    const image = getByAltText("image")

    expect(image).toBeInTheDocument()
    expect(image.tagName).toBe("IMG")
  })

  describe("when variant is set", () => {
    it("adds variant class", () => {
      const { container } = render(
        <ExampleComponent {...defaultProps} variant={Variants.Primary} />
      )

      const component = container.querySelector(".ExampleComponent--primary")

      expect(component).toBeInTheDocument()
    })
  })
})
