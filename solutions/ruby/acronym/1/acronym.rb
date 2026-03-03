module Acronym

  def self.abbreviate expansion
    result = ''

    for word in expansion
      .tr('-', ' ')
      .tr('_', '')
      .tr("'", '')
      .tr(',', '')
      .split

      result << word.capitalize.chr
    end

    result
  end

end
