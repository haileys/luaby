class Luaby::AST::If
  attr_reader :conditions, :bodies, :else_body
  
  def initialize(conditions, bodies, else_body)
    @conditions = conditions
    @bodies = bodies
    @else_body = else_body
  end
  
  def to_lua
    str = conditions.zip(bodies).map { |cond, body|
      "elsif #{cond.to_lua} then\n#{body.to_lua}"
    }.join("\n")
    str = str[3..-1]
    if else_body
      str << "\nelse\n#{else_body.to_lua}\nend"
    end
    str << "\nend"
  end
end