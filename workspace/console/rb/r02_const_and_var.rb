#!/usr/bin/ruby
=begin
    constants   :   ConstantDefinition    - first letter big
    pseudo      :
        __id__      :   ModuleId?
        __method__  :   Methode oider Funktionsname
        __FILE__    :   FileName
        __END__     :   Am Ende des Codes, alles weiter ignorieren
    local       :   l
    global      :   $g
    instance    :   @v
    class       :   @@v
    System-Variables
=end
#!$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

    require_relative        "TUT.inc"     #<= require the file
    $m.f_hdr("Constants and Vars",__FILE__)


#   ============================================================================
#   === constants
#   ============================================================================

    $m.f_thm("CONSTANTs")

    $m.f_thm("own constants",true)
    CVALUE  = 5464.3
    $m.f_put "constant value = " + CVALUE.to_s

    $m.f_thm("by RUBY",true)
    $m.f_showRubyConstants()

    $m.f_thm("PreProcessor  one",true)
    $m.f_showPreProcessorVariables(__FILE__,__LINE__,__method__,__id__)

#   ============================================================================
#   === variables
#   ============================================================================

    $m.f_thm("VARIABLEs")

#
#   a)  local
#       scope : inside a function or a script
    $m.f_thm("local",true)
    l=1
    $m.f_puts("local var l=#{l}")

#
#   b)  global
#       scope : outside classes and functions
    $m.f_thm("global",true)
    $g=5
    $m.f_puts ("global var g=#{$g}")

#
#   c)  object/instance variables
#       scope : for each object
    $m.f_thm("instance  variables",true)
    class CDog
        def f_init      # init my data
            @iLegs = 4
            @sColor = "white"
        end
        def f_out
            $m.f_puts("The dog color is :'#{@sColor}' and has '#{@iLegs}' legs.")
        end
    end
    # usage:
    x = CDog.new
    x.f_init        # define my instance vars
    x.f_out

#
#   d)  class variables
#       scope : for all objects defined by the class
    $m.f_thm("class variables",true)
    class CCar
        @@iCarNr=0  # only class var may used here
        def initialize
            @@iCarNr += 1
        end
        def f_out
            return @@iCarNr
        end
    end
    # define x, show classVar content
    x = CCar.new
    i = x.f_out
    $m.f_puts("x.CarNr is:#{i}")
    # define y, show classVar content
    y = CCar.new
    i = y.f_out
    $m.f_puts("y.CarNr is:#{i}")

#   ============================================================================
#   === system variables
#   ============================================================================
    $m.f_thm("System Variables")
s = <<HERE
    $@   :  The location of latest error
    $_   :  The string last read by gets
    $.   :  The line number last read by interpreter
    $&   :  The string last matched by regexp
    $~   :  The last regexp match, as an array of subexpressions
    $n   :  The nth subexpression in the last match (same as $~[n])
    $=   :  The case-insensitivity flag
    $/   :  The input record separator
    $\\  :  The output record separator(*)
    $0   :  The name of the ruby script file currently executing
    $*   :  The command line arguments used to invoke the script
    $$   :  The Ruby interpreter's process ID
    $?   :  The exit status of last executed child process
HERE
puts s
    # (*) !PHA: use doubled of:'\'

#   --- end
    $m.f_end()
