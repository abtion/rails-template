import React from "react"
import { render } from "@testing-library/react"

import ButtonClear, { ButtonClearProps } from "."

const defaultProps: ButtonClearProps = {
  children: "ButtonClear text",
}

describe(ButtonClear, () => {
  it("displays button text", () => {
    const { getByText } = render(<ButtonClear {...defaultProps} />)

    const button = getByText(defaultProps.children as string)

    expect(button).toBeInTheDocument()
  })

  describe("when size is set", () => {
    it("adds size class", () => {
      const { getByText } = render(<ButtonClear {...defaultProps} size="md" />)

      const button = getByText(defaultProps.children as string)

      expect(button).toHaveClass("ButtonClear--md")
    })
  })

  describe("when variant is set", () => {
    it("adds variant class", () => {
      const { getByText } = render(
        <ButtonClear {...defaultProps} variant="primary" />
      )

      const button = getByText(defaultProps.children as string)

      expect(button).toHaveClass("ButtonClear--primary")
    })
  })
})
