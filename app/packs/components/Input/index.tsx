import React from "react"
import classNames from "classnames"
import Variants from "../../const/variants"
import Sizes from "../../const/sizes"
import "./index.scss"

export interface InputProps
  extends Omit<React.InputHTMLAttributes<HTMLInputElement>, "size"> {
  size?: Sizes
  variant?: Variants
}

export default function Input(props: InputProps): JSX.Element {
  const { size, variant, className, ...rest } = props

  const usedClassName = classNames(
    "Input",
    {
      [`Input--${size}`]: size,
      [`Input--${variant}`]: variant,
    },
    className
  )

  return <input className={usedClassName} {...rest} />
}
