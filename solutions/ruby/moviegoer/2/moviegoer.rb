class NotMovieClubMemberError < RuntimeError
  def initialize(message = 'No free popcorn for non-members.')
    super
  end
end

class Moviegoer

  ADULT = 17
  SENIOR_DISCOUNT = 10
  REGULAR_ADMISSONS = 15
  private_constant :ADULT, :SENIOR_DISCOUNT, :REGULAR_ADMISSONS

  private

  attr_accessor :age, :member

  def initialize(age, member: false)
    self.age = age
    self.member = member
  end

  public

  def ticket_price
    age > 59 ? SENIOR_DISCOUNT : REGULAR_ADMISSONS
  end

  def watch_scary_movie?
    age > ADULT
  end

  def claim_free_popcorn!
   member or raise(NotMovieClubMemberError)
  '🍿'
  end

end
