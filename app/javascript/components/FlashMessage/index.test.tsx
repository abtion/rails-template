import React from "react"
import { render, waitFor } from "@testing-library/react"

import FlashMessage from "."
import userEvent from "@testing-library/user-event"

describe(FlashMessage, () => {
  it("displays a flash message", () => {
    const { getByText } = render(
      <FlashMessage variant="danger">Message</FlashMessage>
    )

    const element = getByText("Message")

    expect(element).toBeInTheDocument()
  })

  it("adds variant class", () => {
    const { getByText } = render(
      <FlashMessage variant="danger">Message</FlashMessage>
    )

    const element = getByText("Message")

    expect(element).toHaveClass("Alert--danger")
  })

  it("is dismissable", async () => {
    const { getByRole, getByText } = render(
      <FlashMessage variant="danger">Message</FlashMessage>
    )

    const element = getByText("Message")

    expect(element).toBeInTheDocument()

    const closeButton = getByRole("button")

    await userEvent.click(closeButton)

    await waitFor(() => expect(element).not.toBeInTheDocument())
  })
})
