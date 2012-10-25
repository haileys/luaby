class Luaby::AST::ForIn
  attr_reader :namelist, :exp_list, :block
  
  def initialize(namelist, exp_list, block)
    @namelist = namelist
    @exp_list = exp_list
    @block = block
  end
  
  def to_lua
    "for #{namelist.join ", "} in #{exp_list.to_lua} do\n#{block.to_lua}\nend"
  end
end