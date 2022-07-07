import getLuminance from "./getLuminance"

// Based on luminance, pick the best suited contrast color (dark/light) to the target color
export default function getContrastColor(target, dark, light) {
  const targetLuminance = getLuminance(target)
  const darkLuminance = getLuminance(dark)
  const lightLuminance = getLuminance(light)

  const darkDiff = Math.abs(targetLuminance - darkLuminance)
  const lightDiff = Math.abs(targetLuminance - lightLuminance)

  return darkDiff > lightDiff ? dark : light
}
