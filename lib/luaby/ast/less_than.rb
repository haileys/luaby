class Luaby::AST::LessThan
  attr_accessor :left, :right
  
  def initialize(left, right)
    @left = left
    @right = right
  end
end