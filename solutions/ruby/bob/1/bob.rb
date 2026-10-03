module Bob

  def self.hey statement
    return 'Fine. Be that way!' if statement.strip.empty?

    question = statement.strip.end_with? '?'
    yelling = statement.match?(/[A-Z]/) && !statement.match?(/[a-z]/)

    return 'Calm down, I know what I\'m doing!' if yelling and question
    return 'Whoa, chill out!' if yelling
    return 'Sure.' if question

    'Whatever.'
  end

end
