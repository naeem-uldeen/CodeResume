Year = ->(year) {

  is_leap = ->(year) {
    year.modulo(4).zero? and year.modulo(100).nonzero? or
    year.modulo(400).zero?
  }

  is_leap.call(year)

}

def Year.leap?(year) = self.call(year)
