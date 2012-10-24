class Luaby::AST::Repeat
  attr_reader :block, :exp
  
  def initialize(block, exp)
    @block = block
    @exp = exp
  end
  
  def to_lua
    "repeat\n#{block.to_lua}\nuntil #{exp.to_lua}"
  end
end