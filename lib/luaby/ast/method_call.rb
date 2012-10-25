class Luaby::AST::MethodCall
  attr_reader :receiver, :method, :args
  
  def initialize(receiver, method, args)
    @receiver = receiver
    @method = method
    @args = args
  end
  
  def prefix_exp?
    true
  end
  
  def to_lua
    if receiver.respond_to? :prefix_exp? and receiver.prefix_exp?
      "#{receiver.to_lua}:#{method}(#{args.to_lua})"
    else
      "(#{receiver.to_lua}):#{method}(#{args.to_lua})"
    end
  end
end