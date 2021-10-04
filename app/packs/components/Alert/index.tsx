import React from "react"
import classNames from "classnames"
import Variants from "../../const/variants"
import "./index.scss"

export interface AlertProps extends React.HTMLAttributes<HTMLDivElement> {
  variant?: Variants
}

export default function Alert(props: AlertProps): JSX.Element {
  const { variant, className, ...rest } = props

  const usedClassName = classNames(
    "Alert",
    {
      [`Alert--${variant}`]: variant,
    },
    className
  )

  return <div className={usedClassName} role="alert" {...rest} />
}
