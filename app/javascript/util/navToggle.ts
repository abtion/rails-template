// Toggles the collapsed nav menu on small screens.
// Uses a delegated listener instead of an inline onclick, which the
// Content Security Policy blocks (script-src has no 'unsafe-inline').
export default function navToggle(root: Document = document): void {
  root.addEventListener("click", (event) => {
    const target = event.target as Element | null
    const button = target?.closest("[data-nav-toggle]")
    if (!button) return

    const menu = button.closest("nav")?.querySelector("ul")
    if (!menu) return

    const hidden = menu.classList.toggle("hidden")
    button.setAttribute("aria-expanded", String(!hidden))
  })
}
