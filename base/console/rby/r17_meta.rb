=begin
    meta
=end
#!$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

require_relative "TUT.inc"
$m.f_hdr("meta",__FILE__)
#   open-file modes
sHere =<<MyHere
    One of the most impressive aspects of Ruby is its metaprogramming capabilities.
    As a dynamic language,
    Ruby gives you the freedom to define methods and even classes during runtime.
    Metaprogramming with Ruby,
    one can do in a few minutes what other languages may take hours to do.
    By cleverly planning your code and applying the techniques mentioned here,
    you’ll be able to write code that is DRYer, lighter,
    more intuitive and more scalable.
MyHere
$m.f_doc("Introduction:","META-Programming",sHere.to_s)

$m.f_thm("meta Array")
class Array
    def fOp(p_cOperator)
        inject {    |x,i|   #
            x ? x.send(p_cOperator,i) : i
        }
    end
end
#   not working with m.f_puts...
a = [6,3,2]
$m.f_inf("use a:#{a}")
print "00:"; print a; puts ";"               # normal 6,3,2;
$m.f_print("01:[6,3,2] '/' := ")
puts a.fOp('/')                 # 1
$m.f_print("02:[4,3,2] '*' := ")
puts a.fOp('*')                 # 36
$m.f_print("03:[4,3,2] '+' := ")
puts a.fOp('+')                 # 11

#   $m.f_inf("try else")
#   puts a.send('*',2)
#   exit

$m.f_thm("meta Class String.fSentence")
#   des: Substitute in a Text all '.' with ';'
class String
    private
    def fSemicolon(a)
        sRc = ''    # empty string
        a.each { |x| sRc = sRc + x.lstrip() + ';' }
        return sRc
    end
    public
    def fSentence
        a   = self.split('.')   # array of strings
        fSemicolon(a)   # Satz1 Satz2 Satz3...
    end
end
s = "Satz1. Satz2. Satz3. Satz4"    # Satz<i>.<SPACE>
$m.f_puts s.fSentence               # Satz1;Satz2;Satz3;Satz4;

#
#   !THM:   change String.length method
#
$m.f_thm("meta:String.length")
s = "HelloDuDa"
$m.f_inf("TEXT:#{s}")
$m.f_puts s + ".length1===" + s.length.to_s
#   change class:String
class String
    def length
        return 123
    end
end
$m.f_puts s + ".length2===" + s.length.to_s

#
#   !THM:   methods
#
#   we can explicitely call a method
$m.f_thm("meta:use 'method'")
$m.f_inf("s.methods.inspect...")
$m.f_puts s.methods.inspect
s = "A,B,C,D,E"
$m.f_inf("use TEXT:<#{s}>")
$m.f_puts "way normal"  + s.split(',').to_s
$m.f_puts "by 'method'" + s.method('split').call(',').to_s

#
#   === end
#
$m.f_end




