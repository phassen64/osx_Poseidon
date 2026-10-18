=begin
    HDR:integer && char presentations
        numeral systems:    BIN / OCT / DEC / HEX
        math operations:
            +,-,/,*, **, log10, sqrt
            abs, round, ceil, floor, truncate
            div, modulo, remainder, divmod, quo
            even?, odd?
        math random:
            rand
        types:
            Integer(), Float()
        encoding: US-ASCII
            by: back-slash, by hex-numbers
        encoding integer vs char:
            ord(),chr()
=end
#!$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

require_relative "TUT.inc"
#   require "math"
$m.f_hdr("integer",__FILE__)

#
#   !THM:numeral systems
#
$m.f_thm("numeral systems : bin,oct,dec,hex")

#   define integer : bin,oct,dec,hex
$m.f_thm("to define", true)
z = 0b1010; s = sprintf("z(bin)  : %0b",z) ; $m.f_puts(s)
z = 0o567;  s = sprintf("z(oct)  : %0o",z) ; $m.f_puts(s)
z = 123;    s = sprintf("z(dec)  : %0d",z) ; $m.f_puts(s)
z = 0xAf3;  s = sprintf("z(hex)  : %0x",z) ; $m.f_puts(s)

#   print integer(bin,oct,dec,hex) : formatted
$m.f_thm("bin,oct,dec,hex.format", true)
z = 10
$m.f_inf("use z:=#{z}")            #   use '10'
s = sprintf("z(bin)  : %0b",z) ; $m.f_puts(s)    #   1010
s = sprintf("z(oct)  : %0o",z) ; $m.f_puts(s)    #   12
s = sprintf("z(dec)  : %0d",z) ; $m.f_puts(s)    #   10
s = sprintf("z(hex)  : %0x",z) ; $m.f_puts(s)    #   a
s = sprintf("z(HEX)  : %0X",z) ; $m.f_puts(s)    #   'A'

#   arithmetic: { + - * /
$m.f_thm("basic arithmetic operations")
i=10;f=3.14;a=2;b=5;c=-7;
$m.f_inf("use i=#{i};f=#{f};a:=#{a},b:=#{b},c=#{c}")
$m.f_print "<#{f}>+<#{a}>";     x=f+a; $m.f_print "=: #{x}\n"
$m.f_print "<#{i}>-<#{a}>";     x=i-a; $m.f_print "=: #{x}\n"
$m.f_print "<#{i}>*<#{a}>";     x=i*a; $m.f_print "=: #{x}\n"
$m.f_print "<#{i}>/<#{c}>";     x=i/c; $m.f_print "=: #{x}\n"

#   higher arithmetic: { **, log, sqrt }
$m.f_thm("advanced arithmetic operations")
i=10;f=3.14;a=2;b=120;c=-7;
$m.f_inf("use i=#{i};f=#{f};a:=#{a},b:=#{b},c=#{c}")
$m.f_print "<#{i}>**<#{a}>";     x=i**a; $m.f_print "=: #{x}\n" # power
$m.f_print "x=Math.log10<#{f}>"; x=Math.log10(f); $m.f_print "=: #{x}\n" # log => 0.49...
$m.f_print "x=Math.sqrt(#{b})";  x=Math.sqrt(b);  $m.f_print "=: #{x}\n"

#
#   !THM:math methods
#
$m.f_thm("math(numeric) methods")
f=Math::PI # using gem math
i=10;a=2;b=5;c=-7;
$m.f_inf("use i=#{i};f=#{f};a:=#{a},b:=#{b},c=#{c}")

#   sign
$m.f_thm("sign",true)
$m.f_print "<#{c}>.abs";        x=c.abs;     $m.f_print "=: #{x}\n"

#   roundings
$m.f_thm("rounding",true)
g=f+0.5
$m.f_print "<#{g}>.round";      x=g.round;   $m.f_print "=: #{x}\n"
$m.f_print "<#{f}>.ceil";       x=f.ceil;    $m.f_print "=: #{x}\n"
$m.f_print "<#{f}>.floor";      x=f.floor;   $m.f_print "=: #{x}\n"
#   RubyV2.4 enabled truncate with Parameter
$m.f_print "<#{f}>.truncate";   x=f.truncate;  $m.f_print "=: #{x}\n"

i=3
$m.f_thm("rounding with faction",true)
$m.f_print "<#{f}>.round(#{i})";    x=f.round(i);   $m.f_print "=: #{x}\n"
f=-f
$m.f_print "<#{f}>.round(#{i})";    x=f.round(i);   $m.f_print "=: #{x}\n"

#   div
$m.f_thm("div",true)
$m.f_print "<#{b}>.div<#{a}>";          x=b.div a;        $m.f_print "=: #{x}\n"
$m.f_print "<#{i}>.div<#{c}>";          x=i.div c;        $m.f_print "=: #{x}\n"

#   modulo vs remainder wie modulo-Funktion, beachtet aber das Vorzeichen
i=18;b=-5
$m.f_thm("modula vs remainder",true)
$m.f_print "<#{b}>.modulo<#{a}>";       x=b.modulo a;     $m.f_print "=: #{x}\n"
$m.f_print "<#{b}>.remainder<#{a}>";    x=b.remainder a;  $m.f_print "=: #{x}\n"
$m.f_print "<#{i}>.modulo<#{b}>";       x=i.modulo b;     $m.f_print "=: #{x}\n"
$m.f_print "<#{i}>.remainder<#{b}>";    x=i.remainder b;  $m.f_print "=: #{x}\n"

# div mod
$m.f_thm("divmod",true)
i=17;y=5
$m.f_print "<#{i}>.divmod<#{y}>"; x=i.divmod y;  $m.f_print "=: #{x}\n" #[3,2]
i=-10;y=4
$m.f_print "<#{i}>.divmod<#{y}>"; x=i.divmod y;  $m.f_print "=: #{x}:=x\n" #[-3,2]
$m.f_print "x:#{x}.class"; x=x.class;  $m.f_print "=: #{x}\n" #[-3,2]

# quo vs float
$m.f_thm("real quo vs float",true)
i=17;y=4
$m.f_print "x=<#{i}>.quo<#{y}>";  x=i.quo y;    $m.f_print "=: #{x}\n"  #17/4
$m.f_print "x=<#{x}>.class";      x=x.class;    $m.f_print "=: #{x}\n"  #Rational
i=17;y=4.0
$m.f_print "x=<#{i}>/<#{y}>";     x=i/y;        $m.f_print "=: #{x}\n"  #4.25
$m.f_print "x=<#{x}>.class";      x=x.class;    $m.f_print "=: #{x}\n"  #Float

#
#   !THM:compare numbers
#
$m.f_thm("compare and check")

#   eql? vs '=='  : eql? checks types
#   '=='    :   checks the value
#   'eq?'   :   checks value and type
$m.f_thm("'==' vs eq?",true)
i=10; f=10.1; s=sprintf("i:%d,f:%f",i,f); $m.f_inf(s,p_sId="EQU1:")
bRc = i==f;     $m.f_puts "<#{i}> ==   <#{f}> :=  #{bRc}"     #False
i=10; f=10.0; s=sprintf("i:%d,f:%f",i,f); $m.f_inf(s,p_sId="EQU2:")
# i=10; f=10.0; s=sprintf("i:%d,f:%f",i,f); $m.f_inf(s,p_iColor=C_COLOR_CYAN,p_sId="USE2:")
bRc = i==f;     $m.f_puts "<#{i}> ==   <#{f}> := #{bRc}"      #True
# equal 'eq?'
bRc = i.eql? f; $m.f_puts "<#{i}> eql? <#{f}> := #{bRc}"      #False

#   zero vs nonzero
$m.f_thm("zero? or nonzero?",true)
i=10; z=0; s=sprintf("i:%d,z:%d",i,z); $m.f_inf(s)
bRc = i.zero?;       $m.f_puts "<#{i}>.zero?     := #{bRc} ;"
bRc = z.zero?;       $m.f_puts "<#{z}>.zero?     := #{bRc} ;"
bRc = i.nonzero?;    $m.f_puts "<#{i}>.nonzero?  := #{bRc} ;" # value 10
bRc = z.nonzero?;    $m.f_puts "<#{z}>.nonzero?  := #{bRc} ;" # nil

#   check if integer
$m.f_thm("integer?",true)
i=10; f=2.5; s=sprintf("i:%d,f:%f",i,f); $m.f_inf(s)
bRc = i.integer?;    $m.f_puts "<#{i}>.integer?  := #{bRc} ;"
bRc = f.integer?;    $m.f_puts "<#{f}>.integer?  := #{bRc} ;"

#   even or odd?
$m.f_thm("even or odd?",true)
i=10; j=11;  s=sprintf("i:%d,j:%d",i,j); $m.f_inf(s)
bRc = i.even?;  $m.f_puts "<#{i}>.even?  := #{bRc} ;"
bRc = j.even?;  $m.f_puts "<#{j}>.even?  := #{bRc} ;"
bRc = i.odd?;   $m.f_puts "<#{i}>.odd?   := #{bRc} ;"
bRc = j.odd?;   $m.f_puts "<#{j}>.odd?   := #{bRc} ;"

#   !THM:between <integer/float>
$m.f_thm("between")
# integer check
i=10; a=5; b=15; s=sprintf("i:%d,a:%d,b:%d",i,a,b); $m.f_inf(s)
bRc = i.between?(a,b);  $m.f_puts "<#{i}>.between?(#{a},#{b})   := #{bRc}" #T
i=10; a=11; b=15;
bRc = i.between?(a,b);  $m.f_puts "<#{i}>.between?(#{a},#{b})   := #{bRc}" #F
# float check
f=10.1; af=-5.1; bf=15.1;
bRc = f.between?(af,bf);  $m.f_puts "<#{f}>.between?(#{af},#{bf}) := #{bRc}" #T

#   !THM: show numbers : upto,downto
$m.f_thm("show numbers")
$m.f_thm("upto",true)
a=10; b=3; c=5
$m.f_print("#{b}.upto(#{c})=:")
b.upto(c) { |i| $m.f_print "#{i}," }
$m.f_puts ";"
$m.f_thm("downto",true)
$m.f_print("#{a}.downto(#{b})=:")
a.downto(b) { |i| $m.f_print "#{i}," }
$m.f_puts ";"

#
#   !THM:random
#
$m.f_thm("random numbers")

$m.f_thm("numbers",true)
#
j=5; n=100;
1.upto(j) { |i|
    iRnd = rand(n)  #   0...n-1
    $m.f_puts "number(#{n})[#{i}]\t : " + iRnd.to_s + " ;"
}

$m.f_thm("passwords",true)
1.upto(j) { |i|
    sPwd = '!' + [*('A'..'Z'),*('a'..'z'),*('0'..'9')].shuffle[0,7].join
    $m.f_puts "password(#{j})[#{i}]\t : "  + sPwd.to_s + " ;"
}


#   !THM: integer vs char
$m.f_thm("integer vs char : chr() and ord()")

#   === i2c

#   ASCI :: http://www.asciitable.com/
#   https://de.wikipedia.org/wiki/American_Standard_Code_for_Information_Interchange
#   https://de.wikipedia.org/wiki/ISO_8859-1
#   http://www.utf8-zeichentabelle.de/unicode-utf8-table.pl?number=1024&htmlent=1
#   UTF-8 : 0...2**7 == ASCII
#   !UEDIT: the Uedit extended ASCII table is NOT correct!
f__encode = lambda { |i,x|
    #   c=i.chr(Encoding::ISO_8859_1) # alternativ syntax
    #   c=i.chr(Encoding::UTF_8)
    c   =   i.chr(x)
    s   =   sprintf("chr(0x%0x)['%s'] =: '%c'",i,x,c)
    $m.f_puts s
}

$m.f_thm("i2c<EncodingTable>",true,__LINE__)

f__encode.call(0x21,'ASCII')    #   !
f__encode.call(0x24,'ASCII')    #   $
f__encode.call(0x40,'ASCII')    #   @

#   * undefined   0x80...0x9F
f__encode.call(0x83,'UTF-8')    #   (ƒ)  * undefined
f__encode.call(0x85,'UTF-8')    #   …
f__encode.call(0x86,'UTF-8')    #   †
f__encode.call(0x89,'UTF-8')    #   ‰
f__encode.call(0x8C,'UTF-8')    #   Œ
f__encode.call(0x95,'UTF-8')    #   •
f__encode.call(0x97,'UTF-8')    #   —
f__encode.call(0x99,'UTF-8')    #   ™

f__encode.call(0xa2,'UTF-8')    #   ¢
f__encode.call(0xa3,'UTF-8')    #   £
f__encode.call(0xa5,'UTF-8')    #   ¥
f__encode.call(0xa9,'UTF-8')    #   ©
f__encode.call(0xaB,'UTF-8')    #   «
f__encode.call(0xaE,'UTF-8')    #   ®

f__encode.call(0xb0,'UTF-8')    #   °
f__encode.call(0xb1,'UTF-8')    #   ±
f__encode.call(0xb5,'UTF-8')    #   µ
f__encode.call(0xb6,'UTF-8')    #   ¶
f__encode.call(0xbb,'UTF-8')    #   »
f__encode.call(0xbc,'UTF-8')    #   ¼
f__encode.call(0xbd,'UTF-8')    #   ½
f__encode.call(0xbe,'UTF-8')    #   ¾

f__encode.call(0xc4,'UTF-8')    #   Ä

f__encode.call(0xd6,'UTF-8')    #   Ö
f__encode.call(0xd7,'UTF-8')    #   ×
f__encode.call(0xd8,'UTF-8')    #   Ø
f__encode.call(0xdC,'UTF-8')    #   Ü
f__encode.call(0xdE,'UTF-8')    #   Þ
f__encode.call(0xdF,'UTF-8')    #   ß

f__encode.call(0xe4,'UTF-8')    #   ä
f__encode.call(0xe6,'UTF-8')    #   æ

f__encode.call(0xf0,'UTF-8')    #   ð
f__encode.call(0xf6,'UTF-8')    #   ö
f__encode.call(0xf7,'UTF-8')    #   ÷
f__encode.call(0xf8,'UTF-8')    #   ø
f__encode.call(0xfc,'UTF-8')    #   ü
f__encode.call(0xfe,'UTF-8')    #   þ

#   greek chars
f__encode.call(0x393,'UTF-8')   #   Gamma   :Γ
f__encode.call(0x394,'UTF-8')   #   &Delta  :Δ
f__encode.call(0x398,'UTF-8')   #   &Theta  :Θ
f__encode.call(0x39B,'UTF-8')   #   &Lambda :Λ
f__encode.call(0x3a9,'UTF-8')   #   Omega   :Ω
f__encode.call(0x3a6,'UTF-8')   #   Phi     :Φ
f__encode.call(0x3a8,'UTF-8')   #   Psi     :Ψ
f__encode.call(0x3b1,'UTF-8')   #   alpha   :α
f__encode.call(0x3b2,'UTF-8')   #   beta    :β
f__encode.call(0x3b3,'UTF-8')   #   gamma   :γ
f__encode.call(0x3b4,'UTF-8')   #   delta   :δ
f__encode.call(0x3b5,'UTF-8')   #   epsilon :ε
f__encode.call(0x3b6,'UTF-8')   #   zeta    :ζ
f__encode.call(0x3b7,'UTF-8')   #   eta     :η
f__encode.call(0x3b8,'UTF-8')   #   theta   :θ
f__encode.call(0x3b9,'UTF-8')   #   jota    :ι
f__encode.call(0x3ba,'UTF-8')   #   kappa   :κ
f__encode.call(0x3bb,'UTF-8')   #   lambda  :λ
f__encode.call(0x3bc,'UTF-8')   #   my      :μ
f__encode.call(0x3bd,'UTF-8')   #   nu      :ν
f__encode.call(0x3be,'UTF-8')   #   xi      :ξ
f__encode.call(0x3c0,'UTF-8')   #   pi      :π
f__encode.call(0x3c2,'UTF-8')   #   sigma   :σ
f__encode.call(0x3c4,'UTF-8')   #   tau     :τ
f__encode.call(0x3c6,'UTF-8')   #   phi     :φ
f__encode.call(0x3c8,'UTF-8')   #   psi     :ψ
f__encode.call(0x3c9,'UTF-8')   #   omega   :ω


#   === c2i
$m.f_thm("c2i",true,__LINE__)
#   the reverse function is also valid

f__decode = lambda { |c|
    #   c=i.chr(Encoding::ISO_8859_1) # alternativ syntax
    #   c=i.chr(Encoding::UTF_8)
    i   =   c.ord()
    s   =   sprintf("ord('%c') =: <0x%x>",c,i);
    $m.f_puts s
}
f__decode.call('Ø')     #   0xd8
f__decode.call('Ω')     #   0x3a9
f__decode.call('λ')     #   0x3bb
f__decode.call('σ')     #   0x3c2
f__decode.call('ω')     #   0x3c9

#   !THM: encodings
$m.f_thm("char encoding ASCII")
#   puts shows back-slash notations like '\\a' as '\a'
sHere =<<MyHere
    encoding notation in strings
    backslash       hexadecimal     description
    \\a              0x07            Bell or alert
    \\b              0x08            Backspace
    \\cx                             Control-x
    \\C-x                            Control-x
    \\e              0x1b            Escape
    \\f              0x0c            Formfeed
    \\M-\\C-x                         Meta-Control-x
    \\n              0x0a            Newline
    \\r              0x0d            Carriage return
    \\s              0x20            Space
    \\t              0x09            Tab
    \\v              0x0b            Vertical tab
    \\nn                             number:Octal n:={0-7}
    \\xnn                            number:Hex n:={0-9,a-f,A-F}
MyHere
$m.f_puts("<<< ASCII :\n" + sHere.to_s)

#
#   print a 3-space Text with...
#

#   'backslash-notation'
$m.f_thm("examples with backslash-notation",true)
i=1234
$m.f_puts("Text1:\s\s\s:#{i}")          # => Text1:   :1234
#   hex-output::    \x20=>' ',\x32=>'2'
i=5678
$m.f_puts("Text\x32:\x20\x20\x20:#{i}") # => Text2:   :5678
#   octal-output::  \63=>'3' \40=>' '(space)
i=9321
$m.f_puts("Text\63:\40\40\40:#{i}")     # => Text3:   :9321

#   'hexadecimal-notation'
$m.f_thm("example with hexadecimal-notation",true)
i=4711
c=0x20      # print it at char, not as digit
$m.f_inf("i='#{i}',c='#{c}'");
$m.f_puts sprintf("Text4:%0c%0c%0c:%d",c,c,c,i)

#   !THM: convert numbers TO Strings/NumeralSystems
$m.f_thm("converting numbers")

#   kernel modes: 'Integer','Float' - they test and check
$m.f_thm("kernel modes:Integer,Float",true,__LINE__)
#   s2i
s="123"; i=Integer(s); $m.f_puts sprintf("Integer(<'%s'>)=>%d",s,i)   # 123
s="-3.14"; f=Float(s); $m.f_puts sprintf("Float(<'%s'>)=>%f",s,f)     # -3.140000
#   Integer(sBase)
s="0b111";x=Integer(s); $m.f_puts sprintf("Integer(<'%s'>)=>%d",s,x)  # 7
s="0o125";x=Integer(s); $m.f_puts sprintf("Integer(<'%s'>)=>%d",s,x)  # 85
s="0xAbc";x=Integer(s); $m.f_puts sprintf("Integer(<'%s'>)=>%d",s,x)  # 2748

#   string modes: 'to_i','to_f'
$m.f_thm("string modes:to_i,to_f",true,__LINE__)
s="123"; i=s.to_i; $m.f_puts sprintf("<'%s'>.to_i=>%d",s,i) # 123
s="-3.14"; f=s.to_f; $m.f_puts sprintf("<'%s'>.to_f=>%f",s,f) # -3.140000
s="1001";b=2;i=s.to_i(b); $m.f_puts sprintf("<'%s'>.to_i(<'%d'>)=>%d",s,b,i) #9
s="175";b=8;i=s.to_i(b); $m.f_puts sprintf("<'%s'>.to_i(<'%d'>)=>%d",s,b,i) #125
s="aE1";b=16;i=s.to_i(b); $m.f_puts sprintf("<'%s'>.to_i(<'%d'>)=>%d",s,b,i) #2785
s="341";b=5;i=s.to_i(b); $m.f_puts sprintf("<'%s'>.to_i(<'%d'>)=>%d",s,b,i) #96

# exit
$m.f_end()
