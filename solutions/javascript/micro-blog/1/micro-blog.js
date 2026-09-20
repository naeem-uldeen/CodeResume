export const truncate = (input) => {
  // The spread operator ([...input]) uses the string's built-in iterator,
  // which — unlike .length or .slice() — walks by code point rather than by UTF-16 code unit.
  const codePoints = [...input];
  return codePoints.length > 5 ? codePoints.slice(0, 5).join('') : input;
};
