import React from "react"
import classNames from "classnames"
import Variants from "../../const/variants"
import Sizes from "../../const/sizes"
import "./index.scss"

export interface ButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  size?: Sizes
  variant?: Variants
  outline?: boolean
}

export default function Button(props: ButtonProps): JSX.Element {
  const { size, variant, outline, className, ...rest } = props

  const usedClassName = classNames(
    "Button",
    {
      [`Button--${size}`]: size,
      [`Button--${variant}`]: variant,
      "Button--outline": outline,
    },
    className
  )

  return <button className={usedClassName} {...rest} />
}
