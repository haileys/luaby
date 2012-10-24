class Luaby::AST::ForIn
  attr_reader :namelist, :explist, :block
  
  def initialize(namelist, explist, block)
    @namelist = namelist
    @explist = explist
    @block = block
  end
  
  def to_lua
    "for #{namelist.join ", "} in #{explist.map(&:to_lua).join ", "} do\n#{block.to_lua}\nend"
  end
end