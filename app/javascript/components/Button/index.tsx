import React from "react"
import classNames from "classnames"
import { Variant } from "~/const/variant"
import { Size } from "~/const/size"
import "./index.scss"

export interface ButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  size?: Size
  variant?: Variant | "basic" | "secondary"
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
