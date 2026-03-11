Year = ->(year) {

  is_leap = ->(year) {
    year.modulo(4).zero? && !year.modulo(100).zero? or
      year.modulo(400).zero?
  }

  is_leap.call(year)

}

def Year.leap?(year) = self.call(year)
