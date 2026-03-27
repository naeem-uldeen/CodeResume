Reverser = ->(collection) {
  reverse_recursive = ->(original, reversed = original.class.new) {
    return reversed if original.empty?
    reverse_recursive.call(
      original[1..],
      original[0] + reversed
    )
  }
  reverse_recursive.call(collection)
}

def Reverser.reverse(collection) = self.call(collection)
