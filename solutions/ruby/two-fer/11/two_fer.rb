TwoFer = 'One for %{name}, one for me.'

def TwoFer.two_fer(name = 'you')
  self % {name:}
end
