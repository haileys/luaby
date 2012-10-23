class Luaby::AST::FunctionDeclaration
  attr_reader :name, :params, :body
  
  def initialize(name, params, body)
    @name = name
    @params = params
    @body = body
  end
end