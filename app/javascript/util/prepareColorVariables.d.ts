export as namespace prepareColorVariables

export = prepareColorVariables

declare function prepareColorVariables(
  jsonColors: prepareColorVariables.JsonColors
): prepareColorVariables.PreparedColorVariables

declare namespace prepareColorVariables {
  export interface JsonColors {
    [name: string]: string | Record<string, string>
  }

  export interface CssVariableDefinition {
    [name: string]: string
  }

  export interface TailwindConfig {
    [name: string]: string | Record<string, string>
  }

  export interface PreparedColorVariables {
    cssVariables: CssVariableDefinition
    tailwindConfig: TailwindConfig
  }

  export const defaultName: string
  export let defaultLength: number
}
