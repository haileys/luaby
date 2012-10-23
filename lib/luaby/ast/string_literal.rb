class Luaby::AST::StringLiteral
  attr_reader :string
  
  def initialize(string)
    @string = string
  end
end