class Luaby::AST::FunctionCall
  attr_reader :function, :args
  
  def initialize(function, args)
    @function = function
    @args = args
  end
end