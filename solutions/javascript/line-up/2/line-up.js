export const format = (name, number) => {
  const lastTwoDigits = number % 100;
  const lastDigit = number % 10;
  let ordinalSuffix = 'th'

  if (lastDigit === 1 && lastTwoDigits !== 11) {
    ordinalSuffix = 'st'
  } else if (lastDigit === 2 && lastTwoDigits !== 12) {
    ordinalSuffix = 'nd'
  } else if (lastDigit === 3 && lastTwoDigits !== 13) {
    ordinalSuffix = 'rd'
  }

  return `${name}, you are the ${number}${ordinalSuffix} customer we serve today. Thank you!`
}
