=begin
    HDR:Exceptions
=end
#!$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

require_relative "TUT.inc"
$m.f_hdr("Exceptions",__FILE__)

#   show
s = <<TEXT
=== using functions overview
    Exceptions in Ruby:
    http://ruby-doc.org/core-2.3.0/Exception.html
    +   Any
        NoMemoryError
    +   ScriptError
        LoadError
        NotImplementedError
        SyntaxError
    +   SecurityError
    +   SignalException
        Interrupt
    +   StandardError -- default for rescue
        ArgumentError
        FiberError
        IOError
            EOFError
        IndexError
            KeyError
            StopIteration
        LocalJumpError
        NameError
            NoMethodError
        RangeError
            FloatDomainError
        RegexpError
        RuntimeError -- default for raise
        SystemCallError
            Errno::*
        ThreadError
        TypeError
        ZeroDivisionError
    +   SystemExit
    +   SystemStackError
    +   fatal – impossible to rescue
TEXT
$m.f_put(s)

#
#   --- Exception
#
$m.f_thm("errors")

$m.f_thm("example",true)
#   div by Zero
begin
    $m.f_puts 1/0
rescue
    $m.f_puts "OUT:sorry division by zero"
end

#
#   !THM:catch exceptions
#
$m.f_thm("Catching Errors & Exceptions")

$m.f_thm("div by Zero as standard error",true)
begin
    $m.f_trc(nil,__LINE__,__method__,"divByZero:begin")
    $m.f_puts 1/0
rescue StandardError => e
    $m.f_trc(nil,__LINE__,__method__,"divByZero:rescue")
    $m.f_exc("DivZero","#{e}",__LINE__)
end

$m.f_thm("div by Zero - explicit",true)
begin
    $m.f_puts 1/0
rescue ZeroDivisionError => e
    $m.f_exc("of:ZeroDivisionError","#{e}",__LINE__)
rescue StandardError => e
    $m.f_exc("of:StandardError","#{e}",__LINE__)
end

$m.f_thm("file not open",true)
begin
    f = File.open("xyz")
rescue Errno::ENOENT => e   #Module Errno, Metod:ENOENT
    $m.f_exc("of:Errno","#{e}",__LINE__)
rescue ZeroDivisionError => e
    $m.f_exc("of:ZeroDivisionError","#{e}",__LINE__)
rescue StandardError => e
    $m.f_exc("of:StandardError","#{e}",__LINE__)
end

#
#   !THM:Raising Exceptions
#
$m.f_thm("Raising Exceptions")

$m.f_thm("raise(text) exception",true)
begin
    $m.f_trc(nil,__LINE__,nil,"raise text")
    raise   "My Test Exception raised; at:<#{__LINE__}>"
    $m.f_trc(nil,__LINE__,nil,"raise text:continue")
rescue Exception => e
    $m.f_exc("of:ANY1","#{e}",__LINE__)
end

$m.f_thm("raise(error,text)",true)
begin
    $m.f_trc(nil,__LINE__,nil,"raise:error+text")
    raise   NotImplementedError,    "?My fake not implementated;at:<#{__LINE__}>"
    raise   ZeroDivisionError,      "?My fake Division;at:<#{__LINE__}>"
    $m.f_trc(nil,__LINE__,nil,"raise:error+text:next")
rescue Exception => e
    $m.f_exc("of:ANY2","#{e}",__LINE__)
end

#
#   !THM:own excpetion classes
#

class CMyExceptionClass < StandardError
    def fOut
        $m.f_inf("myClass:<#{self.class.to_s}>")
    end
end

$m.f_thm("own  ExceptionClass",true)
#   test
x=CMyExceptionClass.new
x.fOut
begin
    raise   CMyExceptionClass,"?My fake1;at:<#{__LINE__}>"
rescue Exception => e
    $m.f_exc("of:Fake","#{e}",__LINE__)
end

#   !THM:BackTrace  - where is the raise called?
$m.f_thm("using backtraces",true)
begin
    raise   CMyExceptionClass,"?My fake2;at:<#{__LINE__}>"
rescue Exception => e
    $m.f_exc("of:Fake","#{e}",__LINE__)
    $m.f_puts "BACKTRACE is =:<" + e.backtrace.inspect + ">;"
end

#   !THM:finally
$m.f_thm("ensure (like finally)",true)
begin
    $m.f_trc(nil,__LINE__,nil,"good code...")
    raise   CMyExceptionClass,"?My fake3;at:<#{__LINE__}>"
    $m.f_trc(nil,__LINE__,nil,"good code:next")
rescue Exception => e
    $m.f_exc("of:Fake","#{e}",__LINE__)
    $m.f_puts "BACKTRACE is =:<" + e.backtrace.inspect + ">;"
ensure
    $m.f_trc(nil,__LINE__,nil,"Goodbye!") # immer ausführen
end

#   !THM:catch break
#   Vereinfachte statements für raise/rescue
#   Throw==raise, Catch==rescue
$m.f_thm("Throw/Catch")
catch :xBreak do
    $m.f_trc(nil,__LINE__,nil,"Here I am")
    throw :xBreak    # like break
    $m.f_trc(nil,__LINE__,nil,"not reached code")
end
$m.f_trc(nil,__LINE__,nil,"after catch")

$m.f_end
