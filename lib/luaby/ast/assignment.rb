class Luaby::AST::Assignment
  attr_reader :left_vals, :right_vals
  
  def initialize(left_vals, right_vals)
    @left_vals = [*left_vals]
    @right_vals = [*right_vals]
  end
end