const suffixes = {
  1: 'st',
  2: 'nd',
  3: 'rd',
}

const ordinalSuffix = (number) => {
  const lastTwoDigits = number % 100

  if (lastTwoDigits >= 11 && lastTwoDigits <= 13) {
    return 'th'
  }

  return suffixes[number % 10] ?? 'th'
}

export const format = (name, number) =>
  `${name}, you are the ${number}${ordinalSuffix(number)} customer we serve today. Thank you!`
