=begin
    functions
    keyWords:
        def return
        alias unalias
=end
#!$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

require_relative "TUT.inc"
$m.f_hdr("functions",__FILE__)

#   show
s = <<HDR
using functions overview ==
    functions:
    +   define and calling
    +   return values - implicitely, explicitely
    +   default-parameter
    +   named-default-parameter
    +   hash-parameter/ variable parameters
    +   alias/unalias
    +   polymorphie
===
HDR
$m.f_put(s)

#
#   THM: define function
$m.f_thm("define functions")
#

#   simple
$m.f_thm("noParam-noReturn",true)
def f_hello1
    $m.f_puts "hello"
end
f_hello1

#   use standard return
$m.f_thm("noParam-standardReturn",true)
def f_hello2()
    4711   # standard last line
end
iRc = f_hello2
$m.f_puts "function returns :" + iRc.to_s

#   explicit return
$m.f_thm("noParam-explicit return",true)
def f_hello3()
    return(0x41)   # return this - use HEX syntax
    4711            # last line - not return value
end
iRc = f_hello3()
$m.f_puts "function returns :" + iRc.to_s

#   multiple return values
$m.f_thm("multiple return values",true)
def f_hello4()
    return 10,11,12
end
aRc = f_hello4() # array returns
$m.f_puts "function returns ARRAY: <#{aRc}>"

#   parameter
$m.f_thm("parameter",true)
def f_hello5(pName)
    $m.f_puts "hello Parameter of pName is :<#{pName}> "
    return true # boolean return
end
bRc = f_hello5('peter')
$m.f_puts "function returns: <#{bRc}>"  # true

#   using default-parameter
$m.f_thm("default-parameter",true)
def f_hello6(pName='Theo')
    $m.f_puts "hello:#{pName}"
end
f_hello6('Willi')   # => Willi
f_hello6()          # => Theo - default parameter used

#   named default-parameters
$m.f_thm("named default-parameters",true)
def f_name(pFirst:"Otto", pLast:"von Bismarck", pCity:"Hamburg")
    $m.f_puts "NAME : '#{pFirst}' '#{pLast}' lives in '#{pCity}'"
end
# Der Funktionsaufruf greift gezielt auf einzelne Paramer
# Es können so Default-Parameter ohne Aufrufe verwendet werden.
f_name()    # DEFAULT
f_name(pFirst:'peter')
f_name(pLast:'Schumacher')
f_name(pCity:'Berlin')
f_name(pCity:'MIAMI',pFirst:'Peter',pLast:'Hassen')

#   flexible-hash-parameter
#       : predefine parameter with a hash
$m.f_thm("hash-parameter",true)
def f_calc( pHash={} )
    #   define default-parameter as hash
    #   merge, if caller provides parameters
    lHash = {
        :n1 => 2, :n2 => 3, :n3 => 1
    }.merge(pHash)   # merge local with input hash
    uRc = lHash[:n1] * lHash[:n2] - lHash[:n3]
end
#    caller doesn't provide parameters
xRc=f_calc();
$m.f_puts "xRc=" + xRc.to_s         # 2*3-1 =: 5
#    caller changes 1 internal values
xRc=f_calc(:n2=>10);
$m.f_puts "xRc=" + xRc.to_s          # 2*'10'-1  =: 19
#    caller changes 2 internal values
xRc=f_calc(:n2=>5,:n3=>2);
$m.f_puts "xRc=" + xRc.to_s          # 2*'5'-'2' =: 8

#   variable parameters
#       : parameter depends on the program-logic
$m.f_thm("variable-parameters",true)
def f_pets( *p )
    $m.f_puts "Received :: count #{p.count}" +   "; len=#{p.length}"
    for i in 0...p.count
        $m.f_puts "PET[#{i}] = #{p[i]}"
    end
end
f_pets "Dog"        # => PET[0]:Dog
f_pets "Dog","Bird","Cat" # => PET[i]:Dog,....

#
#   THM: define alias
$m.f_thm("alias functions")
#
def f_secret( pName )
   $m.f_puts "Secret name Is : '#{pName}'"
end
# define new alias
alias alSecret f_secret
# call function via alias
alSecret('Bond')
# undef alias
undef alSecret
#   alSecret('Bond') - error
f_secret('007')

#
#   THM: polymorphie
$m.f_thm("Polymorphie")
#
def f_math(p1,p2)
    $m.f_puts "math1"
    return p1*p2
end
x = f_math 5,6; $m.f_puts "=> #{x}"     # 30
# re-define function
def f_math(p1,p2,p3)
    $m.f_puts "math2"
    return p1+p2+p3
end
x = f_math 1,2,3; $m.f_puts "=> #{x}"   # 6

$m.f_end
