module Acronym

    STEPS = [
      -> { _1.tr('-', ' ') },
      -> { _1.upcase },
      -> { _1.gsub(/[[:punct:]]/, '') },
      -> { _1.split },
      -> { _1.map(&:chr) },
      -> { _1.reduce('') { |abbreviation, letter| abbreviation << letter } }
    ]
    private_constant :STEPS

    def self.abbreviate(expansion)
      STEPS.reduce(expansion) { |abbreviation, step| step === abbreviation }
    end

end
