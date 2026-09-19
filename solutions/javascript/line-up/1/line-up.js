export const format = (name, number) => {
  let ordinalSuffix = 'th'

  if (number % 10 === 1 && number % 100 !== 11) {
    ordinalSuffix = 'st'
  } else if (number % 10 === 2 && number % 100 !== 12) {
    ordinalSuffix = 'nd'
  } else if (number % 10 === 3 && number % 100 !== 13) {
    ordinalSuffix = 'rd'
  }

  return `${name}, you are the ${number}${ordinalSuffix} customer we serve today. Thank you!`
}
