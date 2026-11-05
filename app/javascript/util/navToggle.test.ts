import navToggle from "./navToggle"

describe("navToggle", () => {
  beforeAll(() => navToggle(document))

  beforeEach(() => {
    document.body.innerHTML = `
      <nav>
        <button data-nav-toggle><svg><path /></svg></button>
        <ul class="hidden"></ul>
      </nav>
    `
  })

  it("toggles the menu when the button is clicked", () => {
    const button = document.querySelector("button") as HTMLElement
    const menu = document.querySelector("ul") as HTMLElement

    button.click()
    expect(menu.classList).not.toContain("hidden")

    button.click()
    expect(menu.classList).toContain("hidden")
  })

  it("toggles the menu when an icon inside the button is clicked", () => {
    const path = document.querySelector("path") as Element
    const menu = document.querySelector("ul") as HTMLElement

    path.dispatchEvent(new MouseEvent("click", { bubbles: true }))
    expect(menu.classList).not.toContain("hidden")
  })

  it("ignores clicks elsewhere", () => {
    const menu = document.querySelector("ul") as HTMLElement

    document.body.click()
    document.dispatchEvent(new MouseEvent("click"))
    expect(menu.classList).toContain("hidden")
  })

  it("ignores toggle buttons without a nav or menu", () => {
    document.body.innerHTML = `
      <button data-nav-toggle id="outside"></button>
      <nav><button data-nav-toggle id="empty"></button></nav>
    `
    const outside = document.getElementById("outside") as HTMLElement
    const empty = document.getElementById("empty") as HTMLElement

    expect(() => outside.click()).not.toThrow()
    expect(() => empty.click()).not.toThrow()
  })
})
