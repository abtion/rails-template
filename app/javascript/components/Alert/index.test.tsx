import React from "react"
import { render, waitFor } from "@testing-library/react"

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
        <Alert {...defaultProps} variant="primary" />
      )

      const element = getByText(defaultProps.children as string)

      expect(element).toHaveClass("Alert--primary")
    })
  })

  describe("with onClose handler", () => {
    it("has a close button", async () => {
      const closeHandler = jest.fn()
      const { getByRole } = render(
        <Alert {...defaultProps} onClose={closeHandler} variant="primary" />
      )

      const element = getByRole("button")

      expect(element).toHaveClass("Alert__close")

      expect(closeHandler).not.toHaveBeenCalled()

      await userEvent.click(element)
      await waitFor(() => expect(closeHandler).toHaveBeenCalled())
    })
  })
})
