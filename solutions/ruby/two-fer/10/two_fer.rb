TwoFer = { template: 'One for %s, one for me.' }

def TwoFer.two_fer(name = 'you')
  self[:template] % name
end
