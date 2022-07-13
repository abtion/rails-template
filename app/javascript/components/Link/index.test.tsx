import React from "react"
import { render } from "@testing-library/react"

import Link, { LinkProps, LinkSize, LinkVariant } from "."

const defaultProps: LinkProps = {
  variant: LinkVariant.Info,
  text: "Link text",
  size: LinkSize.Base,
  underline: false,
}

describe(Link, () => {
  it("displays Link text", () => {
    const { getByText } = render(<Link {...defaultProps} />)

    const link = getByText("Link text")

    expect(link).toBeInTheDocument()
  })

  describe("when size is set", () => {
    it("adds size class", () => {
      const { getByText } = render(
        <Link {...defaultProps} size={LinkSize.Small} />
      )

      const link = getByText(defaultProps.text as string)

      expect(link).toHaveClass("Link--sm")
    })
  })

  describe("when variant is set", () => {
    it("adds variant class", () => {
      const { getByText } = render(
        <Link {...defaultProps} variant={LinkVariant.NeutralLight} />
      )

      const link = getByText(defaultProps.text as string)

      expect(link).toHaveClass("Link--neutral-light")
    })
  })

  describe("when underline is set", () => {
    it("adds underline class", () => {
      const { getByText } = render(<Link {...defaultProps} underline />)

      const link = getByText(defaultProps.text as string)

      expect(link).toHaveClass("Link--underline")
    })
  })
})
