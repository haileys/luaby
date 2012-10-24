class Luaby::AST::Assignment
  attr_reader :left_vals, :right_vals
  
  def initialize(left_vals, right_vals)
    @left_vals = [*left_vals]
    @right_vals = [*right_vals]
  end
  
  def to_lua
    left = left_vals.map(&:to_lua).join(", ")
    right = right_vals.map(&:to_lua).join(", ")
    "#{left} = #{right}"
  end
end