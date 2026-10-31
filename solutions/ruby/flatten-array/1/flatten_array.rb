module FlattenArray

  def self.flatten(items, result = [])
    items.each do |item|
      case item
      when nil   then next
      when Array then flatten(item, result)
      else            result << item
      end
    end

    result
  end

end
