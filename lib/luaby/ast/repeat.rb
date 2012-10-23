class Luaby::AST::Repeat
  attr_reader :block, :exp
  
  def initialize(block, exp)
    @block = block
    @exp = exp
  end
end