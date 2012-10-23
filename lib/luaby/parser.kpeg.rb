require 'kpeg/compiled_parser'

class Luaby::Parser < KPeg::CompiledParser
  # :stopdoc:

  # - = (Whitespace | Comment)
  def __hyphen_

    _save = self.pos
    while true # choice
      _tmp = apply(:_Whitespace)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_Comment)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :__hyphen_ unless _tmp
    return _tmp
  end

  # Whitespace = /\s*/ -
  def _Whitespace

    _save = self.pos
    while true # sequence
      _tmp = scan(/\A(?-mix:\s*)/)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:__hyphen_)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Whitespace unless _tmp
    return _tmp
  end

  # Comment = ("--" /[^\n]/ - | "--[[" /.*?\]\]--/ -)
  def _Comment

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _tmp = match_string("--")
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = scan(/\A(?-mix:[^\n])/)
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:__hyphen_)
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save2 = self.pos
      while true # sequence
        _tmp = match_string("--[[")
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = scan(/\A(?-mix:.*?\]\]--)/)
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:__hyphen_)
        unless _tmp
          self.pos = _save2
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_Comment unless _tmp
    return _tmp
  end

  # StringCharacter = ("\\a" { "\a" } | "\\b" { "\b" } | "\\f" { "\f" } | "\\n" { "\n" } | "\\r" { "\r" } | "\\t" { "\t" } | "\\v" { "\v" } | "\\x" < /[A-Fa-f0-9]{2}/ > { text.to_i(16).chr } | "\\\\" { "\\" } | "\\\n" { "\n" } | "\\" { "\n" } | "\\z" " "* { nil } | "\\" < /[0-9]{1,3}/ > { text.to_i(10).chr } | < /[^'"\\]/ > { text })
  def _StringCharacter

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _tmp = match_string("\\a")
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin;  "\a" ; end
        _tmp = true
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save2 = self.pos
      while true # sequence
        _tmp = match_string("\\b")
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin;  "\b" ; end
        _tmp = true
        unless _tmp
          self.pos = _save2
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save3 = self.pos
      while true # sequence
        _tmp = match_string("\\f")
        unless _tmp
          self.pos = _save3
          break
        end
        @result = begin;  "\f" ; end
        _tmp = true
        unless _tmp
          self.pos = _save3
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save4 = self.pos
      while true # sequence
        _tmp = match_string("\\n")
        unless _tmp
          self.pos = _save4
          break
        end
        @result = begin;  "\n" ; end
        _tmp = true
        unless _tmp
          self.pos = _save4
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save5 = self.pos
      while true # sequence
        _tmp = match_string("\\r")
        unless _tmp
          self.pos = _save5
          break
        end
        @result = begin;  "\r" ; end
        _tmp = true
        unless _tmp
          self.pos = _save5
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save6 = self.pos
      while true # sequence
        _tmp = match_string("\\t")
        unless _tmp
          self.pos = _save6
          break
        end
        @result = begin;  "\t" ; end
        _tmp = true
        unless _tmp
          self.pos = _save6
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save7 = self.pos
      while true # sequence
        _tmp = match_string("\\v")
        unless _tmp
          self.pos = _save7
          break
        end
        @result = begin;  "\v" ; end
        _tmp = true
        unless _tmp
          self.pos = _save7
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save8 = self.pos
      while true # sequence
        _tmp = match_string("\\x")
        unless _tmp
          self.pos = _save8
          break
        end
        _text_start = self.pos
        _tmp = scan(/\A(?-mix:[A-Fa-f0-9]{2})/)
        if _tmp
          text = get_text(_text_start)
        end
        unless _tmp
          self.pos = _save8
          break
        end
        @result = begin;  text.to_i(16).chr ; end
        _tmp = true
        unless _tmp
          self.pos = _save8
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save9 = self.pos
      while true # sequence
        _tmp = match_string("\\\\")
        unless _tmp
          self.pos = _save9
          break
        end
        @result = begin;  "\\" ; end
        _tmp = true
        unless _tmp
          self.pos = _save9
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save10 = self.pos
      while true # sequence
        _tmp = match_string("\\\n")
        unless _tmp
          self.pos = _save10
          break
        end
        @result = begin;  "\n" ; end
        _tmp = true
        unless _tmp
          self.pos = _save10
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save11 = self.pos
      while true # sequence
        _tmp = match_string("\\\r")
        unless _tmp
          self.pos = _save11
          break
        end
        @result = begin;  "\n" ; end
        _tmp = true
        unless _tmp
          self.pos = _save11
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save12 = self.pos
      while true # sequence
        _tmp = match_string("\\z")
        unless _tmp
          self.pos = _save12
          break
        end
        while true
          _tmp = match_string(" ")
          break unless _tmp
        end
        _tmp = true
        unless _tmp
          self.pos = _save12
          break
        end
        @result = begin;  nil ; end
        _tmp = true
        unless _tmp
          self.pos = _save12
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save14 = self.pos
      while true # sequence
        _tmp = match_string("\\")
        unless _tmp
          self.pos = _save14
          break
        end
        _text_start = self.pos
        _tmp = scan(/\A(?-mix:[0-9]{1,3})/)
        if _tmp
          text = get_text(_text_start)
        end
        unless _tmp
          self.pos = _save14
          break
        end
        @result = begin;  text.to_i(10).chr ; end
        _tmp = true
        unless _tmp
          self.pos = _save14
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save15 = self.pos
      while true # sequence
        _text_start = self.pos
        _tmp = scan(/\A(?-mix:[^'"\\])/)
        if _tmp
          text = get_text(_text_start)
        end
        unless _tmp
          self.pos = _save15
          break
        end
        @result = begin;  text ; end
        _tmp = true
        unless _tmp
          self.pos = _save15
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_StringCharacter unless _tmp
    return _tmp
  end

  # DoubleQuotedStringCharacter = (< StringCharacter > { text } | "'" { text })
  def _DoubleQuotedStringCharacter

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _text_start = self.pos
        _tmp = apply(:_StringCharacter)
        if _tmp
          text = get_text(_text_start)
        end
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin;  text ; end
        _tmp = true
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save2 = self.pos
      while true # sequence
        _tmp = match_string("'")
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin;  text ; end
        _tmp = true
        unless _tmp
          self.pos = _save2
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_DoubleQuotedStringCharacter unless _tmp
    return _tmp
  end

  # SingleQuotedStringCharacter = (< StringCharacter > { text } | "\"" { text })
  def _SingleQuotedStringCharacter

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _text_start = self.pos
        _tmp = apply(:_StringCharacter)
        if _tmp
          text = get_text(_text_start)
        end
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin;  text ; end
        _tmp = true
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save2 = self.pos
      while true # sequence
        _tmp = match_string("\"")
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin;  text ; end
        _tmp = true
        unless _tmp
          self.pos = _save2
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_SingleQuotedStringCharacter unless _tmp
    return _tmp
  end

  # String = ("\"" < DoubleQuotedStringCharacter*:str > "\"" - { str } | "'" < SingleQuotedStringCharacter*:str > "'" - { str })
  def _String

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _tmp = match_string("\"")
        unless _tmp
          self.pos = _save1
          break
        end
        _text_start = self.pos
        _ary = []
        while true
          _tmp = apply(:_DoubleQuotedStringCharacter)
          _ary << @result if _tmp
          break unless _tmp
        end
        _tmp = true
        @result = _ary
        str = @result
        if _tmp
          text = get_text(_text_start)
        end
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = match_string("\"")
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:__hyphen_)
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin;  str ; end
        _tmp = true
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save3 = self.pos
      while true # sequence
        _tmp = match_string("'")
        unless _tmp
          self.pos = _save3
          break
        end
        _text_start = self.pos
        _ary = []
        while true
          _tmp = apply(:_SingleQuotedStringCharacter)
          _ary << @result if _tmp
          break unless _tmp
        end
        _tmp = true
        @result = _ary
        str = @result
        if _tmp
          text = get_text(_text_start)
        end
        unless _tmp
          self.pos = _save3
          break
        end
        _tmp = match_string("'")
        unless _tmp
          self.pos = _save3
          break
        end
        _tmp = apply(:__hyphen_)
        unless _tmp
          self.pos = _save3
          break
        end
        @result = begin;  str ; end
        _tmp = true
        unless _tmp
          self.pos = _save3
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_String unless _tmp
    return _tmp
  end

  # Do = "do" -
  def _Do

    _save = self.pos
    while true # sequence
      _tmp = match_string("do")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:__hyphen_)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Do unless _tmp
    return _tmp
  end

  # End = "end" -
  def _End

    _save = self.pos
    while true # sequence
      _tmp = match_string("end")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:__hyphen_)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_End unless _tmp
    return _tmp
  end

  # While = "while" -
  def _While

    _save = self.pos
    while true # sequence
      _tmp = match_string("while")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:__hyphen_)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_While unless _tmp
    return _tmp
  end

  # Repeat = "repeat" -
  def _Repeat

    _save = self.pos
    while true # sequence
      _tmp = match_string("repeat")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:__hyphen_)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Repeat unless _tmp
    return _tmp
  end

  # Until = "until" -
  def _Until

    _save = self.pos
    while true # sequence
      _tmp = match_string("until")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:__hyphen_)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Until unless _tmp
    return _tmp
  end

  # If = "if" -
  def _If

    _save = self.pos
    while true # sequence
      _tmp = match_string("if")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:__hyphen_)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_If unless _tmp
    return _tmp
  end

  # Then = "then" -
  def _Then

    _save = self.pos
    while true # sequence
      _tmp = match_string("then")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:__hyphen_)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Then unless _tmp
    return _tmp
  end

  # Else = "else" -
  def _Else

    _save = self.pos
    while true # sequence
      _tmp = match_string("else")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:__hyphen_)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Else unless _tmp
    return _tmp
  end

  # Elsif = "elsif" -
  def _Elsif

    _save = self.pos
    while true # sequence
      _tmp = match_string("elsif")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:__hyphen_)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Elsif unless _tmp
    return _tmp
  end

  # Equals = "=" -
  def _Equals

    _save = self.pos
    while true # sequence
      _tmp = match_string("=")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:__hyphen_)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Equals unless _tmp
    return _tmp
  end

  # Function = "function" -
  def _Function

    _save = self.pos
    while true # sequence
      _tmp = match_string("function")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:__hyphen_)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Function unless _tmp
    return _tmp
  end

  # Break = "break" -
  def _Break

    _save = self.pos
    while true # sequence
      _tmp = match_string("break")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:__hyphen_)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Break unless _tmp
    return _tmp
  end

  # Return = "return" -
  def _Return

    _save = self.pos
    while true # sequence
      _tmp = match_string("return")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:__hyphen_)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Return unless _tmp
    return _tmp
  end

  # Goto = "goto" -
  def _Goto

    _save = self.pos
    while true # sequence
      _tmp = match_string("goto")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:__hyphen_)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Goto unless _tmp
    return _tmp
  end

  # Comma = "," -
  def _Comma

    _save = self.pos
    while true # sequence
      _tmp = match_string(",")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:__hyphen_)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Comma unless _tmp
    return _tmp
  end

  # Semicolon = ";" -
  def _Semicolon

    _save = self.pos
    while true # sequence
      _tmp = match_string(";")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:__hyphen_)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Semicolon unless _tmp
    return _tmp
  end

  # DoubleColon = "::" -
  def _DoubleColon

    _save = self.pos
    while true # sequence
      _tmp = match_string("::")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:__hyphen_)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_DoubleColon unless _tmp
    return _tmp
  end

  # Name = /[a-zA-Z_][a-zA-Z_0-9]*/ -
  def _Name

    _save = self.pos
    while true # sequence
      _tmp = scan(/\A(?-mix:[a-zA-Z_][a-zA-Z_0-9]*)/)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:__hyphen_)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Name unless _tmp
    return _tmp
  end

  # string_literal = < String:str > { Luaby::AST::StringLiteral.new str.compact.join }
  def _string_literal

    _save = self.pos
    while true # sequence
      _text_start = self.pos
      _tmp = apply(:_String)
      str = @result
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  Luaby::AST::StringLiteral.new str.compact.join ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_string_literal unless _tmp
    return _tmp
  end

  # var = < Name > { Luaby::AST::Variable.new text }
  def _var

    _save = self.pos
    while true # sequence
      _text_start = self.pos
      _tmp = apply(:_Name)
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  Luaby::AST::Variable.new text ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_var unless _tmp
    return _tmp
  end

  # stat_semi = < stat > ";"? { text }
  def _stat_semi

    _save = self.pos
    while true # sequence
      _text_start = self.pos
      _tmp = apply(:_stat)
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _tmp = match_string(";")
      unless _tmp
        _tmp = true
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  text ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_stat_semi unless _tmp
    return _tmp
  end

  # chunk = stat_semi*:stats laststat:laststat? { Luaby::AST::Block.new(laststat ? [*stats, laststat] : stats) }
  def _chunk

    _save = self.pos
    while true # sequence
      _ary = []
      while true
        _tmp = apply(:_stat_semi)
        _ary << @result if _tmp
        break unless _tmp
      end
      _tmp = true
      @result = _ary
      stats = @result
      unless _tmp
        self.pos = _save
        break
      end
      _save2 = self.pos
      _tmp = apply(:_laststat)
      laststat = @result
      unless _tmp
        _tmp = true
        self.pos = _save2
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  Luaby::AST::Block.new(laststat ? [*stats, laststat] : stats) ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_chunk unless _tmp
    return _tmp
  end

  # block = chunk
  def _block
    _tmp = apply(:_chunk)
    set_failed_rule :_block unless _tmp
    return _tmp
  end

  # retstat = Return explist:explist Semicolon? { Luaby::AST::Return.new explist }
  def _retstat

    _save = self.pos
    while true # sequence
      _tmp = apply(:_Return)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_explist)
      explist = @result
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _tmp = apply(:_Semicolon)
      unless _tmp
        _tmp = true
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  Luaby::AST::Return.new explist ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_retstat unless _tmp
    return _tmp
  end

  # stat = (Semicolon { nil } | varlist:lvals Equals explist:rvals { Luaby::AST::Assignment.new lvals, rvals } | functioncall { @TODO } | DoubleColon Name:name DoubleColon { Luaby::AST::Label.new name } | Break { Luaby::AST::Break.new } | Goto Name:name { Luaby::AST::Goto.new name } | Do block:block End { Luaby::AST::Block.new block } | While exp:exp Do block:block End { Luaby::AST::While.new exp, block } | Repeat block:block Until exp:exp { Luaby::AST::Repeat.new block, exp } | If exp:exp Then block:block End { Luaby::AST::If.new exp, block } | For var:var Equals exp:from Comma exp:to Do block:block End { Luaby::AST::ForFromTo.new var, from, to, block } | For var:var Equals exp:from Comma exp:to Comma exp:step Do block:block End { Luaby::AST::ForFromToStep.new var, from, to, step, block } | For namelist:namelist In explist:explist Do block:block End { Luaby::AST::ForIn.new namelist, explist, block } | Local Function Name:name funcbody:body { Luaby::AST::LocalFunction.new name, body } | Function funcname:name funcbody:body { Luaby::AST::Function.new name, body } | Local namelist:names Equals explist:exps { Luaby::AST::LocalAssignment.new names, exps } | Local namelist:namelist { Luaby::AST::LocalDeclaration.new namelist })
  def _stat

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _tmp = apply(:_Semicolon)
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin;  nil ; end
        _tmp = true
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save2 = self.pos
      while true # sequence
        _tmp = apply(:_varlist)
        lvals = @result
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_Equals)
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_explist)
        rvals = @result
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin;  Luaby::AST::Assignment.new lvals, rvals ; end
        _tmp = true
        unless _tmp
          self.pos = _save2
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save3 = self.pos
      while true # sequence
        _tmp = apply(:_functioncall)
        unless _tmp
          self.pos = _save3
          break
        end
        @result = begin;  @TODO ; end
        _tmp = true
        unless _tmp
          self.pos = _save3
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save4 = self.pos
      while true # sequence
        _tmp = apply(:_DoubleColon)
        unless _tmp
          self.pos = _save4
          break
        end
        _tmp = apply(:_Name)
        name = @result
        unless _tmp
          self.pos = _save4
          break
        end
        _tmp = apply(:_DoubleColon)
        unless _tmp
          self.pos = _save4
          break
        end
        @result = begin;  Luaby::AST::Label.new name ; end
        _tmp = true
        unless _tmp
          self.pos = _save4
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save5 = self.pos
      while true # sequence
        _tmp = apply(:_Break)
        unless _tmp
          self.pos = _save5
          break
        end
        @result = begin;  Luaby::AST::Break.new ; end
        _tmp = true
        unless _tmp
          self.pos = _save5
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save6 = self.pos
      while true # sequence
        _tmp = apply(:_Goto)
        unless _tmp
          self.pos = _save6
          break
        end
        _tmp = apply(:_Name)
        name = @result
        unless _tmp
          self.pos = _save6
          break
        end
        @result = begin;  Luaby::AST::Goto.new name ; end
        _tmp = true
        unless _tmp
          self.pos = _save6
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save7 = self.pos
      while true # sequence
        _tmp = apply(:_Do)
        unless _tmp
          self.pos = _save7
          break
        end
        _tmp = apply(:_block)
        block = @result
        unless _tmp
          self.pos = _save7
          break
        end
        _tmp = apply(:_End)
        unless _tmp
          self.pos = _save7
          break
        end
        @result = begin;  Luaby::AST::Block.new block ; end
        _tmp = true
        unless _tmp
          self.pos = _save7
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save8 = self.pos
      while true # sequence
        _tmp = apply(:_While)
        unless _tmp
          self.pos = _save8
          break
        end
        _tmp = apply(:_exp)
        exp = @result
        unless _tmp
          self.pos = _save8
          break
        end
        _tmp = apply(:_Do)
        unless _tmp
          self.pos = _save8
          break
        end
        _tmp = apply(:_block)
        block = @result
        unless _tmp
          self.pos = _save8
          break
        end
        _tmp = apply(:_End)
        unless _tmp
          self.pos = _save8
          break
        end
        @result = begin;  Luaby::AST::While.new exp, block ; end
        _tmp = true
        unless _tmp
          self.pos = _save8
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save9 = self.pos
      while true # sequence
        _tmp = apply(:_Repeat)
        unless _tmp
          self.pos = _save9
          break
        end
        _tmp = apply(:_block)
        block = @result
        unless _tmp
          self.pos = _save9
          break
        end
        _tmp = apply(:_Until)
        unless _tmp
          self.pos = _save9
          break
        end
        _tmp = apply(:_exp)
        exp = @result
        unless _tmp
          self.pos = _save9
          break
        end
        @result = begin;  Luaby::AST::Repeat.new block, exp ; end
        _tmp = true
        unless _tmp
          self.pos = _save9
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save10 = self.pos
      while true # sequence
        _tmp = apply(:_If)
        unless _tmp
          self.pos = _save10
          break
        end
        _tmp = apply(:_exp)
        exp = @result
        unless _tmp
          self.pos = _save10
          break
        end
        _tmp = apply(:_Then)
        unless _tmp
          self.pos = _save10
          break
        end
        _tmp = apply(:_block)
        block = @result
        unless _tmp
          self.pos = _save10
          break
        end
        _tmp = apply(:_End)
        unless _tmp
          self.pos = _save10
          break
        end
        @result = begin;  Luaby::AST::If.new exp, block ; end
        _tmp = true
        unless _tmp
          self.pos = _save10
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save11 = self.pos
      while true # sequence
        _tmp = apply(:_For)
        unless _tmp
          self.pos = _save11
          break
        end
        _tmp = apply(:_var)
        var = @result
        unless _tmp
          self.pos = _save11
          break
        end
        _tmp = apply(:_Equals)
        unless _tmp
          self.pos = _save11
          break
        end
        _tmp = apply(:_exp)
        from = @result
        unless _tmp
          self.pos = _save11
          break
        end
        _tmp = apply(:_Comma)
        unless _tmp
          self.pos = _save11
          break
        end
        _tmp = apply(:_exp)
        to = @result
        unless _tmp
          self.pos = _save11
          break
        end
        _tmp = apply(:_Do)
        unless _tmp
          self.pos = _save11
          break
        end
        _tmp = apply(:_block)
        block = @result
        unless _tmp
          self.pos = _save11
          break
        end
        _tmp = apply(:_End)
        unless _tmp
          self.pos = _save11
          break
        end
        @result = begin;  Luaby::AST::ForFromTo.new var, from, to, block ; end
        _tmp = true
        unless _tmp
          self.pos = _save11
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save12 = self.pos
      while true # sequence
        _tmp = apply(:_For)
        unless _tmp
          self.pos = _save12
          break
        end
        _tmp = apply(:_var)
        var = @result
        unless _tmp
          self.pos = _save12
          break
        end
        _tmp = apply(:_Equals)
        unless _tmp
          self.pos = _save12
          break
        end
        _tmp = apply(:_exp)
        from = @result
        unless _tmp
          self.pos = _save12
          break
        end
        _tmp = apply(:_Comma)
        unless _tmp
          self.pos = _save12
          break
        end
        _tmp = apply(:_exp)
        to = @result
        unless _tmp
          self.pos = _save12
          break
        end
        _tmp = apply(:_Comma)
        unless _tmp
          self.pos = _save12
          break
        end
        _tmp = apply(:_exp)
        step = @result
        unless _tmp
          self.pos = _save12
          break
        end
        _tmp = apply(:_Do)
        unless _tmp
          self.pos = _save12
          break
        end
        _tmp = apply(:_block)
        block = @result
        unless _tmp
          self.pos = _save12
          break
        end
        _tmp = apply(:_End)
        unless _tmp
          self.pos = _save12
          break
        end
        @result = begin;  Luaby::AST::ForFromToStep.new var, from, to, step, block ; end
        _tmp = true
        unless _tmp
          self.pos = _save12
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save13 = self.pos
      while true # sequence
        _tmp = apply(:_For)
        unless _tmp
          self.pos = _save13
          break
        end
        _tmp = apply(:_namelist)
        namelist = @result
        unless _tmp
          self.pos = _save13
          break
        end
        _tmp = apply(:_In)
        unless _tmp
          self.pos = _save13
          break
        end
        _tmp = apply(:_explist)
        explist = @result
        unless _tmp
          self.pos = _save13
          break
        end
        _tmp = apply(:_Do)
        unless _tmp
          self.pos = _save13
          break
        end
        _tmp = apply(:_block)
        block = @result
        unless _tmp
          self.pos = _save13
          break
        end
        _tmp = apply(:_End)
        unless _tmp
          self.pos = _save13
          break
        end
        @result = begin;  Luaby::AST::ForIn.new namelist, explist, block ; end
        _tmp = true
        unless _tmp
          self.pos = _save13
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save14 = self.pos
      while true # sequence
        _tmp = apply(:_Local)
        unless _tmp
          self.pos = _save14
          break
        end
        _tmp = apply(:_Function)
        unless _tmp
          self.pos = _save14
          break
        end
        _tmp = apply(:_Name)
        name = @result
        unless _tmp
          self.pos = _save14
          break
        end
        _tmp = apply(:_funcbody)
        body = @result
        unless _tmp
          self.pos = _save14
          break
        end
        @result = begin;  Luaby::AST::LocalFunction.new name, body ; end
        _tmp = true
        unless _tmp
          self.pos = _save14
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save15 = self.pos
      while true # sequence
        _tmp = apply(:_Function)
        unless _tmp
          self.pos = _save15
          break
        end
        _tmp = apply(:_funcname)
        name = @result
        unless _tmp
          self.pos = _save15
          break
        end
        _tmp = apply(:_funcbody)
        body = @result
        unless _tmp
          self.pos = _save15
          break
        end
        @result = begin;  Luaby::AST::Function.new name, body ; end
        _tmp = true
        unless _tmp
          self.pos = _save15
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save16 = self.pos
      while true # sequence
        _tmp = apply(:_Local)
        unless _tmp
          self.pos = _save16
          break
        end
        _tmp = apply(:_namelist)
        names = @result
        unless _tmp
          self.pos = _save16
          break
        end
        _tmp = apply(:_Equals)
        unless _tmp
          self.pos = _save16
          break
        end
        _tmp = apply(:_explist)
        exps = @result
        unless _tmp
          self.pos = _save16
          break
        end
        @result = begin;  Luaby::AST::LocalAssignment.new names, exps ; end
        _tmp = true
        unless _tmp
          self.pos = _save16
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save

      _save17 = self.pos
      while true # sequence
        _tmp = apply(:_Local)
        unless _tmp
          self.pos = _save17
          break
        end
        _tmp = apply(:_namelist)
        namelist = @result
        unless _tmp
          self.pos = _save17
          break
        end
        @result = begin;  Luaby::AST::LocalDeclaration.new namelist ; end
        _tmp = true
        unless _tmp
          self.pos = _save17
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_stat unless _tmp
    return _tmp
  end

  # funcname = Name
  def _funcname
    _tmp = apply(:_Name)
    set_failed_rule :_funcname unless _tmp
    return _tmp
  end

  # root = (- | - < string_literal:str > /\Z/ { str })
  def _root

    _save = self.pos
    while true # choice
      _tmp = apply(:__hyphen_)
      break if _tmp
      self.pos = _save

      _save1 = self.pos
      while true # sequence
        _tmp = apply(:__hyphen_)
        unless _tmp
          self.pos = _save1
          break
        end
        _text_start = self.pos
        _tmp = apply(:_string_literal)
        str = @result
        if _tmp
          text = get_text(_text_start)
        end
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = scan(/\A(?-mix:\Z)/)
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin;  str ; end
        _tmp = true
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_root unless _tmp
    return _tmp
  end

  Rules = {}
  Rules[:__hyphen_] = rule_info("-", "(Whitespace | Comment)")
  Rules[:_Whitespace] = rule_info("Whitespace", "/\\s*/ -")
  Rules[:_Comment] = rule_info("Comment", "(\"--\" /[^\\n]/ - | \"--[[\" /.*?\\]\\]--/ -)")
  Rules[:_StringCharacter] = rule_info("StringCharacter", "(\"\\\\a\" { \"\\a\" } | \"\\\\b\" { \"\\b\" } | \"\\\\f\" { \"\\f\" } | \"\\\\n\" { \"\\n\" } | \"\\\\r\" { \"\\r\" } | \"\\\\t\" { \"\\t\" } | \"\\\\v\" { \"\\v\" } | \"\\\\x\" < /[A-Fa-f0-9]{2}/ > { text.to_i(16).chr } | \"\\\\\\\\\" { \"\\\\\" } | \"\\\\\\n\" { \"\\n\" } | \"\\\\\" { \"\\n\" } | \"\\\\z\" \" \"* { nil } | \"\\\\\" < /[0-9]{1,3}/ > { text.to_i(10).chr } | < /[^'\"\\\\]/ > { text })")
  Rules[:_DoubleQuotedStringCharacter] = rule_info("DoubleQuotedStringCharacter", "(< StringCharacter > { text } | \"'\" { text })")
  Rules[:_SingleQuotedStringCharacter] = rule_info("SingleQuotedStringCharacter", "(< StringCharacter > { text } | \"\\\"\" { text })")
  Rules[:_String] = rule_info("String", "(\"\\\"\" < DoubleQuotedStringCharacter*:str > \"\\\"\" - { str } | \"'\" < SingleQuotedStringCharacter*:str > \"'\" - { str })")
  Rules[:_Do] = rule_info("Do", "\"do\" -")
  Rules[:_End] = rule_info("End", "\"end\" -")
  Rules[:_While] = rule_info("While", "\"while\" -")
  Rules[:_Repeat] = rule_info("Repeat", "\"repeat\" -")
  Rules[:_Until] = rule_info("Until", "\"until\" -")
  Rules[:_If] = rule_info("If", "\"if\" -")
  Rules[:_Then] = rule_info("Then", "\"then\" -")
  Rules[:_Else] = rule_info("Else", "\"else\" -")
  Rules[:_Elsif] = rule_info("Elsif", "\"elsif\" -")
  Rules[:_Equals] = rule_info("Equals", "\"=\" -")
  Rules[:_Function] = rule_info("Function", "\"function\" -")
  Rules[:_Break] = rule_info("Break", "\"break\" -")
  Rules[:_Return] = rule_info("Return", "\"return\" -")
  Rules[:_Goto] = rule_info("Goto", "\"goto\" -")
  Rules[:_Comma] = rule_info("Comma", "\",\" -")
  Rules[:_Semicolon] = rule_info("Semicolon", "\";\" -")
  Rules[:_DoubleColon] = rule_info("DoubleColon", "\"::\" -")
  Rules[:_Name] = rule_info("Name", "/[a-zA-Z_][a-zA-Z_0-9]*/ -")
  Rules[:_string_literal] = rule_info("string_literal", "< String:str > { Luaby::AST::StringLiteral.new str.compact.join }")
  Rules[:_var] = rule_info("var", "< Name > { Luaby::AST::Variable.new text }")
  Rules[:_stat_semi] = rule_info("stat_semi", "< stat > \";\"? { text }")
  Rules[:_chunk] = rule_info("chunk", "stat_semi*:stats laststat:laststat? { Luaby::AST::Block.new(laststat ? [*stats, laststat] : stats) }")
  Rules[:_block] = rule_info("block", "chunk")
  Rules[:_retstat] = rule_info("retstat", "Return explist:explist Semicolon? { Luaby::AST::Return.new explist }")
  Rules[:_stat] = rule_info("stat", "(Semicolon { nil } | varlist:lvals Equals explist:rvals { Luaby::AST::Assignment.new lvals, rvals } | functioncall { @TODO } | DoubleColon Name:name DoubleColon { Luaby::AST::Label.new name } | Break { Luaby::AST::Break.new } | Goto Name:name { Luaby::AST::Goto.new name } | Do block:block End { Luaby::AST::Block.new block } | While exp:exp Do block:block End { Luaby::AST::While.new exp, block } | Repeat block:block Until exp:exp { Luaby::AST::Repeat.new block, exp } | If exp:exp Then block:block End { Luaby::AST::If.new exp, block } | For var:var Equals exp:from Comma exp:to Do block:block End { Luaby::AST::ForFromTo.new var, from, to, block } | For var:var Equals exp:from Comma exp:to Comma exp:step Do block:block End { Luaby::AST::ForFromToStep.new var, from, to, step, block } | For namelist:namelist In explist:explist Do block:block End { Luaby::AST::ForIn.new namelist, explist, block } | Local Function Name:name funcbody:body { Luaby::AST::LocalFunction.new name, body } | Function funcname:name funcbody:body { Luaby::AST::Function.new name, body } | Local namelist:names Equals explist:exps { Luaby::AST::LocalAssignment.new names, exps } | Local namelist:namelist { Luaby::AST::LocalDeclaration.new namelist })")
  Rules[:_funcname] = rule_info("funcname", "Name")
  Rules[:_root] = rule_info("root", "(- | - < string_literal:str > /\\Z/ { str })")
  # :startdoc:
end
