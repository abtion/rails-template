// Toggles the mobile nav menu. This replaces an inline onclick handler,
// which the content security policy blocks.
export default function navToggle(root: Document = document): void {
  root.addEventListener("click", (event) => {
    if (!(event.target instanceof Element)) return

    const button = event.target.closest("[data-nav-toggle]")
    if (!button) return

    button.closest("nav")?.querySelector("ul")?.classList.toggle("hidden")
  })
}
