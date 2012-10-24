class Luaby::AST::ForFromTo
  attr_reader :var, :from, :to, :block
  
  def initialize(var, from, to, block)
    @var = var
    @from = from
    @to = to
    @block = block
  end
  
  def to_lua
    "for #{var} = #{from.to_lua}, #{to.to_lua} do\n#{block.to_lua}\nend"
  end
end