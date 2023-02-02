import React from "react"
import { render } from "@testing-library/react"
import InformationCircleIcon from "@heroicons/react/20/solid/InformationCircleIcon"

import AlertIcon from "."

const defaultProps = {
  icon: InformationCircleIcon,
}

describe(AlertIcon, () => {
  it("displays an svg icon component with a predefined class", () => {
    const { container } = render(<AlertIcon {...defaultProps} />)

    const element = container.querySelector("svg")

    expect(element).toHaveClass("AlertIcon")
  })

  describe("when variant is set", () => {
    it("adds variant class", () => {
      const { container } = render(
        <AlertIcon {...defaultProps} variant="primary" />
      )

      const element = container.querySelector("svg")

      expect(element).toHaveClass("AlertIcon--primary")
    })
  })
})
