class Luaby::AST::Function
  attr_reader :name, :body
  
  def initialize(name, body)
    @name = name
    @body = body
  end
end