module Luaby
  require "luaby/syntax_error"
  require "luaby/parser"
  require "luaby/token"
  require "luaby/lexer"
  require "luaby/ast"
  
  def self.parse(source)
    tokens = Lexer.new(source).read
    Parser.new(tokens).parse
  end
end