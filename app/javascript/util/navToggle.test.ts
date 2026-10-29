import navToggle from "./navToggle"

describe(navToggle, () => {
  beforeAll(() => {
    navToggle()
  })

  beforeEach(() => {
    document.body.innerHTML = `
      <nav>
        <button data-nav-toggle aria-expanded="false"><svg></svg></button>
        <ul class="hidden"></ul>
      </nav>
    `
  })

  afterEach(() => {
    document.body.innerHTML = ""
  })

  it("shows and hides the menu", () => {
    const button = document.querySelector("button") as HTMLButtonElement
    const menu = document.querySelector("ul") as HTMLUListElement

    button.click()
    expect(menu).not.toHaveClass("hidden")
    expect(button).toHaveAttribute("aria-expanded", "true")

    button.click()
    expect(menu).toHaveClass("hidden")
    expect(button).toHaveAttribute("aria-expanded", "false")
  })

  it("toggles when the click lands on the icon inside the button", () => {
    const icon = document.querySelector("svg") as SVGElement
    const menu = document.querySelector("ul") as HTMLUListElement

    icon.dispatchEvent(new MouseEvent("click", { bubbles: true }))
    expect(menu).not.toHaveClass("hidden")
  })

  it("ignores clicks elsewhere", () => {
    const menu = document.querySelector("ul") as HTMLUListElement

    menu.click()
    expect(menu).toHaveClass("hidden")
  })
})
