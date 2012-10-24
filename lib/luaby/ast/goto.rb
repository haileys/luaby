class Luaby::AST::Goto
  attr_reader :label
  
  def initialize(label)
    @label = label
  end
  
  def to_lua
    "goto #{label}"
  end
end