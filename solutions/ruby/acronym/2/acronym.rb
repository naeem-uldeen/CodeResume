module Acronym

  def self.abbreviate expansion
    expansion
    .tr("-", ' ')
    .upcase
    .gsub(/[[:punct:]]/, '')
    .split.each_slice(1)
    .map(&:first)
    .map(&:chr)
    .join
  end

end
