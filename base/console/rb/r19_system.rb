=begin
    System Access
    +   Option Parser
    +   Script Arguments
        ARGV, ARGF, ARGS $*, ScriptName $0
    +   Unix like Access
        system, exec
        `Backtick` operator
        %x
    +   os family : RbConfig::CONFIG
    +   access environment variables : use variable 'ENV'
    +   xargs
    +   popen3
=end
#!$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

require_relative "TUT.inc"
require 'optparse'

$m.f_hdr("System",__FILE__)

#   === !THM:   Environment Access

$m.f_thm("environment variable access",true,__LINE__)
vPath       = ENV['Path']
vHomeDrive  = ENV['HomeDrive']
vHomePath   = ENV['HomePath']
s = sprintf("\tHomeDrive:=<%s>\n\tHomePath:=<%s>",vHomeDrive,vHomePath)
$m.f_puts s

#
#   === !THM: other script variables
#

$m.f_thm("$0 and $*")

#   use script name : $0
$m.f_thm("ScriptName $0",true,__LINE__)
sScript=$0
$m.f_puts "$0 := <#{sScript}>"


#
#   change ARGV
#
n = ARGV.size; $m.f_puts "Arg.Size := <#{n}>]"
ARGV << "colors.json"       # 58 lines
ARGV << "book.xml"          # 35 lines

#   use ARGs $*
$m.f_thm("Arguments $*",true,__LINE__)
sArgs=$*
$m.f_puts "$* := <#{sArgs}>]"

#
#   === !THM:   ARGV and ARGF
#

$m.f_thm("ARGV and ARGF")

=begin
    zen>ruby SCRIPT.rb arg1 arg2 ...        # call-1
    zen>ruby SCRIPT.rb file1 file2....      # call-2
=end

$m.f_thm("ARGV",true,__LINE__)
#   show input args
n=ARGV.size
$m.f_puts "ARGV.size:<#{n}>"
if (n==0)
    $m.f_puts "DOS> ruby #{__FILE__} arg1 arg2..."
end
bFileOnly=false
for i in 0..n-1
    if (i==0)
        bFileOnly=true
    end
    x=ARGV[i]
    $m.f_puts "ARGV[#{i}]:<#{x}>"
    if (bFileOnly && (!File.exists?(x)) )
        bFileOnly=false # not all files - case zen1
    end
end

$m.f_thm("ARGF",true,__LINE__)
#   ARGF: show file size of all files together, if
#   ARGV args all of type existing files. # call-2
#   zen>ruby SCRIPT.rb file1 file2....
$m.f_puts "bFileOnly : <#{bFileOnly}>"
if (bFileOnly)
    s = ARGF.readlines      # put all input files together
    $m.f_puts "all file-size : <#{s.length}>"  # 93=58+35 lines
end

#
#   === !THM:Options
#
$m.f_thm("Option parsing")
$bVerbose=true
def F_parseArgs()
    hOpts  = Hash.new()
    #   puts "ARGV2:" +  ARGV.to_s
    ARGV << '-h' if ARGV.empty?
    pOptionParser = OptionParser.new do |x|
    	x.banner = "usage:DOS>ruby #{$sFileScript_NoExt} [hOpts]"
    	x.on('-h', '--help', 'displays this') do
            puts "show help"
    		puts x
    	end
    	x.on('-v','--version', 'show program and ruby version') do |y|
    		hOpts[:mVersion] = y;
    	end
    	x.on('--verbose', 'verbose') do |y|
    		hOpts[:mVerbose] = y;
    	end
    	x.on('-f','--file <File>', 'file...') do |y|
    		hOpts[:mFile]  = y;
    	end
    end # OptionParser.new do
    begin pOptionParser.parse!
        rescue OptionParser::InvalidOption => e   # invalid option
        $m.f_exc("Parser found Illegal Option : <#{e}> .",__LINE__)
        return false
    end
    return true, hOpts
end # f__parseArgs

bRc,$h = F_parseArgs()
if ( (bRc==false)|| ($h == nil) )
    iRc=-1
    $m.f_inf("??? wrong arguments - use '-h'")
    exit
elsif ($h.length == 0)
    $m.f_inf("length==0")
    iRc=100
    #   continue
else
    iRc=1
    $m.f_trc(nil,__LINE__,__method__,"OK")
    # show my args
    if ($h[:mVerbose])
        $m.f_putH($h,';')
    end
    #   parse options
    if  ($h[:mVersion])
        $m.f_puts "Ruby Version:<" + RUBY_VERSION.to_s + ">"
    elsif  ($h[:mFile])
        $m.f_print "FILE:<" + $h[:mFile].to_s + ">"
        if (File.exists?($h[:mFile]))
            $m.f_puts("...exists!")
        else
            $m.f_puts "...?not exists."
        end
    end
    exit    # finish this script now
end # i

$m.f_end()
__END__

#
#   !CRQ-190716: ignore...
#


#
#   !THM:Unix like access
#
$m.f_thm("Unix like access")

$m.f_thm("system&exec",true,__LINE__)

#   unix like functions
#   we need MSYS
system('ls t1?_*.rb')
system("echo hello by FILE:[#{$0}]")


=begin
    #   exec:
    #   starts a subprocess
    #   not use it while testing: it's stops the main-thread
    exec('echo hello1:***')
    exec('echo hello2:***')
=end

$m.f_thm("backtick",true,__LINE__)
#   op: `<cmd>`
sDir=`ls t10_*.rb`.chomp
$m.f_puts "DIR:<#{sDir}>"

system('ls t1?_*.rb')
#   system('color 0f')

#   op: %x  - same functionality as backtick
$m.f_thm("%x",true,__LINE__)
sDir=%x(ls -l t10*.rb)
$m.f_puts "DIR2:<#{sDir}>"

#   op: fork (UNIX)
$m.f_thm("fork(UNIX)",true,__LINE__)
=begin
    iPid = fork
    if (iPid==nil)
        puts "I am child"
    else
        puts "I am parent!"
    end
=end

#   os family
$m.f_thm("osFamily",true,__LINE__)
$m.f_puts RbConfig::CONFIG['host_os']
def f_os_family
    case RbConfig::CONFIG['host_os']
        when /(mingw|mswin|windows)/i
            puts "--- I am windows"
    end
end
f_os_family

#
#   === !THM:   xargs
#

=begin
    xargs ist ein Unix-Programm, das auf den meisten unixoiden Systemen,
    inklusive FreeBSD, Linux, Solaris und ReactOS verf?gbar ist.
    Es wird genutzt, um die Standardeingabe in Befehlszeilen umzuwandeln.
    xargs erschien zum ersten Mal in PWB/UNIX.

    Funktionsweise:
    xargs nimmt ?ber die Standardeingabe (meist ?ber Pipes)
    Text entgegen.
    Dieser wird dem angegebenen Argument als Kommandozeilenargument mitgegeben.

    Oft genutzt wird xargs mit find:
    $ find / -name '*.o' | xargs rm

    Dieser Befehl entfernt alle Dateien, die auf '.o' enden,
    aus dem Dateisystem des Rechners.

    find allein w?rde dabei dies ausgeben:
    $ find / -name '*.o'
    ./dev/proj/a.o
    ./dev/proj/b.o

    xargs wandelt dies in den Aufruf
        $ rm ./dev/proj/a.o ./dev/proj/b.o
    um.
    Da unter vielen Betriebssystemen die Anzahl der Kommandozeilenargumente
    nicht beliebig gro? werden darf,
    teilt xargs bei Bedarf zu viele Argumente in mehrere Aufrufe auf.
=end


#
#   === !THM:   open3
#
require 'open3'
$m.f_thm("open3")
aFile = %w[ hello.rb ]
aOut=Array.new; aErr=Array.new
#   Open3.popen3("xargs","ls","-l") do |fpInp,fpOut,fpErr|
xRc = Open3.popen3("dir t1*.rb") do |fpInp,fpOut,fpErr,pThread|
    aFile.each { |x|
        $m.f_puts "x:<#{x}>"
#       fpInp.puts x # ?ERR:waiting forever
    }
    fpInp.close
    aErr = fpErr.readlines
    aOut = fpOut.readlines
    #   fpOut.close
    #   fpErr.close
end
$m.f_inf xRc
#   $m.f_inf aOut
=begin
=end

$m.f_end()
