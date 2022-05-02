import React from "react"
import classNames from "classnames"

import Variants from "../../const/variant"

import imageSource from "../../images/muffi-background-image.jpg"
import "./index.scss"

export interface ExampleComponentProps
  extends React.HTMLAttributes<HTMLDivElement> {
  variant?: Variants
}

export default function ExampleComponent(
  props: ExampleComponentProps
): JSX.Element {
  const { children, variant, className, ...rest } = props

  const usedClassName = classNames(
    "border-2 rounded-lg border-neutral-500 p-5 bg-neutral-100",
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
