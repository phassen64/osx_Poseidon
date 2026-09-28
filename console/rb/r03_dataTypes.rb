=begin
	Data Types (or Class Types)
		Integer, Float, Rational
		Strings,
		Boolean => {TrueClass, FalseClass}
		Array, Hash
=end
#!$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

require_relative "TUT.inc"

$m.f_hdr("dataTypes",__FILE__)

#   define variables of different class-types
$m.f_thm("define types (classTypes)")
c = 'v'; s = "peter"
i = 1; I = 123456789123456
f = -6.45; F = 1234567890122423638393.789
r = Rational(1/2)
C = Complex(2, 3)
b   = true; b2  = false
a = [1,2,3]; h = { "Name" => "Peter", "PLZ" => 90489}

#   print all type-different variables
$m.f_thm("print types")
$m.f_puts "c=<" + c.to_s + ">"
$m.f_puts "s=<" + s.to_s + ">"
$m.f_puts "i=<" + i.to_s + ">"
$m.f_puts "f=<" + f.to_s + ">"
$m.f_puts "F=<" + F.to_s + ">"
$m.f_puts "r=<" + r.to_s + ">"
$m.f_puts "C=<" + C.to_s + ">"
$m.f_puts "b=<" + b.to_s + ">"
$m.f_puts "A=<" + a.to_s + ">"
$m.f_puts "H=<" + h.to_s + ">"

#   determine variable-class by using   : <x>.is_a?<ClassName> => True/false
$m.f_thm("check types via <dataType>")
bRc = i.is_a? Integer ;     $m.f_puts "<#{i}>.is_a? Integer  =:\t" + bRc.to_s
bRc = i.is_a? Numeric ;     $m.f_puts "<#{i}>.is_a? Numeric  =:\t" + bRc.to_s
bRc = i.is_a? Float ;       $m.f_puts "<#{i}>.is_a? Float  =:\t" + bRc.to_s         # F
bRc = r.is_a? Rational ;    $m.f_puts "<#{r}>.is_a? Rational =:\t" + bRc.to_s
bRc = f.is_a? Float ;       $m.f_puts "<#{f}>.is_a? Float =:\t" + bRc.to_s
bRc = f.is_a? Numeric ;     $m.f_puts "<#{f}>.is_a? Numeric =:\t" + bRc.to_s
bRc = f.is_a? Rational ;    $m.f_puts "<#{f}>.is_a? Rational =:\t" + bRc.to_s       # F
bRc = b.is_a?( TrueClass ); $m.f_puts "<#{b}>.is_a? (TrueClass)  =:\t" + bRc.to_s
bRc = b.is_a?( FalseClass );$m.f_puts "<#{b}>.is_a? (FalseClass) =:\t" + bRc.to_s   # F
bRc = b.is_a? TrueClass ;   $m.f_puts "<#{b}>.is_a?  TrueClass  =:\t" + bRc.to_s
bRc = b.is_a? FalseClass ;   $m.f_puts "<#{b}>.is_a? FalseClass  =:\t" + bRc.to_s   # F
bRc = s.is_a? String ;      $m.f_puts "<#{s}>.is_a? String   =:\t" + bRc.to_s
bRc = a.is_a? Array ;       $m.f_puts "<#{a}>.is_a? Array    =:\t" + bRc.to_s
bRc = h.is_a? Hash ;        $m.f_puts "<#{h}>.is_a? Hash     =:\t" + bRc.to_s

#   special for BigNum
$m.f_thm("BigNum",true)
bRc = I.is_a? Integer ;  $m.f_puts "is I=<#{I}>.is_a? Integer?  =:\t" + bRc.to_s
bRc = I.is_a? Bignum ;   $m.f_puts "is I=<#{I}>.is_a? Bignum?  =:\t" + bRc.to_s

#   determine variable-class by using    : <x>.class => "<ClassName>"
$m.f_thm("check types via 'keyword class'")
x=i.class ; $m.f_puts "<#{i}>.class:= #{x} ;"     # Fixnum
x=I.class ; $m.f_puts "<#{I}>.class:= #{x} ;"     # Bignum
x=f.class ; $m.f_puts "<#{f}>.class:= #{x} ;"     # Float
x=F.class ; $m.f_puts "<#{F}>.class:= #{x} ;"     # Float
x=r.class ; $m.f_puts "<#{r}>.class:= #{x} ;"     # Rational
x=b.class ; $m.f_puts "<#{b}>.class:= #{x} ;"     # TrueClass
x=b2.class; $m.f_puts "<#{b2}>.class: #{x} ;"     # FalseClass
x=c.class;  $m.f_puts "<#{c}>.class:= #{x} ;"     # String
x=s.class;  $m.f_puts "<#{s}>.class:= #{x} ;"     # String

#   special regEx
$m.f_thm("special RegEx type")
s = "p123.abc"
r = /[[:alpha:]]+[[:alnum:]]+[[:punct:]][[:alnum:]]{3}/
z = s.match(r)  # z of type regEx
x = z.class;  $m.f_puts "<#{z}>.class:= #{x} ;"     # MatchData
#   compare regEx with a string
if (s == z.to_s)
    puts "true: '#{s}' == '#{z}'"
end

#   convert with "to_<x>" methods
#   [to_i and to_s] are not particularly strict: if an object has some kind of
#   decent representation as a string, for example, it will probably have a to_s
#   method? [to_int and to_str] are strict conversion functions: you implement them
#   only if [your] object can naturally be used every place a string or an integer
#   could be used.
#   In summary, here is how I see it:
#   ?call to_s to get a string that describes the object.
#   ?call to_str to verify that an object really acts like a string.
#   ?implement to_s when you can build a string that describes your object.
#   ?implement to_str when your object can fully behave like a string
$m.f_thm("convert with to_<x>...")
$m.f_inf("use a:=#{a}:#{a.class}")
$m.f_inf("use h:=#{h}:#{h.class}")
$m.f_inf("i:=#{i},f:#{f}")
$m.f_thm("any",true)
x=a.to_s;   y=x.class;  $m.f_puts "<#{a}>.to_s:= #{x}; <#{x}>.class:= #{y}"
x=h.to_a;   y=x.class;  $m.f_puts "<h>.to_a:= #{x}; <#{x}>.class:= #{y}"
$m.f_thm("integer vs float",true)
x=i.to_f;   y=x.class;  $m.f_puts "<#{i}>.to_f:= #{x}; <#{x}>.class:= #{y}"
x=f.to_i;   y=x.class;  $m.f_puts "<#{f}>.to_i:= #{x}; <#{x}>.class:= #{y}"

$m.f_end()
