class Luaby::AST::LocalDeclaration
  attr_reader :namelist, :explist
  
  def initialize(namelist, explist)
    @namelist = namelist
    @explist = explist
  end
  
  def to_lua
    left = namelist.join(", ")
    if explist.any?
      right = explist.map(&:to_lua).join(", ")
      "local #{left} = #{right}"
    else
      "local #{left}"
    end
  end
end