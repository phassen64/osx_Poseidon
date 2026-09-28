=begin
    Ruby Tutorial:
=end
#encoding: UTF-8
#!$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

#   include a file local to this one
require_relative "TUT.inc" # include a    File

#   import !CRQ-240425:notInUnix
bUnix = $m.f_os_bIsUnix()
if (!bUnix) 
    require 'awesome'
    require 'colorize'
    require 'gnuplot'
    require 'highline'      # A high-level IO library that provides validation
    require 'json'
    require 'multi_json'
    require 'net-telnet'
    require 'python'
    require 'method_source'
    require 'thor'
    require 'rdoc'
    require 'rubygems'              # !CRQ-220707
    require 'zip'
end

$m.f_hdr("Introduction",__FILE__)

#   check posix
bPosix = $m.f_os_bIsUnix(true)
puts "g.Posix:=<#{bPosix}>"

#   show
$m.f_thm("Ruby Tutorial overview")
sRubyTutorial = <<xHere
    1)  Introduction    :: '='begin, '='end, __END__
    2)  Constants && Vars   ::
    3)  dataTypes (intro)
    4)  Operators
    5)  Boolean: TrueClass, FalseClass...
    6)  Integer
    7)  String(s)
    8)  Array && Set
    9)  Hash
    10) RegEx
    11) Control Flow    :: while do loop if else elsif case unless
    12) Function        :: def,end,alias,return
    13) Classes         :: class, initialize, self, attr_accessor,private...
    14) modules+blocks  :: module,yield,Proc,lambda
    15) Exception       :: rescue ensure
    16) I/O             :: File.x,Dir.x,ARGV
    17) meta-Programming    :: method
    18) Threads
    19) System          :: OptionParser,`Backtick`,ARGV,ARGF
    20) Formats         :: zip,JSon,Xml,ProtoBuffer
xHere
$m.f_put(sRubyTutorial)

$m.f_thm("KeyWords overview")
sRubyKeywords = <<xHere
    alias and begin break case class    (6)
    def define_method do                (3)
    else elsif end ensure false for     (6)
    if in method module next nil not or     (8)
    redo rescue retry return self super then true (8)
    undef unless when while yield       (5)
    DATA __END__                        (2)
    =:38 keyWords
xHere
$m.f_put(sRubyKeywords)


#   print to console
$m.f_thm("print -- use different variations")
print "Hello,Ruby World\n"      # ruby needs not f(...) - 'print - no autoNL'
puts  "Hello,Ruby World again"  # 'puts  - with autoNL'
printf("Script '%s' says Hello Ruby\n",__FILE__)  # using C-printf
p   'Hello,Ruby World again2'   # puts simple
p   123                         # output>123
puts  "1 string in  2 lines -
continue with 2.line" # use string-delimiter:'-'

#   using library fuction
$m.f_thm("using library")
$m.f_put("Ruby",false,false)   # no NL
$m.f_put("Ruby",true,true)     # NL=yes
# called with named parameters, order free
$m.f_put("Hello",p_bColor=true,p_bFileNL=true,p_bTextNL=true)

#   say hello and show version with command-delimiter:';'
$m.f_sHello(); $m.f_showVersion()

#   DATA
$m.f_thm("using 'DATA' and  '__END__' comment")
DATA.each_line do |x|
  puts x
end

#   return
$m.f_end()

puts "ignore me"

__END__
== ignored area ==
This Text will be issued by the DATA command.
