Reverser = ->(string) {

  reverse_recursive = ->(original, reversed = "") {
    return reversed if original.empty?
    reverse_recursive.call(
      original[0...-1],
      reversed + original[-1]
    )
  }

  reverse_recursive.call(string)

}

def Reverser.reverse(string) = self.(string)
