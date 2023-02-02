import React from "react"
import classNames from "classnames"
import { Variant } from "~/const/variant"
import "./index.scss"

export interface AlertProps extends React.HTMLAttributes<SVGElement> {
  variant?: Variant
  icon: (props: React.HTMLAttributes<SVGElement>) => JSX.Element
}

export default function AlertIcon(props: AlertProps): JSX.Element {
  const { icon: Icon, variant, className, ...rest } = props

  const usedClassName = classNames(
    "AlertIcon",
    {
      [`AlertIcon--${variant}`]: variant,
    },
    className
  )

  return <Icon className={usedClassName} {...rest} />
}
