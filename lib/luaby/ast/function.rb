class Luaby::AST::Function
  attr_reader :params, :body
  
  def initialize(params, body)
    @params = params
    @body = body
  end
  
  def to_lua
    "(#{params.to_lua})\n#{body.to_lua}\nend"
  end
end