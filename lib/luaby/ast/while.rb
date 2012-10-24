class Luaby::AST::While
  attr_reader :exp, :block
  
  def initialize(exp, block)
    @exp = exp
    @block = block
  end
  
  def to_lua
    "while #{exp.to_lua} do\n#{block.to_lua}\nend"
  end
end