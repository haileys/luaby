class Luaby::AST::If
  attr_reader :conditions, :bodies, :else_body
  
  def initialize(conditions, bodies, else_body)
    @conditions = conditions
    @bodies = bodies
    @else_body = else_body
  end
end