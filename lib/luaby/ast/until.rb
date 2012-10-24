class Luaby::AST::Until
  attr_reader :body, :condition
  
  def initialize(body, condition)
    @body = body
    @condition = condition
  end
end