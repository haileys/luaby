class Luaby::AST::MethodCall
  attr_reader :receiver, :method, :args
  
  def initialize(receiver, method, args)
    @receiver = receiver
    @method = method
    @args = args
  end
end