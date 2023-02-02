import React from "react"
import { render } from "@testing-library/react"

import Link, { LinkProps } from "."

const defaultProps: LinkProps = {
  variant: "info",
  text: "Link text",
  size: "bs",
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
      const { getByText } = render(<Link {...defaultProps} size="sm" />)

      const link = getByText(defaultProps.text as string)

      expect(link).toHaveClass("Link--sm")
    })
  })

  describe("when variant is set", () => {
    it("adds variant class", () => {
      const { getByText } = render(
        <Link {...defaultProps} variant="neutral-light" />
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
