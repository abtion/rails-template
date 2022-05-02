import prepareColorVariables from "./prepareColorVariables"

describe(prepareColorVariables, () => {
  const jsonColors = {
    dark: "#000",
    light: "#FFF",
    neutral: {
      DEFAULT: "#313131",
      "50": "#F1F1F1",
      "800": "#313131",
    },
    primary: {
      DEFAULT: "#00ABAB",
      "400": "#00ABAB",
      "900": "#003333",
    },
  }

  describe("returned cssVariables", () => {
    it("is a correct list of css variables based on the provided colors", () => {
      const result = prepareColorVariables(jsonColors)

      expect(result.cssVariables).toEqual({
        "--color-dark": "#000",
        "--color-light": "#FFF",
        "--color-neutral": "#313131",
        "--color-neutral-50": "#F1F1F1",
        "--color-neutral-800": "#313131",
        "--color-primary": "#00ABAB",
        "--color-primary-400": "#00ABAB",
        "--color-primary-900": "#003333",
      })
    })
  })

  describe("returned tailwindConfig", () => {
    it("includes all the colors set to their corresponding css variables", () => {
      const result = prepareColorVariables(jsonColors)

      expect(result.tailwindConfig).toMatchObject({
        dark: {
          DEFAULT: "var(--color-dark)",
        },
        light: {
          DEFAULT: "var(--color-light)",
        },
        neutral: {
          "50": "var(--color-neutral-50)",
          "800": "var(--color-neutral-800)",
          DEFAULT: "var(--color-neutral)",
        },
        primary: {
          "400": "var(--color-primary-400)",
          "900": "var(--color-primary-900)",
          DEFAULT: "var(--color-primary)",
        },
      })
    })

    it("includes computed contrast colors for variants", () => {
      const result = prepareColorVariables(jsonColors)

      expect(result.tailwindConfig).toMatchObject({
        neutral: {
          "50-contrast": "var(--color-dark)",
          "800-contrast": "var(--color-light)",
          contrast: "var(--color-light)",
        },
        primary: {
          "400-contrast": "var(--color-light)",
          "900-contrast": "var(--color-light)",
          contrast: "var(--color-light)",
        },
      })
    })
  })

  describe("when a contrast color has been manually specified", () => {
    const jsonColorsWithContrast = {
      ...jsonColors,
      neutral: {
        ...jsonColors.neutral,
        contrast: "#FFF",
      },
      primary: {
        ...jsonColors.primary,
        "400-contrast": "#000",
      },
    }

    it("adds the contrast colors to the returned cssVariables", () => {
      const result = prepareColorVariables(jsonColorsWithContrast)

      expect(result.cssVariables).toMatchObject({
        "--color-neutral-contrast": "#FFF",
        "--color-primary-400-contrast": "#000",
      })
    })

    it("uses the contrast colors in the generated tailwindConfig", () => {
      const result = prepareColorVariables(jsonColorsWithContrast)

      expect(result.tailwindConfig).toMatchObject({
        neutral: {
          contrast: "var(--color-neutral-contrast)",
        },
        primary: {
          "400-contrast": "var(--color-primary-400-contrast)",
        },
      })
    })
  })
})
