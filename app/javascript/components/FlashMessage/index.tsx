import React, { useState } from "react"
import classNames from "classnames"
import Variant from "~/const/variant"

import CheckCircleIcon from "@heroicons/react/solid/CheckCircleIcon"
import XCircleIcon from "@heroicons/react/solid/XCircleIcon"
import ExclamationIcon from "@heroicons/react/solid/ExclamationIcon"

import Alert from "~/components/Alert"
import AlertIcon from "~/components/AlertIcon"

interface FlashMessageProps extends React.HTMLAttributes<HTMLDivElement> {
  variant: Variant.Danger | Variant.Warning | Variant.Success
}

export default function FlashMessage(props: FlashMessageProps) {
  const { variant, className, children, ...rest } = props
  const [dismissed, setDismissed] = useState(false)

  const IconComponent = {
    danger: XCircleIcon,
    warning: ExclamationIcon,
    success: CheckCircleIcon,
  }[variant]

  if (dismissed) return null

  return (
    <Alert
      className={classNames("flex", className)}
      onClose={() => setDismissed(true)}
      variant={variant}
      {...rest}
    >
      <AlertIcon icon={IconComponent} variant={variant} />
      {children}
    </Alert>
  )
}
