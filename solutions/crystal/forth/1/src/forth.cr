module Forth
  extend self

  def evaluate(text : String) : Array(Int32)
    stack = [] of Int32
    definitions = {} of String => Array(String)

    tokens = tokenize(text)
    run(tokens, stack, definitions)

    stack
  end

  private def tokenize(text : String) : Array(String)
    text.gsub(":", " : ").gsub(";", " ; ").split(/\s+/).reject(&.empty?)
  end

  private def run(
    tokens : Array(String),
    stack : Array(Int32),
    definitions : Hash(String, Array(String))
  ) : Nil
    
    process_tokens(tokens, 0, stack, definitions)
  end

  private def process_tokens(
    tokens : Array(String),
    index : Int32,
    stack : Array(Int32),
    definitions : Hash(String, Array(String)),
  ) : Nil
    
    return if index >= tokens.size
    token = tokens[index]

    if token == ":"
      end_index = find_definition_end(tokens, index)
      define_word(tokens, index, end_index, definitions)
      process_tokens(tokens, end_index + 1, stack, definitions)
    else
      execute_token(token, stack, definitions)
      process_tokens(tokens, index + 1, stack, definitions)
    end
  end

  private def find_definition_end(tokens : Array(String), start_index : Int32) : Int32
    find_semicolon(tokens, start_index + 1)
  end

  private def find_semicolon(tokens : Array(String), index : Int32) : Int32
    raise ArgumentError.new("unterminated definition") if index >= tokens.size
    return index if tokens[index] == ";"
    find_semicolon(tokens, index + 1)
  end

  private def define_word(
    tokens : Array(String),
    start_index : Int32,
    end_index : Int32,
    definitions : Hash(String, Array(String)),
  ) : Nil
    name_index = start_index + 1
    raise ArgumentError.new("empty definition") if name_index >= end_index

    name = tokens[name_index].downcase
    raise ArgumentError.new("cannot redefine numbers") if numeric?(name)

    body_tokens = tokens[(name_index + 1)...end_index]
    expanded_body = expand_definition_body(body_tokens, definitions)

    definitions[name] = expanded_body
  end

  private def expand_definition_body(
    body_tokens : Array(String),
    definitions : Hash(String, Array(String)),
  ) : Array(String)
    build_expanded_body(body_tokens, 0, definitions, [] of String)
  end

  private def build_expanded_body(
    body_tokens : Array(String),
    index : Int32,
    definitions : Hash(String, Array(String)),
    accumulator : Array(String),
  ) : Array(String)
    return accumulator if index >= body_tokens.size

    token = body_tokens[index]
    lowered = token.downcase

    expanded_token =
      if definitions.has_key?(lowered)
        definitions[lowered]
      else
        [token]
      end

    build_expanded_body(body_tokens, index + 1, definitions, accumulator + expanded_token)
  end

  private def execute_token(
    token : String,
    stack : Array(Int32),
    definitions : Hash(String, Array(String)),
  ) : Nil
    lowered = token.downcase

    if numeric?(token)
      stack.push(token.to_i32)
    elsif definitions.has_key?(lowered)
      run(definitions[lowered], stack, definitions)
    else
      execute_builtin(lowered, stack)
    end
  end

  private def numeric?(token : String) : Bool
    !!(token =~ /\A-?\d+\z/)
  end

  private def execute_builtin(word : String, stack : Array(Int32)) : Nil
    case word
    when "+"
      apply_binary_op(stack) { |a, b| a + b }
    when "-"
      apply_binary_op(stack) { |a, b| a - b }
    when "*"
      apply_binary_op(stack) { |a, b| a * b }
    when "/"
      apply_division(stack)
    when "dup"
      apply_dup(stack)
    when "drop"
      apply_drop(stack)
    when "swap"
      apply_swap(stack)
    when "over"
      apply_over(stack)
    else
      raise ArgumentError.new("undefined word: #{word}")
    end
  end

  private def apply_binary_op(stack : Array(Int32), & : Int32, Int32 -> Int32) : Nil
    require_minimum_size(stack, 2)
    b = stack.pop
    a = stack.pop
    stack.push(yield(a, b))
  end

  private def apply_division(stack : Array(Int32)) : Nil
    require_minimum_size(stack, 2)
    b = stack.pop
    a = stack.pop
    raise ArgumentError.new("divide by zero") if b == 0
    stack.push(a // b)
  end

  private def apply_dup(stack : Array(Int32)) : Nil
    require_minimum_size(stack, 1)
    stack.push(stack.last)
  end

  private def apply_drop(stack : Array(Int32)) : Nil
    require_minimum_size(stack, 1)
    stack.pop
  end

  private def apply_swap(stack : Array(Int32)) : Nil
    require_minimum_size(stack, 2)
    b = stack.pop
    a = stack.pop
    stack.push(b)
    stack.push(a)
  end

  private def apply_over(stack : Array(Int32)) : Nil
    require_minimum_size(stack, 2)
    stack.push(stack[-2])
  end

  private def require_minimum_size(stack : Array(Int32), minimum : Int32) : Nil
    raise ArgumentError.new("stack underflow") if stack.size < minimum
  end

end
