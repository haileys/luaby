class Luaby::AST::ForFromTo
  attr_reader :var, :from, :to, :block
  
  def initialize(var, from, to, block)
    @var = var
    @from = from
    @to = to
    @block = block
  end
end