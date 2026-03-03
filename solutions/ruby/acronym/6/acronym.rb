module Acronym

  class << self

    private

    STEPS = [
      -> { _1.tr("-", ' ') },
      -> { _1.upcase },
      -> { _1.gsub(/[[:punct:]]/, '') },
      -> { _1.split },
      -> { _1.map(&:chr) }
    ]

    public

    def abbreviate(expansion)
      # _1 is the accumulator (acc), _2 is the lambda (step)
      STEPS.reduce(expansion) { _2.call(_1) }.join
    end

  end

end
      