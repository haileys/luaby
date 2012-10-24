class Luaby::AST::Parameters
  attr_accessor :variadic, :named_args
  
  def initialize(variadic, named_args)
    @variadic = variadic
    @named_args = named_args
  end
  
  def variadic?
    variadic
  end
  
  def to_lua
    if named_args.any?
      str = "#{named_args.join(", ")}"
      str << ", ..." if variadic?
    else
      "..."
    end
  end
end