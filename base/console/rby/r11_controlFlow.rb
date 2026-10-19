=begin
    control flow
=end
#!$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

require_relative "TUT.inc"
$m.f_hdr("control_flow",__FILE__)

#   overview
$m.f_thm("Control Flow overview")
s = <<MyCF
Control Flow overview ==START
    boolean-like
        if-then-elsif-else-end
        unless
        case-when-else-end
    ternary
        x ? a : b
    Script control statements:
        and or          see chapter [operator]
        ?:              see chapter [operator]
    loops
        loop do...end
        for x in i..j..end
        while...end
        until...end
        a.each{}, a.each_index{}
        i.upto(j){}, i.downto(j){},
        i.times{}
        i.step(a,n){}
    stop-loops with
        break if <>
        break <text> if <>
        next if <>
        redo if <>
===END
MyCF
$m.f_put(s)

#
#   THM:if
#
$m.f_thm("if")
a=5;b=10; $m.f_puts("use:   a:#{a},b:#{b}");

#   simple if
$m.f_thm("'if'}",true)
if (a<b)
    $m.f_puts "if (a<b) : TRUE"
end

#   if-else
$m.f_thm("'if-else'}",true)
if (a>=b)
    $m.f_puts "if    (a>=b) : TRUE"
else
    $m.f_puts "else  (a<b)  : TRUE"
end

#   if-elsif-else
$m.f_thm("'if-elsif-else'}",true)
if (a>b)
    $m.f_puts "if    (a>b)  : TRUE"
elsif (a<b)
    $m.f_puts "elsif (a<b)  : TRUE"
else
    $m.f_puts "else  (a==b) : TRUE"
end

#
#   THM:ternary Operator x ? a : b
#
$m.f_thm("ternary : x ? a : b}",true)
(a<b) ? ($m.f_puts "a<b is TRUE") : ($m.f_puts "a<b is FALSE")  # TRUE

#
#   THM:unless (negative 'if')
#
$m.f_thm("unless")
unless (a>b)
    $m.f_puts "unless (a>b)  : TRUE"
else
    $m.f_puts "unless (a>b)  : FALSE"
end

#
#   THM:case
#
$m.f_thm("case")
a=5;b=10;c=4; $m.f_inf("use:   a:#{a},b:#{b},c:#{c}");

$m.f_thm("case (INT)",true)
case (a)
when 1
    $m.f_puts "when  (a==1) : TRUE"
when 5
    $m.f_puts "when  (a==5) : TRUE"
else
    $m.f_puts "else   (a?)  : TRUE"
end

s="ABC"
$m.f_thm("case (STRING)",true)
case s
when "XYZ"
    $m.f_puts "when  (s==#{s}:1) : TRUE"
when "ABC"
    $m.f_puts "when  (s==#{s}:2) : TRUE"
end

#
#   THM:loop 'loop'
#
$m.f_thm("loop:'loop'")
a = [ 'Anton', 'Berta', 'Cleo', 'Dorothea' , 'Emil']
$m.f_inf("a:#{a}",true)

#   loop do - with 'break if'
$m.f_thm("loop do",true)
i=0
loop do
   $m.f_put a[i].to_s + ";"
   i+=1
   break if (i==3)
end
$m.f_puts ""
#   =>  Anton;Berta;Cleo;

#   loop do - with 'break if' and 'next if'
$m.f_thm("loop do : with 'next if' and overflow",true)
i=-1
loop do
    i+=1
    next if  i==2
    $m.f_put "[#{i}]:" + a[i].to_s + ";"
    break if i>=7   # loop l?uft aus dem Array - NIL Eintr?ge
end
$m.f_puts ""
#   =>  [0]:Anton;[1]:Berta;[3]:Dorothea;[4]:Emil;[5]:;[6]:;[7]:;

#   loop do - with 'break' TEXT-OUTPUT inside puts()
$m.f_thm("loop do : with puts(TEXT)",true)
i=-1
$m.f_puts (
    loop do
        i+=1
        $m.f_put "[#{i}]:" + a[i].to_s + ";"
        break "&&& 'TEXT:END OF OUTPUT'" if  i>3
    end
)
$m.f_puts ""
#   =>  [0]:Anton;[1]:Berta;[2]:Cleo;[3]:Dorothea;[4]:Emil;&&& 'TEXT:END OF OUTPUT'

#
#   THM:loop 'while' 'until'
#
a = ['Anton', 'Berta', 'Cleo', 'Dorothea' , 'Emil']
$m.f_inf("use a:#{a}",true)

$m.f_thm("loop:'while','repeat'")

#   while
$m.f_thm("'while'",true)
i=0
while i<3
    $m.f_put "[#{i}]:" + a[i].to_s + ";"
    i+=1
end
$m.f_puts ""
#   =>    [0]:Anton;[1]:Berta;[2]:Cleo;

#   until
$m.f_thm("'until'",true)
i=0
until i>5
    $m.f_put "[#{i}]:" + a[i].to_s + ";"
    i+=1
    redo if i==2
end
$m.f_puts ""

#   =>  [0]:Anton;[1]:Berta;[2]:Cleo;[3]:Dorothea;[4]:Emil;[5]:;

#
#   alternative Syntax
#
$m.f_thm("alternative syntax")

i=-1;j=3;
$m.f_inf("use i:#{i},j:#{j}")
$m.f_thm("...while i<j",true)
$m.f_put("[#{i+=1}]:" + a[i].to_s + ";") while i<j;
$m.f_puts ""
#   =>  [0]:Anton;[1]:Berta;[2]:Cleo;[3]:Dorothea;

i=-1;j=3;
$m.f_thm("...until i>=j",true)
$m.f_put "[#{i+=1}]:" + a[i].to_s + ";"  until i>=j
$m.f_puts ""
#   =>  [0]:Anton;[1]:Berta;[2]:Cleo;[3]:Dorothea;

i=-1;j=3; # starting negative
$m.f_thm("... begin end while i<j",true)
begin
    $m.f_put "[#{i}]:" + a[i].to_s + ";"
    i+=1
end while i<j
$m.f_puts ""
#   =>  [-1]:Emil;[0]:Anton;[1]:Berta;[2]:Cleo;

#
#   THM:for
#
$m.f_thm("for i in a..b")
i=1;j=3; $m.f_inf("use i:#{i},j:#{j}")
for x in i..j
    $m.f_put "[#{x}]:" + a[x].to_s + ";"
end
$m.f_puts ""
#   =>  [1]:Berta;[2]:Cleo;[3]:Dorothea;


#
#   THM:each - each Index
#
$m.f_thm("each && eachIndex")
$m.f_inf("use a:#{a}",true)

#   each
$m.f_thm("each",true)
$m.f_puts "a.each {...} =:"
a.each {
    |e| $m.f_put "[#{i}]:" + e.to_s + ";"
    i+=1
}
$m.f_puts ""
#   =>  [1]:Anton;[2]:Berta;[3]:Cleo;[4]:Dorothea;[5]:Emil;

#   each_index
$m.f_thm("each_index",true)
$m.f_puts "a.each_index {...} =:"
a.each_index {
    |i| $m.f_put "[#{i}]:" + a[i].to_s + ";"
}
$m.f_puts ""
#   =>  [0]:Anton;[1]:Berta;[2]:Cleo;[3]:Dorothea;[4]:Emil;

#
#   THM:times
#
$m.f_thm("times")
i=3; $m.f_puts "#{i}.times {...} =:"
i.times {
    |x| $m.f_put "[#{x}]:" + a[x].to_s + ";"
}
$m.f_puts ""
#   =>  [0]:Anton;[1]:Berta;[2]:Cleo;

#
#   upto/downto
#

$m.f_thm("upto/downto/step")

#   upto
$m.f_thm("upto",true)
i=1; j=3; $m.f_puts "#{i}.upto(#{j})"
i.upto(j) {
    |x| $m.f_put "[#{x}]:" + a[x].to_s + ";"
}
$m.f_puts ""
#   =>  [1]:Berta;[2]:Cleo;[3]:Dorothea;

#   downto
$m.f_thm("downto",true)
i=5; j=2; $m.f_puts "#{i}.downto(#{j})"
i.downto(j) {
    |x| $m.f_put "[#{x}]:" + a[x].to_s + ";"
}
$m.f_puts ""
#   =>  [5]:;[4]:Emil;[3]:Dorothea;[2]:Cleo;

#   step
#   like programLanguage BASIC "for" with STEP
#       for x:=v to i step j do ...end
$m.f_thm("step",true)
v=1; i=5; j=2; $m.f_puts "#{v}.step(#{i},#{j})"
v.step(i,j) {   # j=stepSize
    |x| $m.f_put "[#{x}]:" + a[x].to_s + ";"
}
$m.f_puts ""
#   =>  [1]:Berta;[3]:Dorothea;[5]:;

$m.f_end()
