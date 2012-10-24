class Luaby::AST::Variable
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
  
  def prefix_exp?
    true
  end
  
  def to_lua
    name
  end
end