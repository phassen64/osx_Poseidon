=begin
    OPERATORs
        http://ruby-doc.org/core-2.1.3/doc/syntax/precedence_rdoc.html
            !, ~, unary +
            **
            unary -
            *, /, %
            +, -
            <<, >>
            &
            |, ^
            >, >=, <, <=
            <=>, ==, ===, !=, =~, !~
            &&
            ||
            .., ...
            ?, :    # ternary
            =, +=, -=
            defined?
            not
            or, and
            { }
=end
#!$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

require_relative "TUT.inc"
$m.f_hdr("operator",__FILE__)

#   show a text
$m.f_thm("Operator overview")
s = <<MyOp
Ranges
    ::              Scope
    []              index
    .. ...          inclusive [A..B] or exclusive [A...B]
Math:
    !               Unary NOT
    + -             signed
    + - * / %       add,minus,mul,division,mod
    **              Exponential
Compare:
    > <             greater,smaller
    >= <=           greater_or_equal
    == !=           equal, not_equal
    <=>             space-ship-op: => smaller:-1,equal:0,bigger:1
   ===              inside set
Boolean:
    && ||           BOOLEAN AND,OR
Script control statements:
    and or          ... only if (a==<true>) run b
    not             ... not (a)
    ?:              ternary
Bit Operators:
    << >>           bitwise shift-left,shift-right
    & | ^           bitwise AND,OR,XOR
    ~               NOR
REGEX
     =~  !~         REGEX equal, notEqual
MyOp
$m.f_put(s)

#
#   THM:scope and Ranges and Symbols
#
$m.f_thm("scopes,ranges and symbols {::,..,...,[]")

#
#   +   SCOPE {::}
#
$m.f_thm("module::",true,__LINE__)
#   access between modules
I=10
module M
    i=4     # wrong
    I=3     # capital-letter 'I' and not 'i'
end
i=::I;  $m.f_inf("i=M::I =: '#{i}'");   # 10
i=M::I; $m.f_inf("i=::I  =: '#{M::I}'") # 3
#   access between classes
$m.f_thm("class::",true,__LINE__)
S="peter"
class CCls
    S="crazy!"  # varName 'S' is big-letter!
    s="NotWorkingWithSmallLetterVariables"
    s=::S       # call upper-scope
    $m.f_inf("::S =: '#{s}'")       # peter
end
s=CCls::S; $m.f_inf("CCls::S =: '#{s}'") # crazy!

#
#   +   INDEX[]
#
$m.f_thm("index:{'[]'}",true,__LINE__)
a=[1,2,3,4] ; $m.f_puts "a:=['1,2,3,4']' => <#{a}>"  # ARRAY
x=a.class;    $m.f_inf  "a.class  =: #{x}"

#
#   +   Symbols
#
$m.f_thm("Symbols",true,__LINE__)
y = :foobar;    $m.f_puts("Symbol y: '#{y}'")   # define symbol
s = y.to_s;     $m.f_puts("String s: '#{s}'")   # convert symbol into str
x = s.to_sym;   $m.f_puts("Symbol x: '#{x}'")   # convert symbol into str

#
#   +   RANGE
#
$m.f_thm("RANGE: {'..'} vs {'...'}",true,__LINE__)
a=[1,2,3,4,5,6,7,8,9]; i=2;j=7
y=a.slice(i..j)  ;  $m.f_puts("<#{a}>.slice(#{i}..#{j})     => <#{y}>")
y=a.slice(i...j)  ; $m.f_puts("<#{a}>.slice(#{i}...#{j})    => <#{y}>")


#
#   THM:math : +,-,*,/,%,**
#
$m.f_thm("math")

$m.f_thm("calc:{+,-,*,/,%,**}",true,__LINE__)
a=9; b=2; $m.f_inf("use a:=#{a},b:=#{b}")
y=a+b; $m.f_puts(sprintf("%d + %d ==: %d",a,b,y));  # 12
y=a-b; $m.f_puts(sprintf("%d - %d ==: %d",a,b,y));  # 8
y=a*b; $m.f_puts(sprintf("%d * %d ==: %d",a,b,y));  # 20
y=a/b; $m.f_puts(sprintf("%d / %d ==: %f",a,b,y));  #  4.000000
y=a%b; $m.f_puts("#{a} '%' #{b} ==: #{y}");         # 1
y=a**b;$m.f_puts(sprintf("%d ** %d ==: %d",a,b,y));    # 32

$m.f_thm("signed:{+,-}",true,__LINE__)
a=+9; b=-2; $m.f_inf("use a:=#{a},b:=#{b}")
y=a+b; $m.f_puts(sprintf("+%d + %d ==: %d",a,b,y));  # 12
y=a-b; $m.f_puts(sprintf("+%d - %d ==: %d",a,b,y));  # 8

#
#   THM:COMPARE
#

$m.f_thm("compare {==,!=,===,>,<,>=,<=,<=>}")

#
#   COMPARE: equal(=) vs NotEqual(!=)
#
$m.f_thm("EQ:'==',NEQ:'!='",true,__LINE__)
a=4; b=4;
$m.f_inf("use a:=#{a},b:=#{b}")
y=a==b;  $m.f_puts("a:#{a} ==  b:#{b} => #{y}");    # true
y=a!=b;  $m.f_puts("a:#{a} !=  b:#{b} => #{y}");    # false
a="peter"; b="otto";
y=a==b;  $m.f_puts("a:'#{a}' ==  b:'#{b}' => #{y}");    # true
y=a!=b;  $m.f_puts("a:'#{a}' !=  b:'#{b}' => #{y}");    # false

#
#   COMPARE: (< , > , <=, >=)
#
$m.f_thm("GT,LT,GE,LE:'>','<','>=','<='",true,__LINE__)
a=1; b=4; c=1;
$m.f_inf("use a:=#{a},b:=#{b},c=#{c}")
y=a<b;  $m.f_puts("#{a} < #{b} => #{y}");
y=a>b;  $m.f_puts("#{a} > #{b} => #{y}");
y=a<=b; $m.f_puts("#{a} <= #{b} => #{y}");
y=a>=b; $m.f_puts("#{a} >= #{b} => #{y}");

#
#   COMPARE: with spaceship-OP (<=>)
#
a=4; b=3; z=3;
$m.f_thm("spaceship:'<=>'",true,__LINE__)
$m.f_inf("use a:=#{a},b:=#{b},z=#{z}")
i=10; j=i-3; k=i+2; z=i
$m.f_puts "y:=(a<=>b) means a<b:y=-1,a>b:y=1;a=b:y=0"
y = i <=> j; $m.f_puts "<#{i}> <=> <#{j}> := \t#{y}"   # 1
y = i <=> k; $m.f_puts "<#{i}> <=> <#{k}> := \t#{y}"   # -1
y = i <=> z; $m.f_puts "<#{i}> <=> <#{z}> := \t#{y}"   # 0

#
#   COMPARE: set INSIDE (===)
#
#   inside (for sets)
# An alternative formulation is  :
#   "If a described a set, would b be a member of that set?"
# y=(a..b) === z
$m.f_thm("set inside with '==='",true,__LINE__)
y=a==b;  $m.f_puts("a:#{a} ==  b:#{b} => #{y}");
a=1; b=4; v=3; w=6; x=4
y =(a..b)  === v ; $m.f_puts("(#{a}..#{b}) === #{v}    \t=> #{y}"); # true
y = (a..b)  === w ; $m.f_puts("(#{a}..#{b}) === #{w}    \t=> #{y}"); # false
y = (a..b)   ===  x ; $m.f_puts("(#{a}..#{b}) === #{x}  \t=> #{y}"); # true
y=(a...b)  === x ; $m.f_puts("(#{a}...#{b}) === #{x}  \t=> #{y}"); # false; excl.last element


#
#   THM:BOOLEAN : (&&,||) and (!) and simulate:(XOR)
#
$m.f_thm("boolean: AND/OR/NOT/(XOR): '&&','||','!'}")
a=true; b=false;
y=a&&b; $m.f_puts("a:#{a} 'and' b:#{b} => #{y}"); # true
y=a||b; $m.f_puts("a:#{a} 'or' b:#{b} => #{y}"); # false
#   use !
y=!a||b; $m.f_puts("!a:#{a} 'or' b:#{b} => #{y}"); # false
#   simulate boolean-XOR
$m.f_inf("use:a:#{a},b:#{b}; f(y)=(a&&!b)||(!a&&b")
a=true;  b=true ; y=(a&&!b)||(!a&&b); $m.f_puts("y(#{a},#{b}}=:#{y}"); # F
a=true ; b=false; y=(a&&!b)||(!a&&b); $m.f_puts("y(#{a},#{b}}=:#{y}"); # T
a=false; b=true ; y=(a&&!b)||(!a&&b); $m.f_puts("y(#{a},#{b}}=:#{y}"); # T
a=false; b=false; y=(a&&!b)||(!a&&b); $m.f_puts("y(#{a},#{b}}=:#{y}"); # F
#   multiline - endOf line is operator '||'
a=false; b=false; y=(a&&!b) ||
                  (!a&&b)
$m.f_puts("y2(#{a},#{b}}=:#{y}"); # F

#
#   THM:Script-Control
#

#   script AND/OR - very different from above
#   (a) and (b) => (b) is only calculated, if (a) is true
#   (a) or  (b) => (b) is only calculated, if (a) is true
$m.f_thm("script-control")
$m.f_thm("'and','or'}",true,__LINE__)
a=10;b=77;z=10
$m.f_inf("a:#{a},b:#{b},z:#{z}",true)
(a > z)  and b=false;  $m.f_puts("(a>z) and (b=false) => b==:#{b}"); # 77
(a >= z) and b=false;  $m.f_puts("(a>=z) and (b=false) => b==:#{b}"); # false
(a > z)  or  b=z;      $m.f_puts("(a>z) or (b=z)     => b==:#{b}"); # 10
(a < z)  or  b=true;   $m.f_puts("(a<z) or (b=true)  => b==:#{b}"); # true

#    ternary operator
$m.f_thm("a?b:c",true)
a=10;b=77;z=10;$m.f_inf("a:#{a},b:#{b},z:#{z}",true)
(a < b) ? a=true : b=false; $m.f_puts("(a<b) ? x=true :x=false => x==:#{x}");

#
#   THM:bit-Operators
#
$m.f_thm("bit-Operators")
#   op:{>> <<}
$m.f_thm("shift <<,>>",true,__LINE__)
i=0xFF; j=3;
x= i >> j; $m.f_puts(sprintf("%0b(b) >> %0d => %0b(b)",i,j,x));
x= i << j; $m.f_puts(sprintf("%0b(b) << %0d => %0b(b)",i,j,x));
#   op:{&,|,^}
$m.f_thm("logical AND/OR/XOR={'&','|','^'}",true,__LINE__)
i=0xA5; j=7;
x=i&j; $m.f_puts(sprintf("%0b(b) & %0b(b) => %0b(b)",i,j,x));
x=i|j; $m.f_puts(sprintf("%0b(b) | %0b(b) => %0b(b)",i,j,x));
x=i^j; $m.f_puts(sprintf("%0b(b) ^ %0b(b) => %0b(b)",i,j,x));
$m.f_thm("NOT ~",true,__LINE__)
i=0xFC; j=7;
y=(~i); $m.f_puts(sprintf("~<%0x(x)=%0b(b)> => <%0x(x)=%0b(b)>",i,i,y,y));
# ..f03=..100000011(b) ??? es sollte nur 0000.0011(b) sein

#
#   THM:REGEX
#
$m.f_thm("REGEX")
s="ABCDEFGHIJ"; $m.f_inf("s:'#{s}'")
#   seek with '=~'
$m.f_thm("'=~'",true,__LINE__)
y = (s =~ /B/) ; $m.f_puts "s=~/B/ =: '#{y}'" # pos=1
y = (s =~ /J/) ; $m.f_puts "s=~/J/ =: '#{y}'" # pos=9
y = (s =~ /X/) ; $m.f_puts "s=~/B/ =: '#{y}'" # ' ' : sollte false sein

$m.f_thm("'!~'",true,__LINE__)
y = (s !~ /A/) ; $m.f_puts "s!~/A/ =: '#{y}'" # false
y = (s !~ /J/) ; $m.f_puts "s!~/J/ =: '#{y}'" # true
y = (s !~ /X/) ; $m.f_puts "s!~/X/ =: '#{y}'" # true

$m.f_end()
