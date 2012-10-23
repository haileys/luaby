class Luaby::AST::Function
  attr_reader :params, :body
  
  def initialize(params, body)
    @params = params
    @body = body
  end
end