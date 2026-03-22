module EliudsEggs

  def self.egg_count(integer)
    integer.zero? ? 0 : 1 + egg_count(integer & integer - 1)
  end

end
