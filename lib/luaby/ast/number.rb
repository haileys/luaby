class Luaby::AST::Number
  attr_reader :number
  
  def initialize(number)
    @number = number
  end
  
  def to_lua
    "#{number}"
  end
end