import React from "react"
import { render } from "@testing-library/react"
import Input, { InputProps } from "."
import Sizes from "../../const/sizes"
import Variants from "../../const/variants"

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
        <Input {...defaultProps} size={Sizes.Medium} />
      )

      const input = getByPlaceholderText(defaultProps.placeholder as string)

      expect(input).toHaveClass("Input--md")
    })
  })

  describe("when variant is set", () => {
    it("adds variant class", () => {
      const { getByPlaceholderText } = render(
        <Input {...defaultProps} variant={Variants.Primary} />
      )

      const input = getByPlaceholderText(defaultProps.placeholder as string)

      expect(input).toHaveClass("Input--primary")
    })
  })
})
