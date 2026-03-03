TwoFer = ->(name = 'you') { 'One for %s, one for me.' % name }

def TwoFer.two_fer(name = "you")
  self.call(name)
end
