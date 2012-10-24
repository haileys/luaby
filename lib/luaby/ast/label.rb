class Luaby::AST::Label
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
  
  def to_lua
    "::#{name}::"
  end
end