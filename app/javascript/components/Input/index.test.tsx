import React from "react"
import { render } from "@testing-library/react"
import Input, { InputProps, InputSize } from "."
import Variant from "~/const/variant"

const defaultProps: InputProps = {
  placeholder: "Input placeholder",
}

describe(Input, () => {
  it("displays Input text", () => {
    const { getByPlaceholderText } = render(<Input {...defaultProps} />)

    const input = getByPlaceholderText(defaultProps.placeholder as string)

    expect(input).toBeInTheDocument()
  })

  describe("when size is set", () => {
    it("adds size class", () => {
      const { getByPlaceholderText } = render(
        <Input {...defaultProps} size={InputSize.Medium} />
      )

      const input = getByPlaceholderText(defaultProps.placeholder as string)

      expect(input).toHaveClass("Input--md")
    })
  })

  describe("when variant is set", () => {
    it("adds variant class", () => {
      const { getByPlaceholderText } = render(
        <Input {...defaultProps} variant={Variant.Primary} />
      )

      const input = getByPlaceholderText(defaultProps.placeholder as string)

      expect(input).toHaveClass("Input--primary")
    })
  })
})
