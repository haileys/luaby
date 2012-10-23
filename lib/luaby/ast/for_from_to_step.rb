class Luaby::AST::ForFromToStep
  attr_reader :var, :from, :to, :step, :block
  
  def initialize(var, from, to, step, block)
    @var = var
    @from = from
    @to = to
    @step = step
    @block = block
  end
end