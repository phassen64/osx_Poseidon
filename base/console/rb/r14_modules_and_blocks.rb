=begin
    overview:
    +   Modules and Blocks
        =>  module using as name spaces
        =>  modules using as class
    +   Blocks
        =>  with yield, Proc, lambda
    +   compare Proc vs. lambda
=end
#!$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

require_relative    "TUT.inc"     #<= require the file
$m.f_hdr("modules and blocks",__FILE__)

#   HEADER
if  ENV['v_mode_bBat'] != 'true'
    system("cls")        # !CRQ-200829
end

s = <<HDR
modules and blocks:
    +   module  : use name spaces
    +   block   :   yield
    +   block   :   Proc
    +   block   :   lambda
HDR
$m.f_put(s)

#   ---------------------------------------------------------------------------
#   !THM:modules
#   ---------------------------------------------------------------------------

$m.f_thm("Modules")
I=__LINE__  #   use capital letters  'I' and not 'i'
module M1
    I=__LINE__
    class CTest
        def fOut
            $m.f_puts("CLS:#{self.class.to_s};LINE:#{__LINE__};{M1}")
        end
    end
end
module M2
    I=__LINE__
    class CTest
        def fOut
            $m.f_puts("CLS:#{self.class.to_s};LINE:#{__LINE__};{M2}")
        end
    end
end
#   colors gone
#   show globals
$m.f_puts "I:=<#{::I}>"
$m.f_puts "I.M1:=<#{M1::I}>"
$m.f_puts "I.M2:=<#{M2::I}>"
#   call module-functions
x=M1::CTest.new(); x.fOut   # {M1}
x=M2::CTest.new(); x.fOut   # {M2}

#   ---------------------------------------------------------------------------
#   !THM:Yield
#   ---------------------------------------------------------------------------
$m.f_thm("yield")

#   'yield' switches between function and block with the same name.

#   + simple
$m.f_thm("simple",true)
# function 'F_<name>'
def F_yield1
    $m.f_trc(nil,__LINE__,__method__,"yield1")
    yield   # call block with name : <fctName>
    $m.f_trc(nil,__LINE__,__method__,"yield1:back")
end
# block 'F_<name>'
F_yield1 { $m.f_puts "hello block at:<" + __LINE__.to_s + ">;" }

#   + with parameters
$m.f_thm("with parameters",true)
def F_yield2
    $m.f_trc(nil,__LINE__,__method__,"yield2")
    yield "Peter", "Hassen" # jump to F_yield2 block
    $m.f_trc(nil,__LINE__,__method__,"yield2:back")
    yield "Otto", "von Bismarck"
end
F_yield2 { |x,y| $m.f_puts "block parameter:[#{x},#{y}] at:<" + __LINE__.to_s + ">;"  }

#   ---------------------------------------------------------------------------
#   !THM:Proc
#   ---------------------------------------------------------------------------

$m.f_thm("Procs")
#
#   +   define a procedure
#
$m.f_thm("procedure p(x)=x*2",true)
P_double = Proc.new {
    |x| x*2
}
r = (1..10) # range
a = r.to_a  # convert range => array
$m.f_puts a.collect(&P_double).inspect  # Output in 1 line with insepct

#
#   +   define another proc
#
$m.f_thm("procedure p(x)=x**x",true)
P_square = Proc.new {
    |x| x*x
}
#   use the procedure, using map/collect with SAME results
$m.f_puts "map:" + a.map(&P_square).inspect
$m.f_puts "collect:" + a.collect(&P_square).inspect

#
#   +   use call
#
$m.f_thm("procedure using call",true)
P_hello = Proc.new {
    $m.f_trc(__FILE__,__LINE__,__method__,"proc:hello")
}
$m.f_trc(nil,__LINE__,nil,"call my proc")
P_hello.call

#   ---------------------------------------------------------------------------
#   !THM: Lambda  # similiar to Proc
#   ---------------------------------------------------------------------------

$m.f_thm("Lambda")

#   +   simple
$m.f_thm("simple",true)
def F_lambda(p_pLambda)
    $m.f_trc(__FILE__,__LINE__,__method__,"BEGIN")
    p_pLambda.call
    $m.f_trc(__FILE__,__LINE__,__method__,"END")
end
#   define lambda-block
L_output = lambda { $m.f_trc(nil,__LINE__,__method__,"hereLambda") }
#   call function with a lambda-block as parameter
$m.f_trc(nil,__LINE__,nil,"call my simple function")
F_lambda(L_output)

#   +   parameter
$m.f_thm("with parameters",true)
L_name = lambda { |s| $m.f_puts s }
aName = ["Anton", "Bert", "Cleo"]
aName.collect(&L_name)

#   ---------------------------------------------------------------------------
#   !THM:Proc vs Lambda
#   ---------------------------------------------------------------------------

$m.f_thm("compare: Proc vs Lambda")

#   +   proc
$m.f_thm("Proc",true)
def F_procCmp()
    $m.f_trc(__FILE__,__LINE__,__method__,"begin")
    pP = Proc.new { return "hereProc at:<" + __LINE__.to_s + ">;" } # shown
    pP.call
    $m.f_trc(__FILE__,__LINE__,__method__,"end...")
    return "EOP:<" + __LINE__.to_s + ">:<" + __method__.to_s + ">"  # CODE not reached
end
$m.f_puts F_procCmp()

#   +   lambda
$m.f_thm("Lambda",true)
def F_lambdaCmp()
    $m.f_trc(__FILE__,__LINE__,__method__,"begin")
    pL = lambda { $m.f_puts "hereLambda"; return "RET:<" + __LINE__.to_s + ">;" } # not shown
    $m.f_puts pL.call   #show explicit return code
    $m.f_trc(__FILE__,__LINE__,__method__,"end...")
    return "EOL:<" + __LINE__.to_s + ">:<" + __method__.to_s + ">"  # CODE reached
end
$m.f_puts F_lambdaCmp()

# end
$m.f_end()