export const format = (name, number) => {
  const lastTwoDigits = number % 100;
  const ordinalSuffix = lastTwoDigits >= 11 && lastTwoDigits <= 13
    ? 'th'
    : ({ 1: 'st', 2: 'nd', 3: 'rd' }[number % 10] ?? 'th')

  return `${name}, you are the ${number}${ordinalSuffix} customer we serve today. Thank you!`
}
