import React from "react"
import { render } from "@testing-library/react"
import Variant from "~/const/variant"

import Button, { ButtonProps, ButtonSize } from "."

const defaultProps: ButtonProps = {
  children: "Button text",
}

describe(Button, () => {
  it("displays button text", () => {
    const { getByText } = render(<Button {...defaultProps} />)

    const button = getByText(defaultProps.children as string)

    expect(button).toBeInTheDocument()
  })

  describe("when size is set", () => {
    it("adds size class", () => {
      const { getByText } = render(
        <Button {...defaultProps} size={ButtonSize.Medium} />
      )

      const button = getByText(defaultProps.children as string)

      expect(button).toHaveClass("Button--md")
    })
  })

  describe("when variant is set", () => {
    it("adds variant class", () => {
      const { getByText } = render(
        <Button {...defaultProps} variant={Variant.Primary} />
      )

      const button = getByText(defaultProps.children as string)

      expect(button).toHaveClass("Button--primary")
    })
  })
})
