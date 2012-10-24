class Luaby::AST::Negate
  attr_accessor :operand
  
  def initialize(operand)
    @operand = operand
  end
end