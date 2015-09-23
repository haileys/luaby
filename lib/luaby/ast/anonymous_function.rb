class Luaby::AST::AnonymousFunction
  attr_reader :func

  def initialize(func)
    @func = func
  end

  def to_lua
    "function #{func.to_lua}"
  end
end
