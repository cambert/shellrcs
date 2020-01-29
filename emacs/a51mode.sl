% -*- SLang -*-

% a51mode.sl

% A simple 8051-asm mode, copied and 
% modified from the tiasm-mode (tiasm.sl)
%
% Jens Wilhelm Wulf <j.w.wulf@gmx.net> 26.06.2001
% homepage: http://kisocd.sourceforge.net/
%
% Do as you wish with this code under the following conditions:
% 1) leave this notice intact
% 2) don't try to sell it
% 3) don't try pretend it is your own code

define a51_indentcomment()
{
  bol();
  if (ffind_char(';'))
    {
      fsearch(";");
      if (what_column() < 30) insert_spaces(30-what_column());
    }
}

define a51_autoindent()
  % ganze Zeile automatisch einrücken
{
  bol_skip_white();
  if (looking_at("add ") or
      looking_at("anl ") or
      looking_at("clr ") or
      looking_at("cpl ") or
      looking_at("dec ") or
      looking_at("div ") or
      looking_at("inc ") or
      looking_at("jbc ") or
      looking_at("jmp ") or
      looking_at("jnb ") or
      looking_at("jnc ") or
      looking_at("jnz ") or
      looking_at("mov ") or
      looking_at("mul ") or
      looking_at("org ") or      
      looking_at("orl ") or
      looking_at("out ") or
      looking_at("pop ") or
      looking_at("rlc ") or
      looking_at("rrc ") or
      looking_at("rst ") or
      looking_at("xch ") or
      looking_at("xrl ") or
      looking_at("addc ") or
      looking_at("ajmp ") or
      looking_at("cjne ") or
      looking_at("djnz ") or
      looking_at("ljmp ") or
      looking_at("movc ") or
      looking_at("movx ") or
      looking_at("push ") or
      looking_at("setb ") or
      looking_at("sjmp ") or
      looking_at("subb ") or
      looking_at("swap ") or
      looking_at("xchd ") or
      looking_at("da ") or
      looking_at("in ") or
      looking_at("jb ") or
      looking_at("jc ") or
      looking_at("jz ") or
      looking_at("rl ") or
      looking_at("rr ") or
      looking_at("acall ") or
      looking_at("lcall "))
    {
      % Auf Spalte 4 rcken, es ist ein Befehl
      bol_trim();
      insert_spaces(3);
      % Dieser Befehl sollte auch Parameter haben, 
      % also auch die einrücken!
      skip_white();
      skip_word_chars();
      trim();
      insert_spaces(13-what_column());
      a51_indentcomment();
    }
  else
    {
      if (looking_at("nop ") or
	  looking_at("reti ") or
	  looking_at("ret "))
	{
	  % Auf Spalte 4 rcken, es ist ein Befehl ohne Parameter
	  bol_trim();
	  insert_spaces(3);
	  a51_indentcomment();
	}
    }  
}

define a51_indent_line()
{
  variable spalte;
  
  spalte = what_column();
  a51_autoindent();
  
  if (spalte <  4) goto_column( 4);
  else 
    if (spalte < 13) goto_column(13);
  else 
    if (spalte < 30) goto_column(30);
  else 
    if (spalte < 40) goto_column(40);
  else 
    if (spalte < 50) goto_column(50);
  else 
    if (spalte < 60) goto_column(60);
}

define a51_newline()
{
  variable spalte;
  
  spalte = what_column();
  skip_white();

  if (eolp())
    {
      
      a51_autoindent(); % Zeile automatisch formatieren
      
      % die Zeile sollte in der selben Spalte beginnen wie die davor.
      bol();
      skip_chars(" \t");
      spalte = what_column();  
      eol();
      newline();
      goto_column(spalte);
    }
  else
    {
      goto_column(spalte);
      newline();
    }
}

$1 = "a51";
create_syntax_table ($1);

define_syntax (";", "", '%', $1);        % Comment Syntax
%define_syntax ('\\', '\\', $1);         % Quote character
%define_syntax ("{[", "}]", '(', $1);    %  are all these needed?
%define_syntax ('\'', '"', $1);          %  string
%define_syntax ("$~^_&#", '+', $1);      %  operators
%define_syntax ("|&{}[],", ',', $1);     %  delimiters
define_syntax ("a-zA-Z0-9.", 'w', $1);   % "Words", normales Zeug halt
define_syntax ('$', '#', $1);            % compiler-Direktiven
set_syntax_flags ($1, 1 | 2);
set_fortran_comment_chars ($1, ";");

% Type 0 keywords
() = define_keywords_n ($1, "addanlclrcpldecdivendequincjbcjmpjnbjncjnzmovmulnoporgorloutpopretrlcrrcrstxchxrl", 3, 0);
() = define_keywords_n ($1, "addcajmpcallcjnedatadjnzljmpmovcmovxpushretisetbsjmpsubbswapxchd", 4, 0);
() = define_keywords_n ($1, "dainjbjcjzrlrr", 2, 0);
() = define_keywords_n ($1, "acalllcall", 5, 0);

define a51_mode ()
{
  variable kmap = "a51";
  set_mode(kmap, 4);
  use_syntax_table (kmap);
  set_buffer_hook ("indent_hook", "a51_indent_line");
  set_buffer_hook ("newline_indent_hook", "a51_newline");
  mode_set_mode_info (kmap, "fold_info", ";{{{\r;}}}\r\r");
  runhooks("a51_mode_hook");
}






