Reverser = ->(collection) {
  reverse_recursive = ->(original, reversed = original.class.new) {
    return reversed if original.empty?

    reverse_recursive.call(
      original[0...-1],
      reversed + original[-1]
    )
  }

  reverse_recursive.call(collection)
}

def Reverser.reverse(collection) = self.call(collection)

if $PROGRAM_NAME == __FILE__
  # String tests
  puts "String tests:"
  p Reverser.reverse("")
  p Reverser.reverse("robot")
  p Reverser.reverse("Ramen")
  p Reverser.reverse("I'm hungry!")

  # Array tests
  puts "\nArray tests:"
  p Reverser.reverse([1, 2, 3, 4, 5])
  p Reverser.reverse(['a', 'b', 'c', 'd'])
  p Reverser.reverse([1, 'two', :three, 4.0])
  p Reverser.reverse([])

  # Edge cases
  puts "\nEdge cases:"
  p Reverser.reverse(["hello", "world"])        # ["world", "hello"]
  p Reverser.reverse([[1,2], [3,4], [5,6]])     # [[5,6], [3,4], [1,2]]
end