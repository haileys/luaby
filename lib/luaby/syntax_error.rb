class Luaby::SyntaxError < StandardError
  attr_reader :offset, :source
  
  def initialize(message, offset, source)
    @offset = offset
    @source = source
    super "#{message} at line #{line}, column #{column}"
  end
  
  def line
    source[0..offset].count("\n") + 1
  end
  
  def column
    source[0..offset].split("\n").last.size
  end
  
  def source_line
    source.split("\n")[line - 1]
  end
  
  def caret
    "~" * (column - 1) + "^"
  end
end