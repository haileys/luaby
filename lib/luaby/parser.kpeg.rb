require 'kpeg/compiled_parser'

class Luaby::Parser < KPeg::CompiledParser
  # :stopdoc:

  # - = (Whitespace* | Comment*)
  def __hyphen_

    _save = self.pos
    while true # choice
      while true
        _tmp = apply(:_Whitespace)
        break unless _tmp
      end
      _tmp = true
      break if _tmp
      self.pos = _save
      while true
        _tmp = apply(:_Comment)
        break unless _tmp
      end
      _tmp = true
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :__hyphen_ unless _tmp
    return _tmp
  end

  # Whitespace = /[\t\v\f\n ]/ { nil }
  def _Whitespace

    _save = self.pos
    while true # sequence
      _tmp = scan(/\A(?-mix:[\t\v\f\n ])/)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  nil ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Whitespace unless _tmp
    return _tmp
  end

  # Comment = ("--" /[^\n]/ | "--[[" /.*?\]\]--/)
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

  # Shebang = "#!" /.*?$/
  def _Shebang

    _save = self.pos
    while true # sequence
      _tmp = match_string("#!")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = scan(/\A(?-mix:.*?$)/)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Shebang unless _tmp
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

  # Number = < /(0x[0-9a-f]+|[0-9]+(.[0-9]*)?(e[0-9]*)?)/i > { text.to_f }
  def _Number

    _save = self.pos
    while true # sequence
      _text_start = self.pos
      _tmp = scan(/\A(?i-mx:(0x[0-9a-f]+|[0-9]+(.[0-9]*)?(e[0-9]*)?))/)
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  text.to_f ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Number unless _tmp
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

  # For = "for" -
  def _For

    _save = self.pos
    while true # sequence
      _tmp = match_string("for")
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

    set_failed_rule :_For unless _tmp
    return _tmp
  end

  # In = "in" -
  def _In

    _save = self.pos
    while true # sequence
      _tmp = match_string("in")
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

    set_failed_rule :_In unless _tmp
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

  # Local = "local" -
  def _Local

    _save = self.pos
    while true # sequence
      _tmp = match_string("local")
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

    set_failed_rule :_Local unless _tmp
    return _tmp
  end

  # Nil = "nil" -
  def _Nil

    _save = self.pos
    while true # sequence
      _tmp = match_string("nil")
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

    set_failed_rule :_Nil unless _tmp
    return _tmp
  end

  # True = "true" -
  def _True

    _save = self.pos
    while true # sequence
      _tmp = match_string("true")
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

    set_failed_rule :_True unless _tmp
    return _tmp
  end

  # False = "false" -
  def _False

    _save = self.pos
    while true # sequence
      _tmp = match_string("false")
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

    set_failed_rule :_False unless _tmp
    return _tmp
  end

  # Or = "or" -
  def _Or

    _save = self.pos
    while true # sequence
      _tmp = match_string("or")
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

    set_failed_rule :_Or unless _tmp
    return _tmp
  end

  # And = "and" -
  def _And

    _save = self.pos
    while true # sequence
      _tmp = match_string("and")
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

    set_failed_rule :_And unless _tmp
    return _tmp
  end

  # Not = "not" -
  def _Not

    _save = self.pos
    while true # sequence
      _tmp = match_string("not")
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

    set_failed_rule :_Not unless _tmp
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

  # Count = "#" -
  def _Count

    _save = self.pos
    while true # sequence
      _tmp = match_string("#")
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

    set_failed_rule :_Count unless _tmp
    return _tmp
  end

  # Plus = "+" -
  def _Plus

    _save = self.pos
    while true # sequence
      _tmp = match_string("+")
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

    set_failed_rule :_Plus unless _tmp
    return _tmp
  end

  # Minus = "-" -
  def _Minus

    _save = self.pos
    while true # sequence
      _tmp = match_string("-")
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

    set_failed_rule :_Minus unless _tmp
    return _tmp
  end

  # Times = "*" -
  def _Times

    _save = self.pos
    while true # sequence
      _tmp = match_string("*")
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

    set_failed_rule :_Times unless _tmp
    return _tmp
  end

  # Divide = "/" -
  def _Divide

    _save = self.pos
    while true # sequence
      _tmp = match_string("/")
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

    set_failed_rule :_Divide unless _tmp
    return _tmp
  end

  # Modulo = "%" -
  def _Modulo

    _save = self.pos
    while true # sequence
      _tmp = match_string("%")
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

    set_failed_rule :_Modulo unless _tmp
    return _tmp
  end

  # Power = "^" -
  def _Power

    _save = self.pos
    while true # sequence
      _tmp = match_string("^")
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

    set_failed_rule :_Power unless _tmp
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

  # Colon = ":" -
  def _Colon

    _save = self.pos
    while true # sequence
      _tmp = match_string(":")
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

    set_failed_rule :_Colon unless _tmp
    return _tmp
  end

  # TripleDot = "..." -
  def _TripleDot

    _save = self.pos
    while true # sequence
      _tmp = match_string("...")
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

    set_failed_rule :_TripleDot unless _tmp
    return _tmp
  end

  # DoubleDot = ".." -
  def _DoubleDot

    _save = self.pos
    while true # sequence
      _tmp = match_string("..")
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

    set_failed_rule :_DoubleDot unless _tmp
    return _tmp
  end

  # Dot = "." -
  def _Dot

    _save = self.pos
    while true # sequence
      _tmp = match_string(".")
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

    set_failed_rule :_Dot unless _tmp
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

  # LeftParen = "(" -
  def _LeftParen

    _save = self.pos
    while true # sequence
      _tmp = match_string("(")
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

    set_failed_rule :_LeftParen unless _tmp
    return _tmp
  end

  # RightParen = ")" -
  def _RightParen

    _save = self.pos
    while true # sequence
      _tmp = match_string(")")
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

    set_failed_rule :_RightParen unless _tmp
    return _tmp
  end

  # LeftBrace = "{" -
  def _LeftBrace

    _save = self.pos
    while true # sequence
      _tmp = match_string("{")
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

    set_failed_rule :_LeftBrace unless _tmp
    return _tmp
  end

  # RightBrace = "}" -
  def _RightBrace

    _save = self.pos
    while true # sequence
      _tmp = match_string("}")
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

    set_failed_rule :_RightBrace unless _tmp
    return _tmp
  end

  # LeftBracket = "[" -
  def _LeftBracket

    _save = self.pos
    while true # sequence
      _tmp = match_string("[")
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

    set_failed_rule :_LeftBracket unless _tmp
    return _tmp
  end

  # RightBracket = "]" -
  def _RightBracket

    _save = self.pos
    while true # sequence
      _tmp = match_string("]")
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

    set_failed_rule :_RightBracket unless _tmp
    return _tmp
  end

  # LessThanEqual = "<=" -
  def _LessThanEqual

    _save = self.pos
    while true # sequence
      _tmp = match_string("<=")
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

    set_failed_rule :_LessThanEqual unless _tmp
    return _tmp
  end

  # LessThan = "<" -
  def _LessThan

    _save = self.pos
    while true # sequence
      _tmp = match_string("<")
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

    set_failed_rule :_LessThan unless _tmp
    return _tmp
  end

  # GreaterThanEqual = ">=" -
  def _GreaterThanEqual

    _save = self.pos
    while true # sequence
      _tmp = match_string(">=")
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

    set_failed_rule :_GreaterThanEqual unless _tmp
    return _tmp
  end

  # GreaterThan = ">" -
  def _GreaterThan

    _save = self.pos
    while true # sequence
      _tmp = match_string(">")
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

    set_failed_rule :_GreaterThan unless _tmp
    return _tmp
  end

  # NotEqual = "~=" -
  def _NotEqual

    _save = self.pos
    while true # sequence
      _tmp = match_string("~=")
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

    set_failed_rule :_NotEqual unless _tmp
    return _tmp
  end

  # DoubleEqual = "==" -
  def _DoubleEqual

    _save = self.pos
    while true # sequence
      _tmp = match_string("==")
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

    set_failed_rule :_DoubleEqual unless _tmp
    return _tmp
  end

  # Keyword = /do|end|while|repeat|until|if|then|else|elsif|for|in|function|break|return|goto|local|nil|true|false|or|and|not/
  def _Keyword
    _tmp = scan(/\A(?-mix:do|end|while|repeat|until|if|then|else|elsif|for|in|function|break|return|goto|local|nil|true|false|or|and|not)/)
    set_failed_rule :_Keyword unless _tmp
    return _tmp
  end

  # Identifier = < /[a-zA-Z_][a-zA-Z_0-9]*/ > - { text }
  def _Identifier

    _save = self.pos
    while true # sequence
      _text_start = self.pos
      _tmp = scan(/\A(?-mix:[a-zA-Z_][a-zA-Z_0-9]*)/)
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:__hyphen_)
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

    set_failed_rule :_Identifier unless _tmp
    return _tmp
  end

  # Name = !Keyword Identifier:id { id }
  def _Name

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = apply(:_Keyword)
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Identifier)
      id = @result
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  id ; end
      _tmp = true
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

  # chunk = block:block { block }
  def _chunk

    _save = self.pos
    while true # sequence
      _tmp = apply(:_block)
      block = @result
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  block ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_chunk unless _tmp
    return _tmp
  end

  # block = (stat*:stats retstat:retstat { Luaby::AST::Block.new([*stats, retstat]) } | stat*:stats { Luaby::AST::Block.new(stats) })
  def _block

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _ary = []
        while true
          _tmp = apply(:_stat)
          _ary << @result if _tmp
          break unless _tmp
        end
        _tmp = true
        @result = _ary
        stats = @result
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_retstat)
        retstat = @result
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin;  Luaby::AST::Block.new([*stats, retstat]) ; end
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
        _ary = []
        while true
          _tmp = apply(:_stat)
          _ary << @result if _tmp
          break unless _tmp
        end
        _tmp = true
        @result = _ary
        stats = @result
        unless _tmp
          self.pos = _save3
          break
        end
        @result = begin;  Luaby::AST::Block.new(stats) ; end
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

  # funcname = Name:first (Comma < Name >)*:rest { [first, *rest] }
  def _funcname

    _save = self.pos
    while true # sequence
      _tmp = apply(:_Name)
      first = @result
      unless _tmp
        self.pos = _save
        break
      end
      _ary = []
      while true

        _save2 = self.pos
        while true # sequence
          _tmp = apply(:_Comma)
          unless _tmp
            self.pos = _save2
            break
          end
          _text_start = self.pos
          _tmp = apply(:_Name)
          if _tmp
            text = get_text(_text_start)
          end
          unless _tmp
            self.pos = _save2
          end
          break
        end # end sequence

        _ary << @result if _tmp
        break unless _tmp
      end
      _tmp = true
      @result = _ary
      rest = @result
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  [first, *rest] ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_funcname unless _tmp
    return _tmp
  end

  # varlist = var:first (Comma < var >)*:rest { [first, *rest] }
  def _varlist

    _save = self.pos
    while true # sequence
      _tmp = apply(:_var)
      first = @result
      unless _tmp
        self.pos = _save
        break
      end
      _ary = []
      while true

        _save2 = self.pos
        while true # sequence
          _tmp = apply(:_Comma)
          unless _tmp
            self.pos = _save2
            break
          end
          _text_start = self.pos
          _tmp = apply(:_var)
          if _tmp
            text = get_text(_text_start)
          end
          unless _tmp
            self.pos = _save2
          end
          break
        end # end sequence

        _ary << @result if _tmp
        break unless _tmp
      end
      _tmp = true
      @result = _ary
      rest = @result
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  [first, *rest] ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_varlist unless _tmp
    return _tmp
  end

  # var = (prefixexp:table LeftBracket exp:index RightBracket { Luaby::AST::TableLookup.new table, index } | prefixexp:table Dot Name:name { Luaby::AST::TableLookup.new table, Luaby::AST::String.new(index) } | Name:name { Luaby::AST::Variable.new name })
  def _var

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _tmp = apply(:_prefixexp)
        table = @result
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_LeftBracket)
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_exp)
        index = @result
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_RightBracket)
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin;  Luaby::AST::TableLookup.new table, index ; end
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
        _tmp = apply(:_prefixexp)
        table = @result
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_Dot)
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_Name)
        name = @result
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin;  Luaby::AST::TableLookup.new table, Luaby::AST::String.new(index) ; end
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
        _tmp = apply(:_Name)
        name = @result
        unless _tmp
          self.pos = _save3
          break
        end
        @result = begin;  Luaby::AST::Variable.new name ; end
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

    set_failed_rule :_var unless _tmp
    return _tmp
  end

  # namelist = Name:first (Comma < Name >)*:rest { [first, *rest] }
  def _namelist

    _save = self.pos
    while true # sequence
      _tmp = apply(:_Name)
      first = @result
      unless _tmp
        self.pos = _save
        break
      end
      _ary = []
      while true

        _save2 = self.pos
        while true # sequence
          _tmp = apply(:_Comma)
          unless _tmp
            self.pos = _save2
            break
          end
          _text_start = self.pos
          _tmp = apply(:_Name)
          if _tmp
            text = get_text(_text_start)
          end
          unless _tmp
            self.pos = _save2
          end
          break
        end # end sequence

        _ary << @result if _tmp
        break unless _tmp
      end
      _tmp = true
      @result = _ary
      rest = @result
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  [first, *rest] ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_namelist unless _tmp
    return _tmp
  end

  # explist = exp:first (Comma < exp >)*:rest { [first, *rest] }
  def _explist

    _save = self.pos
    while true # sequence
      _tmp = apply(:_exp)
      first = @result
      unless _tmp
        self.pos = _save
        break
      end
      _ary = []
      while true

        _save2 = self.pos
        while true # sequence
          _tmp = apply(:_Comma)
          unless _tmp
            self.pos = _save2
            break
          end
          _text_start = self.pos
          _tmp = apply(:_exp)
          if _tmp
            text = get_text(_text_start)
          end
          unless _tmp
            self.pos = _save2
          end
          break
        end # end sequence

        _ary << @result if _tmp
        break unless _tmp
      end
      _tmp = true
      @result = _ary
      rest = @result
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  [first, *rest] ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_explist unless _tmp
    return _tmp
  end

  # exp = or_exp:exp { exp }
  def _exp

    _save = self.pos
    while true # sequence
      _tmp = apply(:_or_exp)
      exp = @result
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  exp ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_exp unless _tmp
    return _tmp
  end

  # or_exp = (or_exp:l Or and_exp:r { Luaby::AST::Or.new l, r } | and_exp:exp { exp })
  def _or_exp

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _tmp = apply(:_or_exp)
        l = @result
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_Or)
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_and_exp)
        r = @result
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin;  Luaby::AST::Or.new l, r ; end
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
        _tmp = apply(:_and_exp)
        exp = @result
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin;  exp ; end
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

    set_failed_rule :_or_exp unless _tmp
    return _tmp
  end

  # and_exp = (and_exp:l Or rel_exp:r { Luaby::AST::And.new l, r} | rel_exp:exp { exp })
  def _and_exp

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _tmp = apply(:_and_exp)
        l = @result
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_Or)
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_rel_exp)
        r = @result
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin;  Luaby::AST::And.new l, r; end
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
        _tmp = apply(:_rel_exp)
        exp = @result
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin;  exp ; end
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

    set_failed_rule :_and_exp unless _tmp
    return _tmp
  end

  # rel_exp = (rel_exp:l LessThanEqual concat_exp:r { Luaby::AST::LessThanEqual.new l, r } | rel_exp:l LessThan concat_exp:r { Luaby::AST::LessThan.new l, r } | rel_exp:l GreaterThanEqual concat_exp:r { Luaby::AST::GreaterThanEqual.new l, r } | rel_exp:l GreaterThan concat_exp:r { Luaby::AST::GreaterThan.new l, r } | rel_exp:l NotEqual concat_exp:r { Luaby::AST::NotEqual.new l, r } | rel_exp:l DoubleEqual concat_exp:r { Luaby::AST::Equal.new l, r } | concat_exp:exp { exp })
  def _rel_exp

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _tmp = apply(:_rel_exp)
        l = @result
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_LessThanEqual)
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_concat_exp)
        r = @result
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin;  Luaby::AST::LessThanEqual.new l, r ; end
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
        _tmp = apply(:_rel_exp)
        l = @result
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_LessThan)
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_concat_exp)
        r = @result
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin;  Luaby::AST::LessThan.new l, r ; end
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
        _tmp = apply(:_rel_exp)
        l = @result
        unless _tmp
          self.pos = _save3
          break
        end
        _tmp = apply(:_GreaterThanEqual)
        unless _tmp
          self.pos = _save3
          break
        end
        _tmp = apply(:_concat_exp)
        r = @result
        unless _tmp
          self.pos = _save3
          break
        end
        @result = begin;  Luaby::AST::GreaterThanEqual.new l, r ; end
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
        _tmp = apply(:_rel_exp)
        l = @result
        unless _tmp
          self.pos = _save4
          break
        end
        _tmp = apply(:_GreaterThan)
        unless _tmp
          self.pos = _save4
          break
        end
        _tmp = apply(:_concat_exp)
        r = @result
        unless _tmp
          self.pos = _save4
          break
        end
        @result = begin;  Luaby::AST::GreaterThan.new l, r ; end
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
        _tmp = apply(:_rel_exp)
        l = @result
        unless _tmp
          self.pos = _save5
          break
        end
        _tmp = apply(:_NotEqual)
        unless _tmp
          self.pos = _save5
          break
        end
        _tmp = apply(:_concat_exp)
        r = @result
        unless _tmp
          self.pos = _save5
          break
        end
        @result = begin;  Luaby::AST::NotEqual.new l, r ; end
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
        _tmp = apply(:_rel_exp)
        l = @result
        unless _tmp
          self.pos = _save6
          break
        end
        _tmp = apply(:_DoubleEqual)
        unless _tmp
          self.pos = _save6
          break
        end
        _tmp = apply(:_concat_exp)
        r = @result
        unless _tmp
          self.pos = _save6
          break
        end
        @result = begin;  Luaby::AST::Equal.new l, r ; end
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
        _tmp = apply(:_concat_exp)
        exp = @result
        unless _tmp
          self.pos = _save7
          break
        end
        @result = begin;  exp ; end
        _tmp = true
        unless _tmp
          self.pos = _save7
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_rel_exp unless _tmp
    return _tmp
  end

  # concat_exp = (add_exp:l DoubleDot concat_exp:r { Luaby::AST::Concat.new l, r } | add_exp:exp { exp })
  def _concat_exp

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _tmp = apply(:_add_exp)
        l = @result
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_DoubleDot)
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_concat_exp)
        r = @result
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin;  Luaby::AST::Concat.new l, r ; end
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
        _tmp = apply(:_add_exp)
        exp = @result
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin;  exp ; end
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

    set_failed_rule :_concat_exp unless _tmp
    return _tmp
  end

  # add_exp = (add_exp:l Plus mul_exp:r { Luaby::AST::Add.new l, r } | add_exp:l Minus mul_exp:r { Luaby::AST::Subtract.new l, r } | mul_exp:exp { exp })
  def _add_exp

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _tmp = apply(:_add_exp)
        l = @result
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_Plus)
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_mul_exp)
        r = @result
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin;  Luaby::AST::Add.new l, r ; end
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
        _tmp = apply(:_add_exp)
        l = @result
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_Minus)
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_mul_exp)
        r = @result
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin;  Luaby::AST::Subtract.new l, r ; end
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
        _tmp = apply(:_mul_exp)
        exp = @result
        unless _tmp
          self.pos = _save3
          break
        end
        @result = begin;  exp ; end
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

    set_failed_rule :_add_exp unless _tmp
    return _tmp
  end

  # mul_exp = (mul_exp:l Times unary_exp:r { Luaby::AST::Multiply.new l, r } | mul_exp:l Divide unary_exp:r { Luaby::AST::Divide.new l, r } | mul_exp:l Modulo unary_exp:r { Luaby::AST::Modulo.new l, r } | unary_exp:exp { exp })
  def _mul_exp

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _tmp = apply(:_mul_exp)
        l = @result
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_Times)
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_unary_exp)
        r = @result
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin;  Luaby::AST::Multiply.new l, r ; end
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
        _tmp = apply(:_mul_exp)
        l = @result
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_Divide)
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_unary_exp)
        r = @result
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin;  Luaby::AST::Divide.new l, r ; end
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
        _tmp = apply(:_mul_exp)
        l = @result
        unless _tmp
          self.pos = _save3
          break
        end
        _tmp = apply(:_Modulo)
        unless _tmp
          self.pos = _save3
          break
        end
        _tmp = apply(:_unary_exp)
        r = @result
        unless _tmp
          self.pos = _save3
          break
        end
        @result = begin;  Luaby::AST::Modulo.new l, r ; end
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
        _tmp = apply(:_unary_exp)
        exp = @result
        unless _tmp
          self.pos = _save4
          break
        end
        @result = begin;  exp ; end
        _tmp = true
        unless _tmp
          self.pos = _save4
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_mul_exp unless _tmp
    return _tmp
  end

  # unary_exp = (Not pow_exp:operand { Luaby::AST::Not.new operand } | Count pow_exp:operand { Luaby::AST::Count.new operand } | Minus pow_exp:operand { Luaby::AST::Negate.new operand } | pow_exp:exp { exp })
  def _unary_exp

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _tmp = apply(:_Not)
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_pow_exp)
        operand = @result
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin;  Luaby::AST::Not.new operand ; end
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
        _tmp = apply(:_Count)
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_pow_exp)
        operand = @result
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin;  Luaby::AST::Count.new operand ; end
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
        _tmp = apply(:_Minus)
        unless _tmp
          self.pos = _save3
          break
        end
        _tmp = apply(:_pow_exp)
        operand = @result
        unless _tmp
          self.pos = _save3
          break
        end
        @result = begin;  Luaby::AST::Negate.new operand ; end
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
        _tmp = apply(:_pow_exp)
        exp = @result
        unless _tmp
          self.pos = _save4
          break
        end
        @result = begin;  exp ; end
        _tmp = true
        unless _tmp
          self.pos = _save4
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_unary_exp unless _tmp
    return _tmp
  end

  # pow_exp = (pri_exp:l Power pow_exp:r { Luaby::AST::Power.new l, r } | pri_exp:exp { exp })
  def _pow_exp

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _tmp = apply(:_pri_exp)
        l = @result
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_Power)
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_pow_exp)
        r = @result
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin;  Luaby::AST::Power.new l, r ; end
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
        _tmp = apply(:_pri_exp)
        exp = @result
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin;  exp ; end
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

    set_failed_rule :_pow_exp unless _tmp
    return _tmp
  end

  # pri_exp = (Nil { Luaby::AST::Nil.new } | False { Luaby::AST::False.new } | True { Luaby::AST::True.new } | Number:n { Luaby::AST::Number.new n } | string_literal:str { str } | TripleDot { Luaby::AST::Nil.new } | functiondef | prefixexp | tableconstructor)
  def _pri_exp

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _tmp = apply(:_Nil)
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin;  Luaby::AST::Nil.new ; end
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
        _tmp = apply(:_False)
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin;  Luaby::AST::False.new ; end
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
        _tmp = apply(:_True)
        unless _tmp
          self.pos = _save3
          break
        end
        @result = begin;  Luaby::AST::True.new ; end
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
        _tmp = apply(:_Number)
        n = @result
        unless _tmp
          self.pos = _save4
          break
        end
        @result = begin;  Luaby::AST::Number.new n ; end
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
        _tmp = apply(:_string_literal)
        str = @result
        unless _tmp
          self.pos = _save5
          break
        end
        @result = begin;  str ; end
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
        _tmp = apply(:_TripleDot)
        unless _tmp
          self.pos = _save6
          break
        end
        @result = begin;  Luaby::AST::Nil.new ; end
        _tmp = true
        unless _tmp
          self.pos = _save6
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      _tmp = apply(:_functiondef)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_prefixexp)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_tableconstructor)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_pri_exp unless _tmp
    return _tmp
  end

  # prefixexp = (var:var { var } | LeftParen exp:exp RightParen { exp } | functioncall:fcall { fcall })
  def _prefixexp

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _tmp = apply(:_var)
        var = @result
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin;  var ; end
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
        _tmp = apply(:_LeftParen)
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_exp)
        exp = @result
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_RightParen)
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin;  exp ; end
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
        fcall = @result
        unless _tmp
          self.pos = _save3
          break
        end
        @result = begin;  fcall ; end
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

    set_failed_rule :_prefixexp unless _tmp
    return _tmp
  end

  # functioncall = (prefixexp:callee args:args { Luaby::AST::FunctionCall.new callee, args } | prefixexp:obj Colon Name:method args:args { Luaby::AST::MethodCall.new obj, method, args })
  def _functioncall

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _tmp = apply(:_prefixexp)
        callee = @result
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_args)
        args = @result
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin;  Luaby::AST::FunctionCall.new callee, args ; end
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
        _tmp = apply(:_prefixexp)
        obj = @result
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_Colon)
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_Name)
        method = @result
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_args)
        args = @result
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin;  Luaby::AST::MethodCall.new obj, method, args ; end
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

    set_failed_rule :_functioncall unless _tmp
    return _tmp
  end

  # args = (LeftParen explist:explist RightParen { explist } | tableconstructor:arg { [arg] } | string_literal:arg { [arg] })
  def _args

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _tmp = apply(:_LeftParen)
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_explist)
        explist = @result
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_RightParen)
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin;  explist ; end
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
        _tmp = apply(:_tableconstructor)
        arg = @result
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin;  [arg] ; end
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
        _tmp = apply(:_string_literal)
        arg = @result
        unless _tmp
          self.pos = _save3
          break
        end
        @result = begin;  [arg] ; end
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

    set_failed_rule :_args unless _tmp
    return _tmp
  end

  # functiondef = Function funcbody:func { func }
  def _functiondef

    _save = self.pos
    while true # sequence
      _tmp = apply(:_Function)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_funcbody)
      func = @result
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  func ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_functiondef unless _tmp
    return _tmp
  end

  # funcbody = LeftParen parlist:args RightParen block:b End { Luaby::AST::Function.new args, b }
  def _funcbody

    _save = self.pos
    while true # sequence
      _tmp = apply(:_LeftParen)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_parlist)
      args = @result
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_RightParen)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_block)
      b = @result
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_End)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  Luaby::AST::Function.new args, b ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_funcbody unless _tmp
    return _tmp
  end

  # parlist = (namelist:params Comma TripleDot { Luaby::AST::Parameters.new true, params } | namelist:params { Luaby::AST::Parameters.new false, params } | TripleDot { Luaby::AST::Parameters.new true, [] })
  def _parlist

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _tmp = apply(:_namelist)
        params = @result
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_Comma)
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_TripleDot)
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin;  Luaby::AST::Parameters.new true, params ; end
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
        _tmp = apply(:_namelist)
        params = @result
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin;  Luaby::AST::Parameters.new false, params ; end
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
        _tmp = apply(:_TripleDot)
        unless _tmp
          self.pos = _save3
          break
        end
        @result = begin;  Luaby::AST::Parameters.new true, [] ; end
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

    set_failed_rule :_parlist unless _tmp
    return _tmp
  end

  # tableconstructor = LeftBrace fieldlist:fl RightBrace { Luaby::AST::TableConstructor.new fl }
  def _tableconstructor

    _save = self.pos
    while true # sequence
      _tmp = apply(:_LeftBrace)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_fieldlist)
      fl = @result
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_RightBrace)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  Luaby::AST::TableConstructor.new fl ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_tableconstructor unless _tmp
    return _tmp
  end

  # fieldlist = field:first (fieldsep < field >)*:rst fieldsep? { [first, *rst] }
  def _fieldlist

    _save = self.pos
    while true # sequence
      _tmp = apply(:_field)
      first = @result
      unless _tmp
        self.pos = _save
        break
      end
      _ary = []
      while true

        _save2 = self.pos
        while true # sequence
          _tmp = apply(:_fieldsep)
          unless _tmp
            self.pos = _save2
            break
          end
          _text_start = self.pos
          _tmp = apply(:_field)
          if _tmp
            text = get_text(_text_start)
          end
          unless _tmp
            self.pos = _save2
          end
          break
        end # end sequence

        _ary << @result if _tmp
        break unless _tmp
      end
      _tmp = true
      @result = _ary
      rst = @result
      unless _tmp
        self.pos = _save
        break
      end
      _save3 = self.pos
      _tmp = apply(:_fieldsep)
      unless _tmp
        _tmp = true
        self.pos = _save3
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  [first, *rst] ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_fieldlist unless _tmp
    return _tmp
  end

  # fieldsep = (Comma | Semicolon)
  def _fieldsep

    _save = self.pos
    while true # choice
      _tmp = apply(:_Comma)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_Semicolon)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_fieldsep unless _tmp
    return _tmp
  end

  # field = (LeftBracket exp:key RightBracket Equals exp:val { [key, val] } | Name:key Equals exp:val { [Luaby::AST::StringLiteral.new(key), val] } | exp:val { [nil, exp] })
  def _field

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _tmp = apply(:_LeftBracket)
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_exp)
        key = @result
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_RightBracket)
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_Equals)
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_exp)
        val = @result
        unless _tmp
          self.pos = _save1
          break
        end
        @result = begin;  [key, val] ; end
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
        _tmp = apply(:_Name)
        key = @result
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_Equals)
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_exp)
        val = @result
        unless _tmp
          self.pos = _save2
          break
        end
        @result = begin;  [Luaby::AST::StringLiteral.new(key), val] ; end
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
        _tmp = apply(:_exp)
        val = @result
        unless _tmp
          self.pos = _save3
          break
        end
        @result = begin;  [nil, exp] ; end
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

    set_failed_rule :_field unless _tmp
    return _tmp
  end

  # root = Shebang? - chunk:chunk /\Z/ { chunk }
  def _root

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = apply(:_Shebang)
      unless _tmp
        _tmp = true
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:__hyphen_)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_chunk)
      chunk = @result
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = scan(/\A(?-mix:\Z)/)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  chunk ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_root unless _tmp
    return _tmp
  end

  Rules = {}
  Rules[:__hyphen_] = rule_info("-", "(Whitespace* | Comment*)")
  Rules[:_Whitespace] = rule_info("Whitespace", "/[\\t\\v\\f\\n ]/ { nil }")
  Rules[:_Comment] = rule_info("Comment", "(\"--\" /[^\\n]/ | \"--[[\" /.*?\\]\\]--/)")
  Rules[:_Shebang] = rule_info("Shebang", "\"\#!\" /.*?$/")
  Rules[:_StringCharacter] = rule_info("StringCharacter", "(\"\\\\a\" { \"\\a\" } | \"\\\\b\" { \"\\b\" } | \"\\\\f\" { \"\\f\" } | \"\\\\n\" { \"\\n\" } | \"\\\\r\" { \"\\r\" } | \"\\\\t\" { \"\\t\" } | \"\\\\v\" { \"\\v\" } | \"\\\\x\" < /[A-Fa-f0-9]{2}/ > { text.to_i(16).chr } | \"\\\\\\\\\" { \"\\\\\" } | \"\\\\\\n\" { \"\\n\" } | \"\\\\\" { \"\\n\" } | \"\\\\z\" \" \"* { nil } | \"\\\\\" < /[0-9]{1,3}/ > { text.to_i(10).chr } | < /[^'\"\\\\]/ > { text })")
  Rules[:_DoubleQuotedStringCharacter] = rule_info("DoubleQuotedStringCharacter", "(< StringCharacter > { text } | \"'\" { text })")
  Rules[:_SingleQuotedStringCharacter] = rule_info("SingleQuotedStringCharacter", "(< StringCharacter > { text } | \"\\\"\" { text })")
  Rules[:_String] = rule_info("String", "(\"\\\"\" < DoubleQuotedStringCharacter*:str > \"\\\"\" - { str } | \"'\" < SingleQuotedStringCharacter*:str > \"'\" - { str })")
  Rules[:_Number] = rule_info("Number", "< /(0x[0-9a-f]+|[0-9]+(.[0-9]*)?(e[0-9]*)?)/i > { text.to_f }")
  Rules[:_Do] = rule_info("Do", "\"do\" -")
  Rules[:_End] = rule_info("End", "\"end\" -")
  Rules[:_While] = rule_info("While", "\"while\" -")
  Rules[:_Repeat] = rule_info("Repeat", "\"repeat\" -")
  Rules[:_Until] = rule_info("Until", "\"until\" -")
  Rules[:_If] = rule_info("If", "\"if\" -")
  Rules[:_Then] = rule_info("Then", "\"then\" -")
  Rules[:_Else] = rule_info("Else", "\"else\" -")
  Rules[:_Elsif] = rule_info("Elsif", "\"elsif\" -")
  Rules[:_For] = rule_info("For", "\"for\" -")
  Rules[:_In] = rule_info("In", "\"in\" -")
  Rules[:_Function] = rule_info("Function", "\"function\" -")
  Rules[:_Break] = rule_info("Break", "\"break\" -")
  Rules[:_Return] = rule_info("Return", "\"return\" -")
  Rules[:_Goto] = rule_info("Goto", "\"goto\" -")
  Rules[:_Local] = rule_info("Local", "\"local\" -")
  Rules[:_Nil] = rule_info("Nil", "\"nil\" -")
  Rules[:_True] = rule_info("True", "\"true\" -")
  Rules[:_False] = rule_info("False", "\"false\" -")
  Rules[:_Or] = rule_info("Or", "\"or\" -")
  Rules[:_And] = rule_info("And", "\"and\" -")
  Rules[:_Not] = rule_info("Not", "\"not\" -")
  Rules[:_Equals] = rule_info("Equals", "\"=\" -")
  Rules[:_Count] = rule_info("Count", "\"\#\" -")
  Rules[:_Plus] = rule_info("Plus", "\"+\" -")
  Rules[:_Minus] = rule_info("Minus", "\"-\" -")
  Rules[:_Times] = rule_info("Times", "\"*\" -")
  Rules[:_Divide] = rule_info("Divide", "\"/\" -")
  Rules[:_Modulo] = rule_info("Modulo", "\"%\" -")
  Rules[:_Power] = rule_info("Power", "\"^\" -")
  Rules[:_Comma] = rule_info("Comma", "\",\" -")
  Rules[:_Semicolon] = rule_info("Semicolon", "\";\" -")
  Rules[:_Colon] = rule_info("Colon", "\":\" -")
  Rules[:_TripleDot] = rule_info("TripleDot", "\"...\" -")
  Rules[:_DoubleDot] = rule_info("DoubleDot", "\"..\" -")
  Rules[:_Dot] = rule_info("Dot", "\".\" -")
  Rules[:_DoubleColon] = rule_info("DoubleColon", "\"::\" -")
  Rules[:_LeftParen] = rule_info("LeftParen", "\"(\" -")
  Rules[:_RightParen] = rule_info("RightParen", "\")\" -")
  Rules[:_LeftBrace] = rule_info("LeftBrace", "\"{\" -")
  Rules[:_RightBrace] = rule_info("RightBrace", "\"}\" -")
  Rules[:_LeftBracket] = rule_info("LeftBracket", "\"[\" -")
  Rules[:_RightBracket] = rule_info("RightBracket", "\"]\" -")
  Rules[:_LessThanEqual] = rule_info("LessThanEqual", "\"<=\" -")
  Rules[:_LessThan] = rule_info("LessThan", "\"<\" -")
  Rules[:_GreaterThanEqual] = rule_info("GreaterThanEqual", "\">=\" -")
  Rules[:_GreaterThan] = rule_info("GreaterThan", "\">\" -")
  Rules[:_NotEqual] = rule_info("NotEqual", "\"~=\" -")
  Rules[:_DoubleEqual] = rule_info("DoubleEqual", "\"==\" -")
  Rules[:_Keyword] = rule_info("Keyword", "/do|end|while|repeat|until|if|then|else|elsif|for|in|function|break|return|goto|local|nil|true|false|or|and|not/")
  Rules[:_Identifier] = rule_info("Identifier", "< /[a-zA-Z_][a-zA-Z_0-9]*/ > - { text }")
  Rules[:_Name] = rule_info("Name", "!Keyword Identifier:id { id }")
  Rules[:_string_literal] = rule_info("string_literal", "< String:str > { Luaby::AST::StringLiteral.new str.compact.join }")
  Rules[:_chunk] = rule_info("chunk", "block:block { block }")
  Rules[:_block] = rule_info("block", "(stat*:stats retstat:retstat { Luaby::AST::Block.new([*stats, retstat]) } | stat*:stats { Luaby::AST::Block.new(stats) })")
  Rules[:_retstat] = rule_info("retstat", "Return explist:explist Semicolon? { Luaby::AST::Return.new explist }")
  Rules[:_stat] = rule_info("stat", "(Semicolon { nil } | varlist:lvals Equals explist:rvals { Luaby::AST::Assignment.new lvals, rvals } | functioncall { @TODO } | DoubleColon Name:name DoubleColon { Luaby::AST::Label.new name } | Break { Luaby::AST::Break.new } | Goto Name:name { Luaby::AST::Goto.new name } | Do block:block End { Luaby::AST::Block.new block } | While exp:exp Do block:block End { Luaby::AST::While.new exp, block } | Repeat block:block Until exp:exp { Luaby::AST::Repeat.new block, exp } | If exp:exp Then block:block End { Luaby::AST::If.new exp, block } | For var:var Equals exp:from Comma exp:to Do block:block End { Luaby::AST::ForFromTo.new var, from, to, block } | For var:var Equals exp:from Comma exp:to Comma exp:step Do block:block End { Luaby::AST::ForFromToStep.new var, from, to, step, block } | For namelist:namelist In explist:explist Do block:block End { Luaby::AST::ForIn.new namelist, explist, block } | Local Function Name:name funcbody:body { Luaby::AST::LocalFunction.new name, body } | Function funcname:name funcbody:body { Luaby::AST::Function.new name, body } | Local namelist:names Equals explist:exps { Luaby::AST::LocalAssignment.new names, exps } | Local namelist:namelist { Luaby::AST::LocalDeclaration.new namelist })")
  Rules[:_funcname] = rule_info("funcname", "Name:first (Comma < Name >)*:rest { [first, *rest] }")
  Rules[:_varlist] = rule_info("varlist", "var:first (Comma < var >)*:rest { [first, *rest] }")
  Rules[:_var] = rule_info("var", "(prefixexp:table LeftBracket exp:index RightBracket { Luaby::AST::TableLookup.new table, index } | prefixexp:table Dot Name:name { Luaby::AST::TableLookup.new table, Luaby::AST::String.new(index) } | Name:name { Luaby::AST::Variable.new name })")
  Rules[:_namelist] = rule_info("namelist", "Name:first (Comma < Name >)*:rest { [first, *rest] }")
  Rules[:_explist] = rule_info("explist", "exp:first (Comma < exp >)*:rest { [first, *rest] }")
  Rules[:_exp] = rule_info("exp", "or_exp:exp { exp }")
  Rules[:_or_exp] = rule_info("or_exp", "(or_exp:l Or and_exp:r { Luaby::AST::Or.new l, r } | and_exp:exp { exp })")
  Rules[:_and_exp] = rule_info("and_exp", "(and_exp:l Or rel_exp:r { Luaby::AST::And.new l, r} | rel_exp:exp { exp })")
  Rules[:_rel_exp] = rule_info("rel_exp", "(rel_exp:l LessThanEqual concat_exp:r { Luaby::AST::LessThanEqual.new l, r } | rel_exp:l LessThan concat_exp:r { Luaby::AST::LessThan.new l, r } | rel_exp:l GreaterThanEqual concat_exp:r { Luaby::AST::GreaterThanEqual.new l, r } | rel_exp:l GreaterThan concat_exp:r { Luaby::AST::GreaterThan.new l, r } | rel_exp:l NotEqual concat_exp:r { Luaby::AST::NotEqual.new l, r } | rel_exp:l DoubleEqual concat_exp:r { Luaby::AST::Equal.new l, r } | concat_exp:exp { exp })")
  Rules[:_concat_exp] = rule_info("concat_exp", "(add_exp:l DoubleDot concat_exp:r { Luaby::AST::Concat.new l, r } | add_exp:exp { exp })")
  Rules[:_add_exp] = rule_info("add_exp", "(add_exp:l Plus mul_exp:r { Luaby::AST::Add.new l, r } | add_exp:l Minus mul_exp:r { Luaby::AST::Subtract.new l, r } | mul_exp:exp { exp })")
  Rules[:_mul_exp] = rule_info("mul_exp", "(mul_exp:l Times unary_exp:r { Luaby::AST::Multiply.new l, r } | mul_exp:l Divide unary_exp:r { Luaby::AST::Divide.new l, r } | mul_exp:l Modulo unary_exp:r { Luaby::AST::Modulo.new l, r } | unary_exp:exp { exp })")
  Rules[:_unary_exp] = rule_info("unary_exp", "(Not pow_exp:operand { Luaby::AST::Not.new operand } | Count pow_exp:operand { Luaby::AST::Count.new operand } | Minus pow_exp:operand { Luaby::AST::Negate.new operand } | pow_exp:exp { exp })")
  Rules[:_pow_exp] = rule_info("pow_exp", "(pri_exp:l Power pow_exp:r { Luaby::AST::Power.new l, r } | pri_exp:exp { exp })")
  Rules[:_pri_exp] = rule_info("pri_exp", "(Nil { Luaby::AST::Nil.new } | False { Luaby::AST::False.new } | True { Luaby::AST::True.new } | Number:n { Luaby::AST::Number.new n } | string_literal:str { str } | TripleDot { Luaby::AST::Nil.new } | functiondef | prefixexp | tableconstructor)")
  Rules[:_prefixexp] = rule_info("prefixexp", "(var:var { var } | LeftParen exp:exp RightParen { exp } | functioncall:fcall { fcall })")
  Rules[:_functioncall] = rule_info("functioncall", "(prefixexp:callee args:args { Luaby::AST::FunctionCall.new callee, args } | prefixexp:obj Colon Name:method args:args { Luaby::AST::MethodCall.new obj, method, args })")
  Rules[:_args] = rule_info("args", "(LeftParen explist:explist RightParen { explist } | tableconstructor:arg { [arg] } | string_literal:arg { [arg] })")
  Rules[:_functiondef] = rule_info("functiondef", "Function funcbody:func { func }")
  Rules[:_funcbody] = rule_info("funcbody", "LeftParen parlist:args RightParen block:b End { Luaby::AST::Function.new args, b }")
  Rules[:_parlist] = rule_info("parlist", "(namelist:params Comma TripleDot { Luaby::AST::Parameters.new true, params } | namelist:params { Luaby::AST::Parameters.new false, params } | TripleDot { Luaby::AST::Parameters.new true, [] })")
  Rules[:_tableconstructor] = rule_info("tableconstructor", "LeftBrace fieldlist:fl RightBrace { Luaby::AST::TableConstructor.new fl }")
  Rules[:_fieldlist] = rule_info("fieldlist", "field:first (fieldsep < field >)*:rst fieldsep? { [first, *rst] }")
  Rules[:_fieldsep] = rule_info("fieldsep", "(Comma | Semicolon)")
  Rules[:_field] = rule_info("field", "(LeftBracket exp:key RightBracket Equals exp:val { [key, val] } | Name:key Equals exp:val { [Luaby::AST::StringLiteral.new(key), val] } | exp:val { [nil, exp] })")
  Rules[:_root] = rule_info("root", "Shebang? - chunk:chunk /\\Z/ { chunk }")
  # :startdoc:
end
