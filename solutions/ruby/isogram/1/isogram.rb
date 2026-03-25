Isogram = Module.new do
  
  def self.isogram? text
    text
      .delete(' -')
      .downcase
      .chars
      .then { |text| text.uniq == text }
  end
  
end
