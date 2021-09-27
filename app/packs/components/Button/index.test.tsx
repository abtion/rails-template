import React from "react"
import { render } from "@testing-library/react"
import Sizes from "../../const/sizes"
import Variants from "../../const/variants"

import Button, { ButtonProps } from "."

const defaultProps: ButtonProps = {
  children: "Button text",
}

describe(Button, () => {
  it("displays button text", () => {
    const { getByText } = render(<Button {...defaultProps} />)

    const button = getByText(defaultProps.children as string)

    expect(button).toBeInTheDocument()
  })

  describe("outline = true", () => {
    it("adds outline class", () => {
      const { getByText } = render(<Button {...defaultProps} outline />)

      const button = getByText(defaultProps.children as string)

      expect(button).toHaveClass("Button--outline")
    })
  })

  describe("when size is set", () => {
    it("adds size class", () => {
      const { getByText } = render(
        <Button {...defaultProps} size={Sizes.Medium} />
      )

      const button = getByText(defaultProps.children as string)

      expect(button).toHaveClass("Button--md")
    })
  })

  describe("when variant is set", () => {
    it("adds variant class", () => {
      const { getByText } = render(
        <Button {...defaultProps} variant={Variants.Primary} />
      )

      const button = getByText(defaultProps.children as string)

      expect(button).toHaveClass("Button--primary")
    })
  })
})
