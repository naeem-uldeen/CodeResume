module Year

  def self.leap? year
     year.modulo(4).zero? and
     not(year.modulo(100).zero?) or
     year.modulo(400).zero?
  end

end
