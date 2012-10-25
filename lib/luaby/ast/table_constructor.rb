class Luaby::AST::TableConstructor
  attr_accessor :pairs
  
  def initialize(pairs)
    @pairs = pairs
  end
  
  def to_lua
    if pairs.empty?
      "{}"
    elsif pairs.size == 1
      "{ #{format_pair pairs.first} }"
    else
      inner = pairs.map { |pair| "#{Luaby::INDENT}#{format_pair pair}" }.join(",\n")
      "{\n#{inner}\n}"
    end
  end
  
  def format_pair(pair)
    key, value = pair
    if key
      if key.is_a? Luaby::AST::StringLiteral and key.valid_name?
        "#{key.string} = #{value.to_lua}"
      else
        "[#{key.to_lua}] = #{value}"
      end
    else
      value.to_lua
    end
  end
end