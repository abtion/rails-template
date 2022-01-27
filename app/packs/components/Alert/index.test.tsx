import React from "react"
import { render } from "@testing-library/react"
import Variant from "~/const/variant"

import Alert, { AlertProps } from "."
import userEvent from "@testing-library/user-event"

const defaultProps: AlertProps = {
  children: "Alert text",
}

describe(Alert, () => {
  it("displays button text", () => {
    const { getByText } = render(<Alert {...defaultProps} />)

    const element = getByText(defaultProps.children as string)

    expect(element).toBeInTheDocument()
  })

  describe("when variant is set", () => {
    it("adds variant class", () => {
      const { getByText } = render(
        <Alert {...defaultProps} variant={Variant.Primary} />
      )

      const element = getByText(defaultProps.children as string)

      expect(element).toHaveClass("Alert--primary")
    })
  })

  describe("with onClose handler", () => {
    it("has a close button", () => {
      const closeHandler = jest.fn()
      const { getByRole } = render(
        <Alert
          {...defaultProps}
          onClose={closeHandler}
          variant={Variant.Primary}
        />
      )

      const element = getByRole("button")

      expect(element).toHaveClass("Alert__close")

      expect(closeHandler).not.toHaveBeenCalled()

      userEvent.click(element)

      expect(closeHandler).toHaveBeenCalled()
    })
  })
})
