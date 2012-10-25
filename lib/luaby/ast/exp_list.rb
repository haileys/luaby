class Luaby::AST::ExpList
  attr_reader :expressions
  
  def initialize(expressions)
    @expressions = expressions
  end
  
  def to_lua
    expressions.map(&:to_lua).join(", ")
  end
end