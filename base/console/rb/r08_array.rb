=begin
    ARRAYs
    +   create,define
    +   add 1 only 1
    +   read
    +   change : insert,add,...
    +   copy array : clone vs duplicate
    +   selecting
    +   array class-extensions
    +   array repeater *(...)
    SET's
    +   new,add,merge,subset?
=end
#!$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

require_relative "TUT.inc"
$m.f_hdr("Array",__FILE__)

#
#   THM:create arrays
#
$m.f_thm("create arrays @:[#{__LINE__}]")
#   use []

$m.f_thm("using class method '[]'",true)
a = [] ;                $m.f_puts "a[] =: <#{a}> #empty"            # empty
a = [1,2,3,4] ; $m.f_puts "a[1,2,3] =: <#{a}>"  # with values

$m.f_thm("use 'Array[]'",true)
a = Array.[](1,2,3);    $m.f_puts "a=Array.[](1,2,3) =: <#{a}>"
a = Array[1,2,3];       $m.f_puts "a=Array[1,2,3] =: <#{a}>"

$m.f_thm("a.new",true)
i = 5
a = Array.new   ; $m.f_puts "a = Array.new =: <#{a}>"
a = Array.new(i); $m.f_puts "a = Array.new(#{i}) =: <#{a}>"

#
#   THM:define simple arrays
#
$m.f_thm("define @:[#{__LINE__}]")
$m.f_thm("integer arrays",true)
aI = [1,10,3,-1,5]; $m.f_puts "aI:<#{aI}>"
$m.f_thm("string arrays",true)
aS = ["Peter","Paul",'Mary'] ; $m.f_puts "aS:<#{aS}>"
$m.f_thm("float arrays",true)
aF = [1.2, 5.6, -1.2]; $m.f_puts"aF:<#{aF}>"
#   using symbol
$m.f_thm("define an array using 'syntax sugar'",true)
a = %w[A B C]; $m.f_puts "%w[A,B,C] =: <#{a}>"
a = %w(A B C); $m.f_puts "%w(A,B,C) =: <#{a}>"
a = %w/A B C/; $m.f_puts "%w/A,B,C/ =: <#{a}>"

#
#   THM:add 1 only
#

$m.f_thm("add 1 elememt @:[#{__LINE__}]")
a = [1,10,3,-1,5];  $m.f_puts "a:<#{a}>"
x=2; a+=[x];        $m.f_puts "a+=[#{x}] => a:<#{a}>"

#
#   THM:mixed arrays and multi-dimensional arrays
#
$m.f_thm("mixed arrays")

#   type-mixed array
$m.f_thm("type-mixed",true)
a = [1,"Hello",3,"Peter",4.3, true]; $m.f_puts "a:<#{a}>"

#   type-mixed and combined and combined
$m.f_thm("type-mixed and combined",true)
a = [aI, aS, aF]; $m.f_puts "a:=[aI, aS, aF] =:<#{a}>"

#   multi-dimensional
$m.f_thm("multi-dimensional",true)
aD = Array.new(1) { Array.new(2) { Array.new(3) } }
aD[0][0][0] = 11; $m.f_puts "a1=:<#{aD}>" # first element
aD[0][1][1] = 33; $m.f_puts "a2=:<#{aD}>" # middle element
aD[0][1][2] = 77; $m.f_puts "a3=:<#{aD}>" # last element
#   aX = [0,1,2,3,4,5] #   aY = [0,100,200,300,400,500]
#   aZ = [0,-5,-10,-15]

#   combine arrays and flatten them
a = [aI, aS, aF];
$m.f_thm("un-multitype it: a.flatten[!]",true)
$m.f_inf("aCombi=:<#{a}>")
#   make array flat
x = a.flatten; $m.f_puts("a.flatten => '#{x}'")
$m.f_inf("a=:<#{a}> : unchanged")
x = a.flatten!; $m.f_puts("a.flatten => '#{x}'")
$m.f_inf("a=:<#{a}> : changed!")

$m.f_thm("repeat and shuffle arrays",true)
a = [*('A'..'C')]; puts a       # A B C
a = [*('A'..'C'),*('1'..'3')].join(); $m.f_puts a        # ABC123
a = [*('A'..'C'),*('1'..'3')].shuffle.join; $m.f_puts a  # 'ABC123'||'2AC31B' ...
#   shuffle '3' elements at Pos '0'
a = [*('A'..'C'),*('1'..'3')].shuffle[0,3].join; $m.f_puts a  # '2AC','CBA' ...
#   for passwords
a = [*('A'..'Z'),*('0'..'9')].shuffle[0,6].join; $m.f_puts a  # 'A145BZ'
a = [*('A'..'Z'),*('0'..'9')].shuffle[0,6].join; $m.f_puts a  # 'A145BZ'
a = [*('A'..'Z'),*('0'..'9')].shuffle[0,6].join; $m.f_puts a  # 'A145BZ'


#   ----------------------------------------------------------------------------
#   read arrays
#   ----------------------------------------------------------------------------

#
#   THM:array access or check
#
$m.f_thm("access(readOnly) @:[#{__LINE__}]")
a = [1,10,-3.7,2.8,6,-4,-5,99]
b = [10,-4,-5]
i = 3; j = -4
$m.f_inf "use a:<#{a}>; b=<#b>"

#   direct access
$m.f_thm("directly",true)
$m.f_puts "<#{a}> [<#{i}>]      := " + "'"  + a[i].to_s  + "'"  + ";"
$m.f_puts "<#{a}> [-1]          := " + "'"  + a[-1].to_s  + "'"  + ";"
$m.f_puts "<#{a}> [-#{i}]       := " + "'"  + a[-i].to_s  + "'"  + ";"
$m.f_puts "<#{a}> [1,#{i}]      := " + a[1,i].to_s   + ";"
$m.f_puts "<#{a}> [2..#{i}]     := " + a[2..i].to_s  + ";"
$m.f_puts "<#{a}> [1..-#{i}]    := " + a[1..-i].to_s  + ";"

#   access by a position method
$m.f_thm("by position methods : at,fetch,first",true)
i=3
#   at,fetch,first,last
x=a.at(i)       ; $m.f_puts "<#{a}>.at[#{i}]      =: '#{x}'"
x=a.at(1+i)     ; $m.f_puts "<#{a}>.at[1+#{i}]    =: '#{x}'"   # leer- not nil
x=a.fetch(i-1)  ; $m.f_puts "<#{a}>.fetch[#{i-1}] =: '#{x}'"
x=a.first       ; $m.f_puts "<#{a}>.first         =: '#{x}'"
x=a.last        ; $m.f_puts "<#{a}>.last          =: '#{x}'"

#   take,drop
$m.f_thm("by position get N elements: take,drop",true)
x=a.take(i)     ; $m.f_puts "<#{a}>.take(#{i})    =: '#{x}'"    # get a[0]...a[N-1]
x=a.drop(i)     ; $m.f_puts "<#{a}>.drop(#{i})    =: '#{x}'"    # get a[N]...a[max]

#   max,min
a = [1,10,-3.7,2.8,6,-4,-5,99]
$m.f_thm("by MAX/MIN",true)
x=a.max     ; $m.f_puts "<#{a}>.max    =: '#{x}'"    # '99'
x=a.min     ; $m.f_puts "<#{a}>.min    =: '#{x}'"    # '-5'
#   extended with '<=>'
x=a.max{ |i,j| i<=>j }; $m.f_puts "a.max    := '#{x}'"

#   access anyone
$m.f_thm("by random methods : sample",true)
x=a.sample; $m.f_puts "<#{a}>.sample 1  =: '#{x}'"  # random 1 element
x=a.sample; $m.f_puts "<#{a}>.sample 2  =: '#{x}'"

#   calc and check
$m.f_thm("calc size and check array : length,size,count",true)
x=a.length; $m.f_puts "<#{a}>.length    =: '#{x}'"
x=a.size;   $m.f_puts "<#{a}>.size      =: '#{x}'"
x=a.count;  $m.f_puts "<#{a}>.count     =: '#{x}'"

$m.f_thm("check array : empty?,include?",true)
x=a.empty? ;    $m.f_puts "<#{a}>.empty?            =: '#{x}'"
x=a.include?(i);$m.f_puts "<#{a}>.include?(#{i})    =: '#{x}'"
x=a.include?(j);$m.f_puts "<#{a}>.include?(#{j})    =: '#{x}'"

$m.f_thm("check if array A includes array B or vice versa",true)
a.sort!
b.sort!
c=a&b   # intersection
x=(c == b);$m.f_puts "<#{a}>.include?(#{b})(a&b==b)    =: '#{x}'"
c=b&a
x=(c == a);$m.f_puts "<#{b}>.include?(#{a})(b&a==a)    =: '#{x}'"

#   compare arrays
$m.f_thm("compare arrays : use sort",true)
a1=[1,-2,3]; a2=[-2,3,1]; $m.f_puts("a1='#{a1}';a2='#{a2}'")
bRc = a1==a2;       $m.f_puts("a1==a2       => '#{bRc}'")   # false
bRc = a1.eql? a2;   $m.f_puts("a1.eql? a2   => '#{bRc}'")   # false
bRc = a1.sort.eql? a2.sort;   $m.f_puts("a1.sort.eql? a2.sort   => '#{bRc}'") # true!

#
#   THM:handle arrays
#
$m.f_thm("handle arrays (readOnly) @:[#{__LINE__}]")
a = [1,10,-3.7,2.8,6,-4,99]

#   sort
$m.f_thm("sort",true)
$m.f_inf "use a:<#{a}>"
x=a.sort; $m.f_puts "<#{a}>.sort    := '#{x}' "

#   random
$m.f_thm("shuffle",true)
x=a.shuffle ; $m.f_puts "<#{a}>.shuffle  1    := '#{x}'"
x=a.shuffle ; $m.f_puts "<#{a}>.shuffle  2    := '#{x}'"    # random arrays
$m.f_inf "=> a:<#{a}>:unchanged",C_COLOR_CYAN

#   random2
$m.f_thm("shuffle!",true)
a = [1,10,-3.7,2.8,6,-4,99]
$m.f_puts "<#{a}>.shuffle!..."
a.shuffle! ; $m.f_puts "a='#{a}'"

#
#   THM:show/loop arrays
#
$m.f_thm("show(loop) array @:[#{__LINE__}]")
a = [1,2,3,4,5]
$m.f_inf "use a:<#{a}>"

#   each
$m.f_thm("each",true)
s = ""
a = ['A','B','C']
s = a.each { |e| $m.f_print "=#{e}=;" }    # always with newline
#   rmv line separators
$m.f_puts "."
sTmp=s.inspect
$m.f_inf "s.inspect=:<#{sTmp}>",C_COLOR_CYAN
#   <<< s.inspect=:<["A", "B", "C"]>

#   each with index
$m.f_thm("each with index",true)
a = ["Hello","Peter","NUE"]
$m.f_inf "use a:<#{a}>"
s = a.each_with_index { |e,i| $m.f_print "{#{i}:=#{e}};" }
$m.f_puts "."
sTmp=s.inspect
$m.f_inf "s.inspect=:<#{sTmp}>",C_COLOR_CYAN
#   <<< s.inspect=:<["Hello", "Peter", "NUE"]>

#   reverse
$m.f_thm("loop each reverse",true)
a.reverse_each { |e| $m.f_print "#{e}," }
$m.f_puts "."

#  !PHA : 'reverse_each_with_index' not exists

#   ----------------------------------------------------------------------------
#   change arrays
#   ----------------------------------------------------------------------------

#
#   THM: concat arrays (desctructive!)
#
$m.f_thm("concat arrays")
$m.f_thm("with '<<'",true)
a = [1,2,3,4,5]; b=['a','b','c']; c=true
$m.f_inf "use a:<#{a}>;b:<#{b}>;c:<#{c}>"

#   a<<b
a << c; $m.f_puts "a << c =: '#{a}'"  # '[1, 2, 3, 4, 5, true]'
a = [1,2,3,4,5]; b=['a','b','c']; c=true
a << b; $m.f_puts "a << b =: '#{a}'"  # '[1, 2, 3, 4, 5, ["a", "b", "c"]]'
a = [1,2,3,4,5]; b=['a','b','c']; c=true
a << b << c; $m.f_puts "a << b << c =: '#{a}'" # '[1, 2, 3, 4, 5, ["a", "b", "c"], true]'

#   a+=b
$m.f_thm("with a '+=' a2",true)     # not allowed with single value
a = [1,2,3,4,5]; b=['a','b','c']; c=true
a += b; $m.f_puts "a += b =: '#{a}'" # '[1, 2, 3, 4, 5, ["a", "b", "c"]'

#   a+b
$m.f_thm("with a = a1 '+' a2",true)
a = [1,2,3,4,5]; b=['a','b','c']; c=true
a = b + ["1"]; $m.f_puts "a = b+['1']=: '#{a}'" # '["a", "b", "c", "1"]'

#   a.concat b
$m.f_thm("'concat' (=='<<')",true)
a = [1,2,3,4,5]; b=['a','b','c']; c=true
a.concat b; $m.f_puts "a.concat b =: '#{a}'"  # '[1, 2, 3, 4, 5, true]'

#
#   THM: add + remove single elements
#
$m.f_thm("add/sub single array elements @:[#{__LINE__}]")

#   def
a = [1,-2,3,6,-4]
aTmp = [5.1,5.2]
i = 3; j = 77; k = 13; l=6

#   add : push,unshift,insert
$m.f_thm("add:  push,unshift,insert",true)
$m.f_inf "use a:<#{a}>"
x=a.push(i); $m.f_puts "<#{a}>.push(#{i})   =: '#{x}'"
$m.f_inf "a:<#{a}>",C_COLOR_CYAN
x=a.push(j); $m.f_puts "<#{a}>.push(#{j})   =: '#{x}'"
$m.f_inf "a:<#{a}>",C_COLOR_CYAN
$m.f_inf "use a:<#{a}>;k:<#{k}>"
x=a.unshift(k); $m.f_puts "a.unshift(#{k})  =: '#{x}'"      # begin of list
$m.f_inf "a:<#{a}>",C_COLOR_CYAN
$m.f_inf "use a:<#{a}>"
x=a.insert(i,aTmp); $m.f_puts "a.insert(#{i},#{aTmp}) =: '#{x}'"
$m.f_inf "a:<#{a}>",C_COLOR_CYAN

#   sub : pop,shift,delete,delete_at
$m.f_thm("sub:  pop,shift,delete,delete_at",true)
$m.f_inf "use a:<#{a}>"
x=a.pop;        $m.f_puts "a.pop()      =: '#{x}'"      # get last element
$m.f_inf "a:<#{a}>",C_COLOR_CYAN
x=a.shift;  $m.f_puts "a.shift()  =: '#{x}'"    # get first element
$m.f_inf "a:<#{a}>",C_COLOR_CYAN
x=a.delete(l);          $m.f_puts "a.delete('#{l}')     =: '#{x}'"  # delete by value
$m.f_inf "a:<#{a}>",C_COLOR_CYAN
x=a.delete_at(i) ;  $m.f_puts "a.delete_at(#{i})  =: '#{x}'"    # del at pos
$m.f_inf "a:<#{a}>",C_COLOR_CYAN

#
#   THM: insert/xchange elements or arrays
#
$m.f_thm("insert/xchange elements or arrays @:[#{__LINE__}]")
a = [1,2,3,4,5,6,7]; i=2;j=3;k=9
b = ['a','b','c']
c = true
$m.f_inf "use a:<#{a}>;b:<#{b}>;c:<#{c}>;i:<#{i}>;j:<#{j}>;k=<#{k}>"

$m.f_thm("extend at  i",true)
a = [1,2,3,4,5,6,7]; i=2;j=3;k=9
x=(a[k]=c); $m.f_puts "a[#{k}]=c =: '#{a}'" # not 'x'
#   complete b is exchanged
# =>  '[1, 2, "a", "b", "c", 5, 6, 7]'

$m.f_thm("xchange at i..j",true)
a = [1,2,3,4,5,6,7]; i=2;j=3;k=9
x=(a[i..j]=b); $m.f_puts "a[#{i}..#{j}]=b =: '#{a}'" # not 'x'
#   complete b is exchanged
# =>  '[1, 2, "a", "b", "c", 5, 6, 7]'

# slice - alias for x[]
$m.f_thm("method: 'slice'",true)
#   slice with integer
a = [1,2,3,4,5,6,7]; i=2;j=3;k=9
x=a.slice(i);   $m.f_puts "a.slice(#{i}) =: '#{x}'"         # '3'
x=a.slice(i,j);  $m.f_puts "a.slice(#{i},#{j})      =: '#{x}'"# ['3','4','5']
#   use inclusive endpoint with range:'..'
x=a.slice(i..j);  $m.f_puts "a.slice(#{i}..#{j})    =: '#{x}'"# ['3','4']
#   use exclusive endpoint with range:'...'
x=a.slice(i...j); $m.f_puts "a.slice(#{i}...#{j}) =: '#{x}'"# ['3']
#   slice with strings
s = "abcdefgh";
c='b'; x=s.slice c; $m.f_puts "'#{s}'.slice #{c} => '#{x}'"
c='h'; x=s.slice c; $m.f_puts "'#{s}'.slice #{c} => '#{x}'"
s="b1";c='b';
sTmp=s.clone; sTmp.slice! c; $m.f_puts "'#{s}'.slice '#{c}' =: '#{sTmp}'"

# values_at : take a listof indicies and return an array of only these elements
$m.f_thm("method: 'values_at'",true)
a = [1,2,3,4,5,6,7]; i=1;j=3;k=5
$m.f_inf "use a:<#{a}>;b:<#{b}>;c:<#{c}>;i:<#{i}>;j:<#{j}>;k=<#{k}>"
x=a.values_at(i,j,k);   $m.f_puts "a.values_at(#{i},#{j},#{k})  =: '#{x}'" #'[2, 4, 6]'
x=a.values_at(i..j,k);  $m.f_puts "a.values_at(#{i}..#{j},#{k}) =: '#{x}'" #'[2, 3, 4, 6]'

#
#   THM: pack arrays {compact,uniq}
#
$m.f_thm("pack arrays - cmd && !cmd")
a0 = [1,-2,nil,3,1,nil,6,-4,3]

#   compact[!] '  # strip nil
$m.f_thm("compact[!]",true)
a = a0
$m.f_inf "a:<#{a}>"
y=a.compact;  $m.f_puts "a.compact =: :'#{y}'"      # [1, -2, 3, 1, 6, -4, 3]
y=a.compact!; $m.f_puts "a.compact! =: :'#{y}'"     # dito
$m.f_inf "a:<#{a}>:changed",C_COLOR_CYAN

#   uniq[!] : strip doubles [and change]
$m.f_thm("uniq[!]",true)
a = a0
$m.f_inf "a:<#{a}>"
y=a.uniq; $m.f_puts "a.uniq =: :'#{y}'"     # [1, -2, 3, 6, -4]
$m.f_inf "a:<#{a}>",C_COLOR_CYAN            # [1, -2, 3, 1, 6, -4, 3]
y=a.uniq!; $m.f_puts "a.uniq! =: :'#{y}'"   # [1, -2, 3, 6, -4]
$m.f_inf "a:<#{a}>:changed",C_COLOR_CYAN    # [1, -2, 3, 6, -4]>

#
#   THM: map(loop) arrays {map[!]}
#
$m.f_thm("map[!] (looping)",true)
a0 = [1,2,3,4,5];x=2
a  = a0
$m.f_inf "a:<#{a}>,a0:<#{a0}>;x:<#{x}>"

#   map
y=a.map{|i|i*x}; $m.f_puts "a.map{|i|i*'#{x}'}=:'#{y}'" # [2, 4, 6, 8, 10]
$m.f_inf "a:<#{a}>",C_COLOR_CYAN # unchanged

#   map! (desctructive)
y=a.map!{|i|i*x}; $m.f_puts "a.map!{|i|i*'#{x}'}=:'#{y}'" # [2, 4, 6, 8, 10]
$m.f_inf "a:<#{a}>:changed",C_COLOR_CYAN
$m.f_inf "a0:<#{a0}>:!CRQ:original also changed!",C_COLOR_RED

#
#   THM:selecting {find,detect,select,reject,drop_while,delete_if,keep_if}
#
$m.f_thm("[block]-selecting @:[#{__LINE__}]")
a0=[1,3,5,7,9,10]; a=a0; x=5;
$m.f_inf "a:<#{a}>;x:<#{x}>"

#   methods: find vs find_all
$m.f_thm("methods:'find' && 'find_all'",true)
y=a.find{|i|i>x}; $m.f_puts "a.find{|i|i>'#{x}'} =: '#{y}'" # '7'
y=a.find_all{|i|i>x}; $m.f_puts "a.find_all{|i|i>'#{x}'} =: '#{y}'" # '[7, 9, 10]'

#   method:detect==find
$m.f_thm("'detect' (=='find')",true)
y=a.detect{|i|i>x}; $m.f_puts "a.detect{|i|i>'#{x}'} =: '#{y}'" # '7'

#   method:select==find_all
a=a0
$m.f_thm("'select' (=='find_all')",true)
y=a.select{|i|i>x}; $m.f_puts "a.select{|i|i>'#{x}'}=:'#{y}'" #[7, 9, 10]

$m.f_thm("'reject' (=='!select')",true)
a=a0
y=a.reject{|i|i>x}; $m.f_puts "a.reject{|i|i>'#{x}'} =: '#{y}'" # '[1, 3, 5]'

$m.f_thm("'drop_while'",true)
a=a0
y=a.drop_while{|i|i<x}; $m.f_puts "a.drop_while{|i|i<'#{x}'} =: '#{y}'" # '[5, 7, 9, 10]'

#   selection:destructive
$m.f_thm("'delete_if' (destructive!)",true)
a0=[1,3,5,7,9,10]; a=a0; x=5; #!CRQ:changes a and a0!
y=a.delete_if{|i|i>x}; $m.f_puts "a.delete_if{|i|i>x} =: '#{y}'"
$m.f_inf "a:<#{a}>",C_COLOR_CYAN

#   selection:keep_if
$m.f_thm("'keep_if' (destructive!)",true)
a0=[1,3,5,7,9,10]; a=a0; x=5;
y=a.keep_if{|i|i>x}; $m.f_puts "a.keep_if{|i|i>x} =: '#{y}'"
$m.f_inf "a:<#{a}>:changed",C_COLOR_CYAN

#   grep
$m.f_thm("'grep'",true)
#   numbers
a=[11,22,33,40,44,55]; i=20;j=40;
$m.f_inf "a:<#{a}>;i:<#{i}>;j:<#{j}>"
y=a.grep(i..j); $m.f_puts "a.grep(#{i}..#{j}) =: '#{y}'" # '[22, 33, 40]'
y=a.grep(i...j); $m.f_puts "a.grep(#{i}...#{j}) =: '#{y}'" # '[22, 33]'
#   chars with REGEX
a=['Anton','Bert','Cleo','Doris','Emil'];x='e'
$m.f_inf "a:<#{a}>;x:<#{x}>"
y=a.grep(/e/) #?PHA:how we use symbols inside /REGEX/
$m.f_puts "a.grep(/#{x}/) =: '#{y}'" # '["Bert", "Cleo"]'

#
#   THM:special selecting {inject,partition)
#
$m.f_thm("special-selecting @:[#{__LINE__}]")

#   the 'inject' method
$m.f_thm("'inject' no select but calc",true)
a=[1,2,3,4,5]
$m.f_inf "a:<#{a}>;i:<#{i}>;j:<#{j}>;"
i=0;s=0;n=0; y=a.inject(i){|s,n|s+n} # same as : s=i=0; y.each{|i| s+=i}
$m.f_puts "y1 =: a.inject(#{i}){|s,i| s+i } => '#{y}'"  # 15
i=9;s=0;n=0; y=a.inject(i){|s,n|s+n} # same as : s=i=9; y.each{|i| s+=i}
$m.f_puts "y2 =: a.inject(#{i}){|s,i| s+i } => '#{y}'"  # 24
s=0;n=0; y=a.inject{|s,n|s+n}        # like y1, but with no init (i) parameter
$m.f_puts "y3 =: a.inject{|s,i| s+i } => '#{y}'"        # 15

#   the 'partition' method
$m.f_thm("'partition",true)
a=[1,2,3,4,5,6,7,8,9]
$m.f_inf "a:<#{a}>"
i=0;y=a.partition{|x|x%2==0}
$m.f_puts "y1 =: a.partiton{|x|x%2==0} => '#{y}'"
# => '[[2, 4, 6, 8], [1, 3, 5, 7, 9]]'

#  'group_by'
$m.f_thm("'group_by",true)
a=[1,2,3,4,5,6,7,8,9]
i=0;s=0;n=0; y=a.group_by{|x|x%3==0}
$m.f_puts "y1 =: a.group_by{|x|x%3==0} => '#{y}'"
# =>'{false=>[1, 2, 4, 5, 7, 8], true=>[3, 6, 9]}'

#  'any'
$m.f_thm("'any?'",true)
a=[1,2,3,4,5,6,7,8,9]
i=0;s=0;n=0; y=a.any?{|x|x%2==0}
$m.f_puts "y1 =: a.any?{|x|x%2==0} => '#{y}'"   #true

#  'all'
$m.f_thm("'all?'",true)
a=[1,2,3,4,5,6,7,8,9]
y=a.all?{|x|x%2==0}
$m.f_puts "y=:a.all?{|x|x%2==0} => '#{y}'"   # false
y=a.all?{|x|x<10}
$m.f_puts "y=:a.all?{|x|x<10}   => '#{y}'"   # true

#
#   THM: join array => convert a2s
#
$m.f_thm("change all elements together (a2s) @:[#{__LINE__}]")
a=['Anton','Bert','Cleo','Doris','Emil'];c=';'
$m.f_inf "a:<#{a}>;c:<#{c}>"

$m.f_thm("'*'",true)
y=a*c; $m.f_puts "y=a*'#{c}' =: '#{y}'" #  string:'Anton;Bert;Cleo;Doris;Emil'
x=y.class ; $m.f_inf "y.class:= #{x}:!",C_COLOR_CYAN     # String

$m.f_thm("'join' (=='*')",true)
y=a.join(c); $m.f_puts "y=a.join('#{c}') =: '#{y}'" #  string:'Anton;Bert;Cleo;Doris;Emil'
x=y.class ; $m.f_inf "y.class:= #{x}:!",C_COLOR_CYAN     # String

#
#   THM: convert a2s <=> s2a
#
$m.f_thm("join(a2s) vs split(s2a)",true)
a=['A','B','C','D','E']; c=';'
$m.f_inf "a:<#{a}>;c:<#{c}>"
s=a.join(c);  $m.f_puts "a2s:   s=a.join('#{c}')   =: '#{s}'" #  s:"A;B;C;D;E"
a=s.split(c); $m.f_puts "s2a:   a=s.split('#{c}')  =: '#{a}'" #  s:"A;B;C;D;E"

#
#   THM: convert a2h with class extension
#
$m.f_thm("advanced array methods and class extensions @:[#{__LINE__}]")

#   mix arrays with 'zip'
$m.f_thm("zip 2 arrays [aa2a]",true)
aI=[11,22];
aS=['Anton','Bert','Cleo'];
$m.f_inf "aI:<#{aI}>;aS:<#{aS}>"
x=aS.zip aI
$m.f_puts "x:=aS.zip aI =: '#{x}'" #
y=x.class;  $m.f_puts "x.class=:'#{y}'"
# '[["Anton", 11], ["Bert", 22], ["Cleo", 33], ["Doris", nil], ["Emil", nil]]'

#   ----------------------------------------------------------------------------
#   THM: copy Arrays
#   ----------------------------------------------------------------------------

$m.f_thm("copy arrays {cloning,duplicate} @:[#{__LINE__}]")
a=[1,2,3,4]; b=['a','b','c']; x='*'
$m.f_puts "a=:<#{a}>\nb=:<#{b}>\nx=:<#{x}>"
#   copy

$m.f_thm("copy1 b:=a; b.push(x)",true)
b = a           # this is a pointer copy only!
pA = a.object_id
pB = b.object_id
$m.f_puts "object_id .a=:<#{pA}> .b=<#{pB}>"
b.push x
$m.f_puts "a =: <#{a}>"; $m.f_puts "b =: <#{b}>" # FALSE: a was overwritten

$m.f_thm("copy2 b:=a.clone; b.push(x)",true)
a = [1,2,3,4]; b = ['a','b','c']
b = a.clone     # clone a and copy this to b
pA = a.object_id
pB = b.object_id
$m.f_puts "object_id .a=:<#{pA}> .b=<#{pB}>"
b.push x
$m.f_puts "a=:<#{a}>\nb=:<#{b}>"

$m.f_thm("copy3 b:=a.dup; b.push(x)",true)
a = [1,2,3,4]; b = ['a','b','c']
b = a.dup       # duplicate a and copy this to b
pA = a.object_id
pB = b.object_id
$m.f_puts "object_id .a=:<#{pA}> .b=<#{pB}>"
b.push x
$m.f_puts "a=:<#{a}>\nb=:<#{b}>"

#   Cloning vs Duplicate
#   Cloning copies the variables but not the objects they reference

#   ----------------------------------------------------------------------------
#   ARRAY-class-extension
#   ----------------------------------------------------------------------------
$m.f_thm("class extension @:[#{__LINE__}]")

#   ARRAY-class-extension :: count
$m.f_thm("count [a2h]",true)
#   count the occurence of array members
class Array
    def f_classArray_count
        each_with_object(Hash.new(0)).with_index{|(x,h),i| h[x] +=  1}
    end
end
a= %w[spam eggs spam ham eggs spam]
$m.f_inf "a:<#{a}>"
y=a.f_classArray_count
$m.f_puts "h:=a.f_classArray_count =: '#{y}'" # '{"Anton"=>0, "Bert"=>1, "Cleo"=>2}'

#   ARRAY-class-extension :: a2h

$m.f_thm("array2hash [a2h]",true)
class Array
    def f_classArray_a2h
        each_with_object({}).with_index{|(x,h),i| h[x]=i}
    end
end
a=['Anton','Bert','Cleo']
$m.f_inf "a:<#{a}>"
y=a.f_classArray_a2h
$m.f_puts "h:=a.f_classArray_a2h =: '#{y}'" # '{"Anton"=>0, "Bert"=>1, "Cleo"=>2}'

#   ----------------------------------------------------------------------------
#   THM:use other Enumerables SET's
#   ----------------------------------------------------------------------------

require 'set'
$m.f_thm("using SETs")

$m.f_thm("array2set",true,__LINE__)
a=[1,2,3,4]
e=a.to_set
$m.f_puts "<#{a}>.to_set =>  e:[#{e}]"

$m.f_thm("some operations",true,__LINE__)
e1=Set.new [1,2];   $m.f_puts "e1:<#{e1.to_a}>"  # !RBY:not 'Set.new[1,2]' without space
e2=[1,2].to_set;    $m.f_puts "e2:<#{e2.to_a}>"
bRc=(e1==e2);       $m.f_puts "e1==e2:=>:#{bRc}"
e1.add("foo");      $m.f_puts "e1:<#{e1.to_a}>" # e1:<[1, 2, "foo"]>
e1.merge([2, 6]);   $m.f_puts "e1.merge:#{e1.to_a}"
bRc=(e1.subset? e2); $m.f_puts "e1.subset?e2:=>:#{bRc}" # -> false
bRc=(e2.subset? e1); $m.f_puts "e2.subset?e1:=>:#{bRc}" # -> true

#  End
$m.f_end

