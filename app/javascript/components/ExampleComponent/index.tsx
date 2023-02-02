import React from "react"
import classNames from "classnames"

import { Variant } from "../../const/variant"

import imageSource from "../../images/muffi-background-image.jpg"
import "./index.scss"

export interface ExampleComponentProps
  extends React.HTMLAttributes<HTMLDivElement> {
  variant?: Variant
}

export default function ExampleComponent(
  props: ExampleComponentProps
): JSX.Element {
  const { children, variant, className, ...rest } = props

  const usedClassName = classNames(
    "border-2 rounded-lg p-5",
    {
      [`ExampleComponent--${variant}`]: variant,
    },
    className
  )

  return (
    <div className={usedClassName} {...rest}>
      <h1 className="ExampleComponent__heading text-dark">Example component</h1>
      <p>{children}</p>
      <img
        alt="image"
        className="block"
        src={imageSource}
        width="128"
        height="128"
      />
    </div>
  )
}
