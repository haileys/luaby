class Luaby::AST::StringLiteral
  attr_reader :string
  
  def initialize(string)
    @string = string
  end
  
  def valid_name?
    string =~ /\A[a-zA-Z0-9][a-zA-Z0-9_]*\z/
  end
  
  def to_lua
    string.inspect
  end
end