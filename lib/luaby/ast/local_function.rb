class Luaby::AST::LocalFunction
  attr_reader :name, :body
  
  def initialize(name, body)
    @name = name
    @body = body
  end
end