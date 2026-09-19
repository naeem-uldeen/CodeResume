const ordinalSuffix = (number) => {
  const lastTwoDigits = Math.abs(number) % 100  // handle negatives correctly
  return lastTwoDigits >= 11 && lastTwoDigits <= 13
    ? 'th'
    : ({ 1: 'st', 2: 'nd', 3: 'rd' }[Math.abs(number) % 10] ?? 'th')
}

export const format = (name, number) => {
  if (!Number.isInteger(number) || number < 1) return null
  return `${name}, you are the ${number}${ordinalSuffix(number)} customer we serve today. Thank you!`
}
