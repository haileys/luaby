class Luaby::AST::FunctionDeclaration
  attr_reader :names, :params, :body
  
  def initialize(names, params, body)
    @names = names
    @params = params
    @body = body
  end
end