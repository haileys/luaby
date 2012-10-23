class Luaby::AST::While
  attr_reader :exp, :block
  
  def initialize(exp, block)
    @exp = exp
    @block = block
  end
end