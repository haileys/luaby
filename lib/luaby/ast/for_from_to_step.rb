class Luaby::AST::ForFromToStep
  attr_reader :var, :from, :to, :step, :block
  
  def initialize(var, from, to, step, block)
    @var = var
    @from = from
    @to = to
    @step = step
    @block = block
  end
  
  def to_lua
    "for #{var} = #{from.to_lua}, #{to.to_lua}, #{step.to_lua} do\n#{block.to_lua}\nend"
  end
end