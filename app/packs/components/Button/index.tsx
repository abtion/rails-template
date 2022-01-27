import React from "react"
import classNames from "classnames"
import Variant from "~/const/variant"
import "./index.scss"

export type ButtonVariant = Variant | "basic" | "secondary"

export enum ButtonSize {
  ExtraSmall = "xs",
  Small = "sm",
  Medium = "md",
  Large = "lg",
  ExtraLarge = "xl",
}

export interface ButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  size?: ButtonSize
  variant?: ButtonVariant
}

export default function Button(props: ButtonProps): JSX.Element {
  const { size, variant, className, ...rest } = props

  const usedClassName = classNames(
    "Button",
    {
      [`Button--${size}`]: size,
      [`Button--${variant}`]: variant,
    },
    className
  )

  return <button className={usedClassName} {...rest} />
}
