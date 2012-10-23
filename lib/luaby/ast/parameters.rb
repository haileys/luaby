class Luaby::AST::Parameters
  attr_accessor :variadic, :named_args
  
  def initialize(variadic, named_args)
    @variadic = variadic
    @named_args = named_args
  end
  
  def variadic?
    variadic
  end
end