class Luaby::AST::Block
  attr_reader :statements
  
  def initialize(statements)
    @statements = [*statements]
  end
end