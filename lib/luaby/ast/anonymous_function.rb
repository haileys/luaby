class Luaby::AST::AnonymousFunction
  attr_reader :params, :body

  def initialize(params, body)
    @params = params
    @body = body
  end

  def to_lua
    "function (#{params.to_lua})\n#{body.to_lua.lines.map { |x| "#{Luaby::INDENT}#{x}" }.join}\nend"
  end
end
