import React, { useState } from "react"
import classNames from "classnames"

import CheckCircleIcon from "@heroicons/react/20/solid/CheckCircleIcon"
import XCircleIcon from "@heroicons/react/20/solid/XCircleIcon"
import ExclamationTriangleIcon from "@heroicons/react/20/solid/ExclamationTriangleIcon"

import Alert from "~/components/Alert"
import AlertIcon from "~/components/AlertIcon"

interface FlashMessageProps extends React.HTMLAttributes<HTMLDivElement> {
  variant: "danger" | "warning" | "success"
}

export default function FlashMessage(props: FlashMessageProps) {
  const { variant, className, children, ...rest } = props
  const [dismissed, setDismissed] = useState(false)

  const IconComponent = {
    danger: XCircleIcon,
    warning: ExclamationTriangleIcon,
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
