=begin
    boolean => TrueClass, FalseClass
    op: =, ==, ===
        !,!!,not
=end
#!$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

require_relative "TUT.inc"
$m.f_hdr("boolean and operators={'!','!!'}",__FILE__)

#   init
b1  = true
b2  = false

#   check
$m.f_thm("boolean class info")
$m.f_thm("check",true)
bRc = b1.is_a?( TrueClass ) ;  $m.f_puts "is_<#{b1}>a? (TrueClass)  :\t" + bRc.to_s
bRc = b2.is_a?( FalseClass );  $m.f_puts "is_<#{b2}>a? (FalseClass) :\t" + bRc.to_s

$m.f_thm("getIt",true)
bRc = b1.class ;  $m.f_puts "<#{b1}>.class :\t =>" + bRc.to_s
bRc = b2.class ;  $m.f_puts "<#{b2}>.class :\t =>" + bRc.to_s

#   values print
$m.f_thm("print booleans")
$m.f_puts "b1 = '#{b1}'"
$m.f_puts "b2 = '#{b2}'"

#
#   compare with zero or number
#
$m.f_thm("used with integer")

i = 10
$m.f_thm("i=#{i}",true)
bRc = ( i == 0);    $m.f_puts "( i:#{i} == '0' )?    :\t" + bRc.to_s
bRc = ( i == 10);   $m.f_puts "( i:#{i} == '10' )?   :\t" + bRc.to_s
bRc = ( i != 0);    $m.f_puts "( i:#{i} != '0' )?    :\t" + bRc.to_s
bRc = ( i != 10);   $m.f_puts "( i:#{i} != '10' )?   :\t" + bRc.to_s

$m.f_thm("(#{i}) -  directly eval",true)
i = 0
bRc = ( i  );       $m.f_puts "(#{i})  ?     :\t" + bRc.to_s # direct eval
bRc = ( !i );       $m.f_puts "!(#{i}) ?     :\t" + bRc.to_s
i = 1
bRc = ( i  );       $m.f_puts "(#{i})  ?     :\t" + bRc.to_s # direct eval
bRc = ( !i );       $m.f_puts "!(#{i}) ?     :\t" + bRc.to_s

#   ! vs not  :: priority '!' is higher than 'not'
$m.f_thm("'!' vs 'not'",true)
bRc = !true && false; $m.f_puts "!true && false  => #{bRc}"
bRc = not(true) && false; $m.f_puts "not true && false  => #{bRc}"
# illegal syntax is: >bRc: not true&& false

#
#   traps !
#
$m.f_thm("evaluation test with functions - eq1/neq1")

def F_eqZ(i)
    #   this is Ok
    if ( i == 0 )
        return true
    else
        return false
    end
end
def F_neqZ(i)
    #   this is also Ok
    if ( i != 0)
        return true
    else
        return false
    end
end
def F_eva(i)
    #   This functions doesn't work,
    #   because if (<integer>) only is not allowed
    if ( i )
        return true
    else
        return false
    end
end

i=1;bRc=F_eqZ(i);   $m.f_puts "(#{i} == 0) =: <" + bRc.to_s + ">"
i=0;bRc=F_eqZ(i);   $m.f_puts "(#{i} == 0) =: <" + bRc.to_s + ">"
i=1;bRc=F_neqZ(i);  $m.f_puts "(#{i} != 0) =: <" + bRc.to_s + ">"
i=0;bRc=F_neqZ(i);  $m.f_puts "(#{i} != 0) =: <" + bRc.to_s + ">"
$m.f_thm("ATTENTION: avoid eval directly !",true)
i=1;bRc=F_eva(i);   $m.f_puts "(#{i}) =: <" + bRc.to_s + ">"
i=0;bRc=F_eva(i);   $m.f_puts "(#{i}) =: <" + bRc.to_s + "> : !"

#
#   double bang
#
$m.f_thm("Double Bang '!!'")

$m.f_thm("with true",true)
x = true    ; $m.f_puts "true     =: <" + x.to_s + ">"
x = false   ; $m.f_puts "false    =: <" + x.to_s + ">"
x = !true   ; $m.f_puts "!true    =: <" + x.to_s + ">"
x = !false  ; $m.f_puts "!false   =: <" + x.to_s + ">"
x = !!true   ; $m.f_puts "!!true    =: <" + x.to_s + ">"
x = !!false  ; $m.f_puts "!!false   =: <" + x.to_s + ">"

$m.f_thm("with nil",true)
x = nil     ; $m.f_puts "nil     =: <" + x.to_s + ">"
x = !nil    ; $m.f_puts "!nil    =: <" + x.to_s + "> : !"
x = !!nil   ; $m.f_puts "!!nil   =: <" + x.to_s + "> : !"

#
#   end of script
$m.f_end()
