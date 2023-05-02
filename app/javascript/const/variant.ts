const Variants = [
  "primary",
  "neutral",
  "success",
  "danger",
  "warning",
  "info",
] as const

export type Variant = (typeof Variants)[number]
export default Variants
