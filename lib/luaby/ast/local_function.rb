class Luaby::AST::LocalFunction
  attr_reader :name, :funcbody
  
  def initialize(name, funcbody)
    @name = name
    @funcbody = funcbody
  end
  
  def to_lua
    "local function #{name}#{funcbody.to_lua}"
  end
end