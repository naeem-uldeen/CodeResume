class RunLengthEncoding

  def self.encode(text)
    return text if text.empty?
    new(text).compress
  end

  def self.decode(text)
    return text if text.empty?
    new(text).expand
  end

  private

  attr_accessor :text

  def initialize(text)
    self.text = text
  end

  # Shared

  def characters
    text.chars
  end

  # Compress helpers

  def character_runs
    characters
      .chunk_while { |current, next_character|
        current == next_character
      }.map { |run| [run.first, run.length] }
  end

  def format_compression(character, count)
    '%<count>s%<character>s' %
      { count: count > 1 ? count : '', character: character }
  end

  def compress_runs(runs)
    runs.map { |c, count| format_compression(c, count) }
  end

  def join_compression(compressed)
    compressed.join
  end

  # Expand helpers

  def parse_encoded_runs
    characters.slice_when { |c, _| c.match?(/[a-zA-Z ]/) }.to_a
  end

  def parse_run(encoded_run)
    digits = encoded_run[0..-2].join
    count  = digits.empty? ? 1 : digits.to_i
    [count, encoded_run[-1]]
  end

  def expand_run(encoded_run)
    count, character = parse_run(encoded_run)
    character * count
  end

  def expand_runs(encoded_runs)
    encoded_runs.map { |encoded_run| expand_run(encoded_run) }
  end

  def join_expansion(expanded)
    expanded.join
  end

  public

  def compress
    character_runs
      .then(&method(:compress_runs))
      .then(&method(:join_compression))
  end

  def expand
    parse_encoded_runs
      .then(&method(:expand_runs))
      .then(&method(:join_expansion))
  end

end
