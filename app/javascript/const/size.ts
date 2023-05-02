export const Sizes = ["xs", "sm", "md", "lg", "xl"] as const
export type Size = (typeof Sizes)[number]

export default Sizes
