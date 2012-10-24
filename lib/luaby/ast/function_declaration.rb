class Luaby::AST::FunctionDeclaration
  attr_reader :names, :is_self, :funcbody
  
  def initialize(names, is_self, funcbody)
    @names = names
    @is_self = is_self
    @funcbody = funcbody
  end
  
  def to_lua
    if is_self
      prefix_names, name = names
      name = "#{prefix_names.join(".")}:#{name}"
    else
      name = "#{names.join(".")}"
    end
    "function #{name}#{funcbody.to_lua}"
  end
end