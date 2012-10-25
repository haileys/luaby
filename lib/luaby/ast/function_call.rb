class Luaby::AST::FunctionCall
  attr_reader :function, :args
  
  def initialize(function, args)
    @function = function
    @args = args
  end
  
  def prefix_exp?
    true
  end
  
  def to_lua
    if function.respond_to? :prefix_exp? and function.prefix_exp?
      "#{function.to_lua}(#{args.to_lua})"
    else
      "(#{function.to_lua})(#{args.to_lua})"
    end
  end
end