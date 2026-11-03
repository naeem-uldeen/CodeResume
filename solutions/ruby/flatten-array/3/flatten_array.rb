module FlattenArray

  SKIP    = ->(_item, result) { result }
  KEEP    = ->(item, result)  { result << item }
  DESCEND = ->(item, result)  { flatten(item, result) }
  HANDLE = {
    NilClass => SKIP,
    Array    => DESCEND,
    Integer  => KEEP,
    Float    => KEEP,
    String   => KEEP,
    Symbol   => KEEP
  }

  def self.flatten(items, result = [])
    items.each { |item| HANDLE[item.class][item, result] }

    result
  end

end
