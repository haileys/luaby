class Luaby::AST::Assignment
  attr_reader :left_vals, :exp_list
  
  def initialize(left_vals, exp_list)
    @left_vals = [*left_vals]
    @exp_list = exp_list
  end
  
  def to_lua
    left = left_vals.map(&:to_lua).join(", ")
    "#{left} = #{exp_list.to_lua}"
  end
end