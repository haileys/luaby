class Luaby::AST::Number
  attr_reader :number
  
  def initialize(number)
    @number = number
  end
  
  def to_lua
    if number % 1.0 == 0.0
      number.to_i.to_s
    else
      number.to_s
    end
  end
end