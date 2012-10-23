class Luaby::SyntaxError < StandardError
  attr_reader :line, :column
  
  def initialize(message, line, column)
    @line = line
    @column = column
    super message
  end
end