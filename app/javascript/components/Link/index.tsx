import React from "react"
import classNames from "classnames"
import "./index.scss"

export const LinkSizes = ["xs", "sm", "bs"] as const
export type LinkSize = (typeof LinkSizes)[number]

export const LinkVariants = [
  "neutral",
  "neutral-light",
  "neutral-dark",
  "info",
] as const
export type LinkVariant = (typeof LinkVariants)[number]

export interface LinkProps extends React.HTMLAttributes<HTMLAnchorElement> {
  variant?: LinkVariant
  text: string
  size?: LinkSize
  underline?: boolean
}

export default function Link(props: LinkProps): JSX.Element {
  const { underline, size, variant, className, text, ...rest } = props

  const usedClassName = classNames(
    "Link",
    {
      [`Link--${variant}`]: variant,
      [`Link--${size}`]: size,
      [`Link--underline`]: underline,
    },
    className
  )

  return (
    <a className={usedClassName} {...rest}>
      {text}
    </a>
  )
}
