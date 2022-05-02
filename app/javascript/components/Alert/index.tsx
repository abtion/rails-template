import React from "react"
import classNames from "classnames"
import Variant from "~/const/variant"
import "./index.scss"
import XIcon from "@heroicons/react/solid/XIcon"

export interface AlertProps extends React.HTMLAttributes<HTMLDivElement> {
  variant?: Variant
  onClose?: () => void
}

export default function Alert(props: AlertProps): JSX.Element {
  const { variant, className, onClose, children, ...rest } = props

  const usedClassName = classNames(
    "Alert",
    {
      [`Alert--${variant}`]: variant,
      "Alert--dismissable": onClose,
    },
    className
  )

  return (
    <div className={usedClassName} role="alert" {...rest}>
      {children}
      {onClose && (
        <button className="Alert__close" onClick={onClose} aria-label="Close">
          <XIcon />
        </button>
      )}
    </div>
  )
}
