class Luaby::AST::LocalDeclaration
  attr_reader :namelist, :explist
  
  def initialize(namelist, explist)
    @namelist = namelist
    @explist = explist
  end
  
  def to_lua
    left = namelist.join(", ")
    right = explist.map(&:to_lua).join(", ")
    "local #{left} = #{right}"
  end
end