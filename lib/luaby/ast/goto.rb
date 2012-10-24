class Luaby::AST::Goto
  attr_reader :label
  
  def initialize(label)
    @label = label
  end
end