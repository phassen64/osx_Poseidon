=begin
    Regulaer Expressions
        DES:    search string patterns
        example-1: 'Ruby'=~/[Rr]uby/ # => true; pattern 'Ruby' found
        example-2: r=/[Rr]uby/; s='Ruby'; s=~r  # => true
=end
#!$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

require_relative "TUT.inc"
$m.f_hdr("Regulaer Expressions",__FILE__,false)

#   RegEx: Common Notations
s = <<HERE
<<< RegEx:Tab Common Notations
    META        { '+','?','.','*','^','$','(',')','[',']','{','}','|','\\'  }
    command...  /ReX/ or %r{ReX} or %r(ReX) or %r[ReX] or %r<ReX>
    match...    s =~ r or r.match(s) => BOOLEAN
    c           c : all chars without META
    .           any 1 single-char (without \\n)
    c?          char 'c' 0|1 times
    c*          char 'c' 0<=n<=MAX times
    c+          char 'c' 1<=n<=MAX times
    a|b         a or b - "inclusive-option"
    [...]       for 1 single-char in the braces - "exclusive-option"
    [^...]      for any char NOT in the braces
    ReX{n}      n times
    ReX{n,m}    times of expressions >=n but <=m
    ReX{n,}     >=n times
    ReX{,m}     <=m times
    ^           begin of RegEx
    $           end of RegEx
    \A \Z       anchor begin,end RegEx mulit-line
    \<META>     1 single META-char
    \w \W       word or NOT-word
    \s \S       whiteSpace or NOT-whiteSpace
    \d \D       digit or NOT-digit
    \h \H       hexDigit or NOT-hexDigit
    (?# CMT)    comment CMT
    (ReX)       Group of RegEx
    (?imx)      temporarily option ON of    : {i,m,x}
    (?-imx)     temporarily option OFF of   : {i,m,x}
    ReX && ReX  combine2
>>> RegEx:end
HERE
$m.f_put(s)

#   RegEx: POSIX char notation
s = <<HERE
<<< RegEx:POSIX bracket expressions
    /[[:graph:]]/   =: Non-blank character
    /[[:print:]]/   =: like :graph: but incl. SPACE
    /[[:digit:]]/   =: Digit
    /[[:xdigit:]]/  =: HexDigit like i.e., 0-9a-fA-F)
    /[[:alpha:]]/   =: Alphabetic character
    /[[:upper:]]/   =: upper case Alphabetic character
    /[[:lower:]]/   =: lower case Alphabetic character
    /[[:alnum:]]/   =: Alphabetic and numeric character
    /[[:blank:]]/   =: Space or tab
    /[[:cntrl:]]/   =: Control character
    /[[:punct:]]/   =: punctuation char
    /[[:space:]]/   =: char-SPACE
    === extended character-classes
    /[[:word:]]/    =: WORD
    /[[:ascii:]]/   =: any ASCII character
>>> RegEx:end
HERE
$m.f_put(s)

#   RegEx: Modifier
s = <<HERE
<<< RegEx:Modifier
    i           ignore case
    o           perform RegEx only once
    m           multi-line
    x           extended-RegEx (white-spaces, comments, multi-line RegEx)
>>> RegEx:end
HERE
$m.f_put(s)


#
#   !THM:Introduction
#
$m.f_thm("Introduction to RegEx")

#   seek with : { '^','$','.'}
$m.f_trc(__FILE__,__LINE__,nil)

def fX(p_sVal,p_bVal,p_iLine)
    s=p_sVal
    $m.f_puts("[#{p_iLine}]:'#{s}':=>#{p_bVal}")
end

def fP(p_sVal,p_iVal,p_iLine)
    if (p_iVal==nil)
        p_iVal='NIL!'
    end
    s=Regexp.escape(p_sVal)
    $m.f_puts("[#{p_iLine}]:'#{s}':=>#{p_iVal}",true)
end


$m.f_thm("simple",true,__LINE__)
#   complete (sub-)word
s='RubyWay';    s =~ /Ruby/     ? fX(s,true,__LINE__):fX(s,false,__LINE__)   # T
#   use alternative-match syntax: s=~r => r.match(s)
s='RubyMatch';
r=/Ruby/
r.match(s) ? fX(s,true,__LINE__):fX(s,false,__LINE__)   # T
#   exclusive-options [ab]
s='rubyOpt';    s =~ /[Rr]uby/  ? fX(s,true,__LINE__):fX(s,false,__LINE__)   # T
#   comment (?#...)
s='rubyCmt';    s =~ /ruby(?# comment)/ ? fX(s,true,__LINE__):fX(s,false,__LINE__)    # T

#
#   match : r.match(s) or s.match(r) and compiled rS
#
$m.f_thm("using:match",true,__LINE__)
s = '2018-03-07 08:30:22'
r = /20\d{2}-\d{1,2}-\d{1,2}\s\d{1,2}:\d{1,2}:\d{1,2}/
xRc = r.match(s); $m.f_puts("r.match('#{s}')    :=> <#{xRc}>")  # =: s
xRc = s.match(r); $m.f_puts("('#{s}').match(r)  :=> <#{xRc}>")  # =: s - the same
#   instead of /../ we use a string
rS  = '20\d{2}-\d{1,2}-\d{1,2}\s\d{1,2}:\d{1,2}:\d{1,2}'
r   = Regexp.compile(rS)
xRc = r.match(s); $m.f_puts("r.match('#{s}')    :=> <#{xRc}>")  # =: s
xRc = s =~ r;     $m.f_puts("s =~ r             :=> <#{xRc}>")  # =: '0'

$m.f_thm("alternative syntax '%r{RegEx}'",true,__LINE__)
#   alternative command Syntax %r{...} or %r(...)
s='RubyA{}';  s =~ %r{Ruby}     ? fX(s,true,__LINE__):fX(s,false,__LINE__)   # T
s='RubyA[]';  s =~ %r[Ruby]     ? fX(s,true,__LINE__):fX(s,false,__LINE__)   # T
s='RubyA()';  s =~ %r(Ruby)     ? fX(s,true,__LINE__):fX(s,false,__LINE__)   # T
s='RubyA<>';  s =~ %r<Ruby>     ? fX(s,true,__LINE__):fX(s,false,__LINE__)   # T

#   Multi-Line extended RegEx with comments and white-spaces
#   split RegEx into multi lines, save, run later
$m.f_thm("multi-line RegEx",true,__LINE__)
s  = 'rubyML';
rX = /  [Rr]ubyML                                   #   the Text with spaces
        (?# RegEx comment: this my multi-lined)     #   Ruby Comment allowed
     /x
s =~ rX ? fX(s,true,__LINE__):fX(s,false,__LINE__)    # T

#   single char
$m.f_thm("single char",true,__LINE__)
s='ABC'
s =~ /A.C/ ? fX(s,true,__LINE__):fX(s,false,__LINE__)   # T
s =~ /AB./ ? fX(s,true,__LINE__):fX(s,false,__LINE__)   # T

#   RegEx n-Times
$m.f_thm("count times {'+','*','{n}'",true,__LINE__)
s='aaabxycccddddfgggh'
#   s='aaabxyzcccddddfxgggh'
#        .       #   '.' :   any char ('&')
#        ?       #   ?   :   0|1 char
#       h{1,3}  #   h   :   1<=n<=3 times
rX = %r<        # use alternative syntax
        a+      #   a   :   minimal 1 time
        b       #   b   :   exact 1 time
        x?      #   x?  :   1 or no x
        .       #   y   :   '.' : any
        .       #   z   :   '.' : any
        c*      #   c   :   0 or n time
        d{4}    #   d   :   exact 4 times
        e*      #   e   :   0 or n times    # 'e' will not be found
        f+      #   f   :   minimal 1 time
        g{2,}   #   g   :   minimal 2 times
        h{,2}   #   h   :   maximal 2 times
     >x # use multi-line RegEx, white-spaces allowed
s =~ rX ? fX(s,true,__LINE__):fX(s,false,__LINE__)   # T

#   RegEx inclusive-option
$m.f_thm("options : a|b",true,__LINE__)
rX = %r<
        abC|ABc     # pattern 'abC' or 'ABc'
    >x
s='abC'; s =~ rX ? fX(s,true,__LINE__):fX(s,false,__LINE__)   # T
s='ABc'; s =~ rX ? fX(s,true,__LINE__):fX(s,false,__LINE__)   # T

#   RegEx inclusive-single-set-option
$m.f_thm("options : [abc]",true,__LINE__)
rX = %r<
        p[eEa]ter    # pattern 'e' or 'E' or 'a'
    >x
s='peter'; s =~ rX ? fX(s,true,__LINE__):fX(s,false,__LINE__)   # T
s='pEter'; s =~ rX ? fX(s,true,__LINE__):fX(s,false,__LINE__)   # T
s='pater'; s =~ rX ? fX(s,true,__LINE__):fX(s,false,__LINE__)   # T

#   RegEx NON-set-option
$m.f_thm("NON-options : [^abc]",true,__LINE__)
rX = %r<
        p[^eEa]ter   # pattern NOT 'e' or 'E' or 'a'
    >x
s='pxter'; s =~ rX ? fX(s,true,__LINE__):fX(s,false,__LINE__)   # T
s='poter'; s =~ rX ? fX(s,true,__LINE__):fX(s,false,__LINE__)   # T

#   RegEx Anchors
$m.f_thm("RegEx BEGIN('^') and RegEx END('$')",true)
s='abc';
s =~ /^a/   ? fX(s,true,__LINE__):fX(s,false,__LINE__)  # T
s =~ /^b/   ? fX(s,true,__LINE__):fX(s,false,__LINE__)  # F
s =~ /c$/   ? fX(s,true,__LINE__):fX(s,false,__LINE__)  # T

#
#   RegEx compact chars
#
$m.f_thm("RegEx word",true,__LINE__)
#   1) Text with 1 space
s='abc xyz';
#   normal RegEx
s =~ /\w xyz/   ? fX(s,true,__LINE__):fX(s,false,__LINE__)  # T
#   extended RegEx with spaces
rX =    /
            \w \s xyz       # explicit '\s' for 1 single white-space
        /x
s =~ rX ? fX(s,true,__LINE__):fX(s,false,__LINE__)  # T
#   2) complex Text
s   =   'abc 12a  zgo§.';
r   = %r<
    \w          #   1 word
    \s          #   1 space
    \d{2}       #   2 decimal values
    \h{1}       #   1 hex-value
    \s{1,}      #   minimal 1 space
    \H{3}       #   'zgo': 3 NON-hex-value
    \S+         #   non space chars
    \.          #   the char '.'
>x
s =~ r ? fX(s,true,__LINE__):fX(s,false,__LINE__)  # T

#   RegEx combined
$m.f_thm("RegEx2 && RegEx2",true,__LINE__)
r = %r<
    [a-z && [^eu]]{3}  # 3 Alpha but not 'e' and 'u'
>x
s='abc1'; s =~ r ? fX(s,true,__LINE__):fX(s,false,__LINE__)     # T
s='pq12'; s =~ r ? fX(s,true,__LINE__):fX(s,false,__LINE__)     # F
s='aubc'; s =~ r ? fX(s,true,__LINE__):fX(s,false,__LINE__)     # F

#   RegEx POSIX-char
$m.f_thm("POSIX chars",true)
s='ab c'
r = %r< [[:alnum:]]{2} [[:blank:]] [[:alpha:]] >x
s =~ r ? fX(s,true,__LINE__):fX(s,false,__LINE__)     # T

#
#   !THM: compile RegEx
#
$m.f_thm("Compiling RegEx")
s   =   'abc def ghi';
sR  =   '\w{3}'     # try regString
r   =   Regexp.compile(sR)
s   =~  r ? fX(s,true,__LINE__):fX(s,false,__LINE__)     # T

$m.f_thm("Compiling RegEx parameters",true)
s   =   "abc def";      # OK
s   =   "aBc \ndef";    # NOK - !RBY:options doesn't work
o1  =   Regexp::MULTILINE || Regexp::IGNORECASE
sR  =   '[a-z]{3}\s[a-z]{3}' # without %r{...} and '..' NOT "..."
r   =   Regexp.compile(sR,o1)
s   =~  r ? fX(s,true,__LINE__):fX(s,false,__LINE__)     # F(T)

#
#   !THM: Escape Special-Characters(META)
#
$m.f_thm("Escape META-characters")
s   =   "ab*c"      # '*' is a META
sR  =   Regexp.escape(s)
$m.f_inf("use:sR:='#{sR}'")
r   =   Regexp.compile(sR)
$m.f_inf("use:r:='#{r}'")
s   =~ r ? fX(s,true,__LINE__):fX(s,false,__LINE__)     # F(T

#
#   !THM: RegEx Anchors2 (^,$,\A\Z...)
#
$m.f_thm("RegEx Anchors")
s   =   "abcX\npefX\nghi"
#   use '^'
r = /^pef/;  pX = r =~s;  fP(s,pX,__LINE__)     # 5
r = /fX$/;   pX = r =~s;  fP(s,pX,__LINE__)     # 7
r = /\Apef/; pX = r =~s;  fP(s,pX,__LINE__)     # nil
r = /\Aabc/; pX = r =~s;  fP(s,pX,__LINE__)     # 0
r = /ghi\Z/; pX = r =~s;  fP(s,pX,__LINE__)     # 10

#
#   !THM: RegEx quantifiers -- see above
#
$m.f_thm("RegEx quantifiers -- see above")
s   =   'aaabxycccddddfgggh'
sR  =   'a{3}b...c+d+e*f*g+h'
r   =   Regexp.compile(sR)
s   =~  r ? fX(s,true,__LINE__):fX(s,false,__LINE__)   # T

#
#   !THM: look-ahead : positive || negative
#
$m.f_thm("RegEx : look-ahead : positive || negative")

$m.f_thm("look ahead : positive",true,__LINE__) #   ?=
r   =   /New World(?= Dictionary| Symphonie)/
s   =   'New World Dictionary'
s   =~  r ? fX(s,true,__LINE__):fX(s,false,__LINE__)   # T
s   =   'New World Symphonie'
s   =~  r ? fX(s,true,__LINE__):fX(s,false,__LINE__)   # T
s   =   'New World Hello'
s   =~  r ? fX(s,true,__LINE__):fX(s,false,__LINE__)   # F

$m.f_thm("look ahead: negative",true,__LINE__)
r   =   /New World(?! Dictionary| Symphonie)/
s   =   'New World Dictionary'
s   =~  r ? fX(s,true,__LINE__):fX(s,false,__LINE__)   # F
s   =   'New World Hello'
s   =~  r ? fX(s,true,__LINE__):fX(s,false,__LINE__)   # T

#
#   !THM: look-behind : positive || negative
#
$m.f_thm("RegEx : look-behind : positive || negative")
#   ?<=
$m.f_thm("look behind : positive",true,__LINE__) #   ?<=
r = /(?<=a)b/
s = 'xbabx'; s  =~ r ? fX(s,true,__LINE__):fX(s,false,__LINE__)    # T
s = 'baxbx'; s  =~ r ? fX(s,true,__LINE__):fX(s,false,__LINE__)    # F
r = /(?<=peter) willi/
s = 'otto peter willi'; s  =~ r ? fX(s,true,__LINE__):fX(s,false,__LINE__)    # T
s = 'peter otto willi'; s  =~ r ? fX(s,true,__LINE__):fX(s,false,__LINE__)    # F
#   ?<!
$m.f_thm("look behind : negative",true,__LINE__) #  ?<!
r = /(?<!peter) willi/
s = 'otto peter willi'; s  =~ r ? fX(s,true,__LINE__):fX(s,false,__LINE__)    # F
s = 'peter otto willi'; s  =~ r ? fX(s,true,__LINE__):fX(s,false,__LINE__)    # T

#
#   !THM: access back-references
#
$m.f_thm("RegEx : access back-references")
s = 'a123bcd456'
r = /(a\d{3})(\D{3})(\d{3})/   # $1:(a\d{3}); $2:(\D{3}); $3:(\d{3})
#   results are saved with ()
s  =~ r ? fX(s,true,__LINE__):fX(s,false,__LINE__)    # T
$m.f_inf("RESULTs:$1='#{$1}';$2='#{$2}';$3='#{$3}'")
# <<< RESULTs:$1='a123';$2='bcd';$3='456'
$m.f_inf("REVERSE:'#{$3}#{$1}#{$2}'") # <<< REVERSE:'456a123bcd'

#
#   !THM: access back-references with explicit-named results
#
$m.f_thm("RegEx : access back-references - explicit naming")
$m.f_trc(__FILE__,__LINE__,__method__,"RegEx:naming")
s = 'N-90489-NUM'
r = /(?<vPLZ>\d{5}).(?<vID>\D{3})/
x = r.match(s)
$m.f_inf("INP>'#{s}")
$m.f_inf("OUT<PLZ='#{x["vPLZ"]}';ID=#{x["vID"]}") # <<< PLZ:'90489';ID:NUM

#
#   !THM: character class
#
$m.f_thm("RegEx : character-class")
$m.f_thm("simple",true,__LINE__)
s='a$bcdf23'
r=/[a-z]/
(x = r.match(s)) ? fX(s,true,__LINE__):fX(s,false,__LINE__)    # T
#   use special, use alternative match syntax

$m.f_thm("META chars",true,__LINE__)
s='abc';r=/[.?]/; (x = r.match(s)) ? fX(s,true,__LINE__):fX(s,false,__LINE__)    # F
s='a.c';r=/[.?]/; (x = r.match(s)) ? fX(s,true,__LINE__):fX(s,false,__LINE__)    # T
s='..?';r=/[.?]/; (x = r.match(s)) ? fX(s,true,__LINE__):fX(s,false,__LINE__)    # T
s='abc';r=/[^.?]/; (x=s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)    # T
s='a.c';r=/[^.?]/; (x=s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)    # T
s='a^b';r=/[\^]/; (x=s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)     # T
s='a.b';r=/[\^]/; (x=s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)     # F

$m.f_thm("POSIX",true,__LINE__)
s='a2c';r=/[[:alpha:]]/; (x=s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)     # T
s='123';r=/[[:alpha:]]/; (x=s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)     # F
s='abc';r=/[[:alnum:]]/; (x=s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)     # T
s='123';r=/[[:alnum:]]/; (x=s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)     # T
s='1.3';r=/[[:print:]]/; (x=s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)     # T
s=' ';r=/[[:print:]]/; (x=s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)      # T
s=' ';r=/[[:graph:]]/; (x=s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)      # F
s='1';r=/[[:digit:]]/; (x=s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)      # T
s='a';r=/[[:digit:]]/; (x=s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)      # F
s='a';r=/[[:xdigit:]]/; (x=s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)     # T
s='F';r=/[[:xdigit:]]/; (x=s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)     # T
s='K';r=/[[:xdigit:]]/; (x=s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)     # F

$m.f_thm("POSIX negative",true,__LINE__)
s='1';r=/[[:^digit:]]/; (x=s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)      # F
s='.';r=/[[:^digit:]]/; (x=s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)      # T

$m.f_thm("POSIX n vs 1 char test",true,__LINE__)
#   is any char alpha?
s='a2cd';r=/[[:alnum:]]/; (x=s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)     # T
#   are all chars alpha?
s='a2cd';r=/[[:alnum:]]{4}/; (x=s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)  # F
#   with use of #{x}-string-syntax - wrong syntax highlighting
s='a2cd';r=/[[:alnum:]]{#{s.size}}/; (x=s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)  # F
# or

$m.f_thm("POSIX char test functions",true,__LINE__)
def f__isNumeric(p_sVal)
    s = p_sVal
    iLen = s.size
    r=/[[:digit:]]{#{iLen}}/
    x = s.match(r)
    if ((x==nil) || (x==false))
        bRc=false
    else
        bRc=true
    end
    return bRc
end
s='123901';   bRc=f__isNumeric(s);  $m.f_puts("_isNumeric['#{s}'] :=> <#{bRc}>")    # T
s='4321h1';   bRc=f__isNumeric(s);  $m.f_puts("_isNumeric['#{s}'] :=> <#{bRc}>")    # F
#   use Library function
s='123'; bRc=$m.f_isNumeric(s);$m.f_puts("isNumeric['#{s}'] :=> <#{bRc}>")    # T
s='a1c'; bRc=$m.f_isNumeric(s);$m.f_puts("isNumeric['#{s}'] :=> <#{bRc}>")    # F
s='abc'; bRc=$m.f_isAlpha(s);$m.f_puts("isAlpha['#{s}'] :=> <#{bRc}>")    # T
s='a1c'; bRc=$m.f_isAlpha(s);$m.f_puts("isAlpha['#{s}'] :=> <#{bRc}>")    # F
s='123'; bRc=$m.f_isAlpha(s);$m.f_puts("isAlpha['#{s}'] :=> <#{bRc}>")    # F
s='a1c'; bRc=$m.f_isAlnum(s);$m.f_puts("isAlnum['#{s}'] :=> <#{bRc}>")    # T
s='A1c'; bRc=$m.f_isHexnum(s);$m.f_puts("isHexnum['#{s}'] :=> <#{bRc}>")    # T
s='A1g'; bRc=$m.f_isHexnum(s);$m.f_puts("isHexnum['#{s}'] :=> <#{bRc}>")    # F
s='A g'; bRc=$m.f_isPrint(s);$m.f_puts("isPrint['#{s}'] :=> <#{bRc}>")    # T
s='A g'; bRc=$m.f_isGraph(s);$m.f_puts("isGraph['#{s}'] :=> <#{bRc}>")    # F
s='A_g'; bRc=$m.f_isGraph(s);$m.f_puts("isGraph['#{s}'] :=> <#{bRc}>")    # T

s='ABC'; bRc=$m.f_isUpper(s);$m.f_puts("isUpper['#{s}'] :=> <#{bRc}>")    # T
s='A.C'; bRc=$m.f_isUpper(s);$m.f_puts("isUpper['#{s}'] :=> <#{bRc}>")    # F
s='abc'; bRc=$m.f_isLower(s);$m.f_puts("isLower['#{s}'] :=> <#{bRc}>")    # T
s='_bc'; bRc=$m.f_isLower(s);$m.f_puts("isLower['#{s}'] :=> <#{bRc}>")    # F
s='Abc'; bRc=$m.f_isLower(s);$m.f_puts("isLower['#{s}'] :=> <#{bRc}>")    # F

s='   '; bRc=$m.f_isBlank(s);$m.f_puts("isBlank['#{s}'] :=> <#{bRc}>")    # T
s='x  '; bRc=$m.f_isBlank(s);$m.f_puts("isBlank['#{s}'] :=> <#{bRc}>")    # F
s="\t "; bRc=$m.f_isBlank(s);$m.f_puts("isBlank['\t '] :=> <#{bRc}>")    # T
s="\t "; bRc=$m.f_isCntrl(s);$m.f_puts("isCntrl['\t '] :=> <#{bRc}>")    # F
s="\n\t"; bRc=$m.f_isCntrl(s);$m.f_puts("isCntrl['n\t'] :=> <#{bRc}>")    # T

s=".,;'\""; bRc=$m.f_isPunct(s);$m.f_puts("isPunct[#{s}] :=> <#{bRc}>")    # T

#
#   !THM: RegEx modifiers 'm','x','i'
#
$m.f_thm("RegEx modifier usage")

$m.f_thm("multi-lined(extended) with DOT",true,__LINE__)
s="Peter\n90489\nNuernberg"
r=/90489.N/     # ordinary RegEx
(x = s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)    # F
r=/90489.N/m    # multi-Line RegEx
(x = s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)    # T
r=/ 90489
    .       # any char - even '\n'
    N
    /mx    # RegEx multi-Line + extended
(x = s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)    # T

$m.f_thm("ignore-case",true,__LINE__)
s="!ABCDE"
r=/abc/;  (x = s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)    # F
r=/abc/i; (x = s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)    # T

#
#   !THM: RegEx switch-ON/OFF-option for RegEx-modifier
#       ON:     ?<x>
#       OFF:    ?-<x>
#       with    x={'m','i','x'}
#
$m.f_thm("RegEx switch-ON/OFF RegEx-modifier")
$m.f_trc(__FILE__,__LINE__,__method__,"RegEx:switch")
s="ABC"; r=/abc/;  (x = s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)        # F
#   switch-on: 'ignore case'
s="ABC"; r=/(?i)abc/;  (x = s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)    # T
#   switch-on: 'ignore case' for 'ab' then switch-off for 'c'
s="ABC"; r=/(?i)ab(?-i)c/;  (x = s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)    # F
s="ABc"; r=/(?i)ab(?-i)c/;  (x = s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)    # T

#
#   !THM: RegEx Embedded Sub-Expressions
$m.f_thm("RegEx Sub-Expressions '(?>...)'")
s="ABCde"
r=/abc/;  (x = s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)        # F
#   use Syntax : (?>...)
r=/(?>ABC)(?>de)/;  (x = s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)       # T
#   combined with SWITCHes
r=/(?>(?i)abc)(?>de)/;  (x = s=~r) ? fX(s,true,__LINE__):fX(s,false,__LINE__)   # T

$m.f_trc(__FILE__,__LINE__,__method__,"END")
$m.f_end

