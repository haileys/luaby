class Luaby::AST::Chunk
  attr_reader :statements
  
  def initialize(statements)
    @statements = [*statements]
  end
  
  def to_lua
    statements.map(&:to_lua).join "\n"
  end
end