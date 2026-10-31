module FlattenArray
  
  SKIP    = ->(_item, result) { result }
  KEEP    = ->(item, result)  { result << item }
  DESCEND = ->(item, result)  { flatten(item, result) }

  HANDLERS = Hash.new(KEEP).merge(
    NilClass => SKIP,
    Array    => DESCEND
  )

  def self.flatten(items, result = [])
    items.each { |item| HANDLERS[item.class].call(item, result) }

    result
  end

end
