import React from "react"
import classNames from "classnames"
import { Size } from "~/const/size"
import "./index.scss"

export interface InputProps
  extends Omit<React.InputHTMLAttributes<HTMLInputElement>, "size"> {
  size?: Size
  variant?: "default" | "error"
}

export default function Input(props: InputProps): JSX.Element {
  const { size, variant, className, ...rest } = props

  const usedClassName = classNames(
    "Input",
    {
      [`Input--${size}`]: size,
      [`Input--${variant}`]: variant,
    },
    className,
  )

  return <input className={usedClassName} {...rest} />
}
