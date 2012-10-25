class Luaby::AST::LocalDeclaration
  attr_reader :namelist, :exp_list
  
  def initialize(namelist, exp_list)
    @namelist = namelist
    @exp_list = exp_list
  end
  
  def to_lua
    left = namelist.join(", ")
    if exp_list.expressions.any?
      "local #{left} = #{exp_list.to_lua}"
    else
      "local #{left}"
    end
  end
end