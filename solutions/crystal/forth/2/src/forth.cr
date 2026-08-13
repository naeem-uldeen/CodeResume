module Forth
  extend self

  def evaluate(text : String) : Array(Int32)
    stack = [] of Int32
    definitions = Hash(String, Array(String)).new
    # Ensure : and ; are always standalone tokens
    tokens = text.gsub(/([:;])/, " \\1 ").split(/\s+/).reject(&.empty?)

    i = 0
    while i < tokens.size
      token = tokens[i]

      if token == ":"
        i = process_definition(tokens, i, definitions)
      else
        execute_token(token, stack, definitions)
        i += 1
      end
    end

    stack
  end

  private def process_definition(
    tokens : Array(String),
    start_index : Int32,
    definitions : Hash(String, Array(String))
  ) : Int32
    end_index = tokens.index(";", start_index + 1)
    raise ArgumentError.new("unterminated definition") unless end_index

    name_index = start_index + 1
    raise ArgumentError.new("empty definition") if name_index >= end_index

    name = tokens[name_index].downcase
    raise ArgumentError.new("cannot redefine numbers") if name.to_i32?

    body_tokens = tokens[(name_index + 1)...end_index]
    
    # Expand macro definitions inline (Forth compile-time behavior)
    expanded_body = Array(String).new
    body_tokens.each do |t|
      lowered = t.downcase
      if expanded = definitions[lowered]?
        expanded_body.concat(expanded)
      else
        expanded_body << t
      end
    end

    definitions[name] = expanded_body
    end_index + 1
  end

  private def execute_token(
    token : String,
    stack : Array(Int32),
    definitions : Hash(String, Array(String))
  ) : Nil
    lowered = token.downcase

    if number = lowered.to_i32?
      stack.push(number)
    elsif expanded = definitions[lowered]?
      expanded.each do |sub_token|
        execute_token(sub_token, stack, definitions)
      end
    else
      execute_builtin(lowered, stack)
    end
  end

  private def execute_builtin(word : String, stack : Array(Int32)) : Nil
    case word
    when "+"
      b, a = pop_two(stack)
      stack.push(a + b)
    when "-"
      b, a = pop_two(stack)
      stack.push(a - b)
    when "*"
      b, a = pop_two(stack)
      stack.push(a * b)
    when "/"
      b, a = pop_two(stack)
      raise ArgumentError.new("divide by zero") if b == 0
      stack.push(a // b)
    when "dup"
      require_size(stack, 1)
      stack.push(stack.last)
    when "drop"
      require_size(stack, 1)
      stack.pop
    when "swap"
      b, a = pop_two(stack)
      stack.push(b)
      stack.push(a)
    when "over"
      require_size(stack, 2)
      stack.push(stack[-2])
    else
      raise ArgumentError.new("undefined word: #{word}")
    end
  end

  private def pop_two(stack : Array(Int32)) : Tuple(Int32, Int32)
    require_size(stack, 2)
    {stack.pop, stack.pop}
  end

  private def require_size(stack : Array(Int32), minimum : Int32) : Nil
    raise ArgumentError.new("stack underflow") if stack.size < minimum
  end

end
