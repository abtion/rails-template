import React from "react"
import classNames from "classnames"
import { Variant } from "~/const/variant"
import { Size } from "~/const/size"
import "./index.scss"

export interface ButtonClearProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  size?: Size
  variant?: Variant | "basic" | "secondary"
}

export default function ButtonClear(props: ButtonClearProps): JSX.Element {
  const { size, variant, className, ...rest } = props

  const usedClassName = classNames(
    "ButtonClear",
    {
      [`ButtonClear--${size}`]: size,
      [`ButtonClear--${variant}`]: variant,
    },
    className
  )

  return <button className={usedClassName} {...rest} />
}
