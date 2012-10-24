class Luaby::AST::Not
  attr_accessor :operand
  
  def initialize(operand)
    @operand = operand
  end
end