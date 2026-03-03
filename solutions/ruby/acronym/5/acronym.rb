module Acronym

  class << self

    private

    STEPS = [
      ->(text) { text.tr("-", ' ') },
      ->(text) { text.upcase },
      ->(text) { text.gsub(/[[:punct:]]/, '') },
      ->(text) { text.split },
      ->(words) { words.map(&:chr) }
    ]

    public

    def abbreviate(expansion)
      STEPS.reduce(expansion) { |acc, step| step.call(acc) }.join
    end

  end

end
      