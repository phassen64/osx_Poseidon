=begin
    HDR: I/O : DataStorage(Dir && Files)
    +   Dir.<x> methods
            chdir, delete, exists?, foreach, glob, mkdir, pwd
    +   File.<x> methods
            new(<sFile>,<xMode>)    == open<ALIAS>
            exist?(<sFile>), size(<sFile>)
            read(<sFile>), readlines(<sFile>)
    +   FilePointer.<x> methods
            putc(c), puts(s)
            readline
            close
    +   low-level file access
            IO.sysopen,fp.sysread,fp.syswrite
    +   Simple IO
=end
#!$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

require_relative "TUT.inc"
require 'tmpdir'        # handle TmpDirs

$m.f_hdr("Directories and Files",__FILE__)

#   open-file modes
sHere =<<MyHere
    [http://ruby-doc.org/core-2.4.2/IO.html#method-c-new]
    "r"     Read-only, starts at beginning of file  (default mode).
    "r+"    Read-write, starts at beginning of file.
    "rb+"   ... for bin-files....
    "w"     Write-only, truncates existing file
            to zero length or creates a new file for writing.
    "w+"    Read-write, truncates existing file to zero length
            or creates a new file for reading and writing.
    "wb+"   ... for bin-files....
    "a"     Write-only, each write call appends data at end of file.
            Creates a new file for writing if file does not exist.
    "a+"    Read-write, each write call appends data at end of file.
            Creates a new file for reading and writing if file does
            not exist.
MyHere
$m.f_puts("<<< Ruby FileOpen-modes :\n" + sHere.to_s)

sModes =<<MyHere
    The following modes(Qualifier) must be used separately,
    and along with one or more of the modes seen above.
    "b"  Binary file mode
         Suppresses EOL <-> CRLF conversion on Windows. And
         sets external encoding to ASCII-8BIT unless explicitly
         specified.
    "t"  Text file mode
MyHere
$m.f_puts("<<< Ruby FileOpen-modes-qualifier :\n" + sModes.to_s)

#
#   !THM:simple file-handling high-level
#
$m.f_thm("file-handling: high-level")

#   get them TmpDir
$m.f_thm("get tmpDirPath",true,__LINE__)
sDirTmp = Dir.tmpdir()
$m.f_puts "sDir:'#{sDirTmp}'"

#   define fileName
$m.f_thm("define fileName",true,__LINE__)
sFileNoExtNoPath = $m.f_sFileBase_withoutExt(__FILE__)
$m.f_puts "sFileNoExtNoPath:'#{sFileNoExtNoPath}'"
sFileNoExt = $m.f_sFilePath(sDirTmp,__FILE__,false)
$m.f_puts "sFileNoExt:'#{sFileNoExt}'"
sFileTxt = sFileNoExt.to_s + '.txt'
sFileBin = sFileNoExt.to_s + '.bin'
$m.f_puts "TXT-File:'#{sFileTxt}'"
$m.f_puts "BIN-File:'#{sFileBin}'"

#   create a text-file
$m.f_thm("create files: use 'new'",true)
begin
    fp = File.new(sFileTxt,"w+")
    $m.f_puts "File <#{sFileTxt}>...created."
rescue  StandardError => e
   $m.f_exc("of:StandardError","#{e}",__LINE__)
   exit
end

#  check existing file
$m.f_thm("file exists?",true,__LINE__)
$m.f_print "?File['#{sFileTxt}'].exists..."
if (File.exist?(sFileTxt.to_s))
    $m.f_puts " => 'YES!'"
else
    $m.f_puts " => 'NO!'"
    exit
end

#  check zero-length
$m.f_thm("file zero?",true,__LINE__)
$m.f_print "?File['#{sFileTxt}'].zero..."
if (File.zero?(sFileTxt.to_s))
    $m.f_puts " => 'YES!'"
else
    $m.f_puts " => 'NO!'"
end

#   inspect
$m.f_thm("inspect",true,__LINE__)
s = fp.inspect
$m.f_puts "inspect => '#{s}'" # '#<File:x:/TEMP/t16_file.txt>'

#  write into file
$m.f_thm("file-writing",true)
i=0
#   put 10 chars
sTxt=nil
while(i<10)
    c=('A'.ord + i).chr
    sTxt = sTxt.to_s + c.to_s   # !CRQ-210302:frozen string : sTxt = sTxt.to_s << c
    i+=1
end
$m.f_puts sTxt
fp.puts(sTxt)
sTxt="NOW:=" + $m.f_sNow().to_s + ";"
$m.f_puts "try to file-write:'#{sTxt}' of length:<" + sTxt.length.to_s + ">"
fp.puts(sTxt)
#   exit

#   close file
#   without close, the file could not ...
#       be check by file size... or
#       be read
$m.f_thm("file close",true)
$m.f_puts "close FILE with fp:<#{fp}>..."
fp.close             # close FILE with fp:<#<File:0x00000003199bc0>>...

#  check file-size
$m.f_thm("file-size check",true,__LINE__)
$m.f_print "FILE.size:'#{sFileTxt}'..."
n = File.size(sFileTxt)
$m.f_puts :":'#{n}'"    # FILE.size:'x:/TEMP/t16_file.txt'...:'22'

#  check file status(UNIX)
$m.f_thm("file status?(UNIX/WINDOWS)",true,__LINE__)
$m.f_print "?File['#{sFileTxt}'].stat..."
p = File.stat(sFileTxt.to_s)
$m.f_puts "FileStatus:<#{p}>"
iBlocks=p.blocks
iBlSize=p.blksize
$m.f_puts "BLOCKS:#{iBlocks} with SIZE:#{iBlSize}"
sCrtTime=p.ctime
$m.f_puts "TIME:#{sCrtTime}"

#  read complete file
$m.f_thm("File.read",true)
sTmp = File.read(sFileTxt) # read complete file
sTmp = sTmp.chomp   # cut "\n"
$m.f_puts "fileRead:['#{sTmp}']"

#  read complete file as lines
$m.f_thm("File.readlines",true)
aRc   = File.readlines(sFileTxt) # read complete file
for i in 0..aRc.length-1
    sLine = aRc[i]
    sLine.chomp!
    $m.f_puts "fileLine[#{i}]:['#{sLine}']"
end

#   read 1 single line
$m.f_thm("readline",true)   # reads 1 line
begin
    fp = File.open(sFileTxt,"r")
    $m.f_puts "File <#{sFileTxt}>...open for reading."
    # read until EOF
    iLine=0
    while ((s=fp.readline)!=nil)
        sLine=s
        iLine+=1
    end
rescue IOError => e
   $m.f_exc("of:IOError","#{e}",__LINE__)   # => EOF run's here
rescue StandardError => e
   $m.f_exc("of:StandardError","#{e}",__LINE__)
   exit
ensure
    sLine.chomp!
    puts "I read: Lines:#{iLine} with LAST one:<#{sLine}>"
    fp.close
end

#   create another file a bin-file
$m.f_thm("create BIN file - open wrong",true,__LINE__)
begin
    fp = File.open(sFileBin,"w+")   # wrong opened, should be 'wb..'
    $m.f_puts "File <#{sFileBin}>...created."
rescue StandardError => e
   $m.f_exc("of:StandardError","#{e}",__LINE__)
   exit
end

#   write into bin-file(wrong opened)
$m.f_thm("fp.putc",true,__LINE__)
i=0x00;j=0x20; $m.f_inf("use i:#{i},j:#{j}")
for x in i..j-1
    $m.f_print(sprintf("%02.2x.",x))
    fp.putc(x) # !RBY:  maps '0x0A' => 0x0D,0x0A
end
$m.f_puts "!"
=begin
https://stackoverflow.com/questions/7533909/how-to-write-just-one-0x0a-character-to-stdout-in-ruby-on-windows
    At the (Ruby) IO layer this feature is responsible for mapping "\n" (0x0A, LF)
    to/from the Operating Systems definition of a newline.
    Windows maps "\n" to CR+LF(0d0a)
=end
fp.close
n=File.size(sFileBin)
$m.f_puts :"<#{sFileBin}>.size:=<#{n}>" # => 33 => that' wrong

#   open for reading -- change
$m.f_thm("open2 BIN file",true,__LINE__)
fp = File.open(sFileBin)   # opened for a text-file, should be 'rb..'
fp.binmode # once set the binread-flag, it can't be removed later
$m.f_inf "try to read file..."
sLine = fp.readline # only first
for i in 0..sLine.length-1
    x = sLine[i].ord
    $m.f_print(sprintf("%02.2x",x)) # shows even CR+LF=:'0d0a'
    if (i==sLine.length-1)
        $m.f_puts('!')
    else
        $m.f_print('.')
    end
end # end for

#
#   real bin-files
#

#   open bin-file
$m.f_thm("open wb+",true)
begin
    fp = File.open(sFileBin,"wb+")  # use 'wb+'
    $m.f_puts "File2 <#{sFileBin}>...created."
rescue StandardError => e
   $m.f_exc("of:StandardError","#{e}",__LINE__)
   exit
end

#   write into bin-file
$m.f_thm("fp.putc",true,__LINE__)
i=0x00;j=0x40; $m.f_inf("use i:#{i},j:#{j}")
for x in i..j-1
    $m.f_print(sprintf("%02.2x",x))
    fp.putc(x)
    if (((x+1)%0x10) == 0)
        $m.f_puts  ';'
    else
        $m.f_print '.'
    end
end
$m.f_puts "!"
fp.close
#   file2 Size
n=File.size(sFileBin)
$m.f_puts :"<#{sFileBin}>.size:=<#{n}>" # => 32

#
#   !THM:simple dir-handling
#

#   pwd
$m.f_thm("dir-handling")
$m.f_thm("PWD",true,__LINE__)
sPwd=Dir.pwd; sDirPrj=sPwd
$m.f_puts "PWD:<'#{sPwd}'>"

#   exists TMP?
$m.f_thm("exists?",true,__LINE__)
$m.f_print "Dir.exists?...:"
bDir = Dir.exists?(sDirTmp)
if (bDir)
    $m.f_puts "'YES'"
else
    $m.f_puts "!NO"
    exit
end

#   cd to TMP
$m.f_thm("cd",true,__LINE__)
Dir.chdir(sDirTmp)
sRc=Dir.pwd
$m.f_puts "dirTmp:<'#{sRc}'>"

#   mkdir TmpTmp
$m.f_thm("Dir.new",true,__LINE__)
sDirNew='TmpTmp'
if (Dir.exists?(sDirNew) == false)
    begin
        Dir.mkdir(sDirNew)
    rescue StandardError => e
       $m.f_exc("of:StandardError","#{e}",__LINE__)
       exit
    end
    $m.f_print "DirNEW.exists?...:"
    bDir = Dir.exists?(sDirNew)
    if (bDir)
        $m.f_puts "'YES'"
    else
        $m.f_puts "!NO"
        exit
    end
end

#   delete again TmpTmp
$m.f_thm("Dir.delete TmpTmp...",true,__LINE__)
sleep(1)
begin
    Dir.delete(sDirNew)
rescue StandardError => e
   $m.f_exc("of:StandardError","#{e}",__LINE__)
   exit
end

#   goto HOMEdir        # !CRQ-240425:notParseTmp
Dir.chdir(sPwd)
sRc=Dir.pwd
$m.f_puts "currentDir:<'#{sRc}'>"

#   dir files*
$m.f_thm("Dir.glob",true,__LINE__)
x = Dir.glob("#{sFileNoExt}*")
t=x.class ; $m.f_puts "<#{x}>.class:= #{t} ;" # Array
aDir=x
$m.f_puts aDir

#   dir all
$m.f_thm("Dir.foreach",true,__LINE__)
x = Dir.foreach(".")
t = x.class ; $m.f_puts "<#{x}>.class:= #{t} ;" # Enumerator
#   !RBY: puts x deletes the result!
i=0
Dir.foreach(".") { |x|
        i+=1
        if (x.include? '.rb')
            $m.f_puts "found[#{i}]:<#{x}>"
        end
}
$m.f_puts "Dir file sum : [#{i}]"

#
#   !THM:RANDOM access file-handling
#

#   open a file and seek chars using file Pos
$m.f_thm("RANDOM access file-handling")

$m.f_thm("open-close-seek(x)",true)
C_ENCODING_ISO  = 'iso-8859-1'
C_ENCODING_UTF  = 'UTF-8'
iFPos=0x18
iFPosEnd=0x28
#   seek char at filePos
begin
    fp = File.open(sFileBin,"rb:#{C_ENCODING_ISO}")
    $m.f_puts "File <#{sFileBin}>...opened."
    #   goto filePos
    while iFPos<iFPosEnd
        s = sprintf("%02.2x(x),%d(d)",iFPos,iFPos)
        $m.f_print "\tfPos:[#{s}] :"
        fp.seek(iFPos)
        c = fp.getc()   #   or read(1)
        iFPos+=1
        if (c==nil)
            $m.f_puts "NIL!"
            next    # break
        end
        i = c.ord()
        s = sprintf("'%0c'=%02.2x(x)",c,i)
        $m.f_puts "\t<#{s}>"
    end
    $m.f_puts "#end"
    fp.close
rescue StandardError => e
   $m.f_exc("of:StandardError","#{e}",__LINE__)
   exit
end

#   using 'rewind',seek','tell','pos'
$m.f_thm("seek",true)
begin
    fp = File.open(sFileBin,"rb:#{C_ENCODING_ISO}")
    fp.seek(10,IO::SEEK_SET)        # mode:={SEEK_SET,SEEK_CUR,SEEK_END}; fPos:=10
    i=fp.tell
    $m.f_puts "fPos1:<#{i}>"        # 10
    fp.seek(2,IO::SEEK_CUR)         # fPos+=2
    i=fp.pos                        # .pos == .tell == 12
    $m.f_puts "fPos2:<#{i}>"        # 12
    fp.seek(-5,IO::SEEK_END)        # fPos:=fPos(EOF)-5
    i=fp.tell
    $m.f_puts "fPos3:<#{i}>"        # 59
    fp.rewind                       # rewind=>fPos:=0
    i=fp.tell
    $m.f_puts "fPos4:<#{i}>"        # 0
rescue StandardError => e
   $m.f_exc("of:StandardError","#{e}",__LINE__)
   exit
end


#
#   !THM:file-handling:low-level
#
$m.f_thm("file-handling: low-level")
$m.f_thm("sysread",true)
begin
    fd = IO.sysopen(sFileTxt,"r")       # get fileDescriptor
    fp = IO.new(fd)                     # build filePointer
    s  = fp.sysread(10)                 # read 10 chars
    $m.f_puts "read:<#{s}>"
    fp.close
rescue StandardError => e
   $m.f_exc("of:StandardError","#{e}",__LINE__)
   exit
end
$m.f_thm("syswrite",true)
begin
    #   fd = IO.sysopen(sFileTxt,"a+")      # append
    #   fp = IO.new(fd)
    sTxt='END$'
    fp  = File.new(sFileTxt,"a+")            # append
    iRc = fp.syswrite(sTxt)                  # write 'END'
    $m.f_puts "wrote?:<#{sTxt}><iRc:#{iRc}>"
    fp.close
rescue StandardError => e
   $m.f_exc("of:StandardError","#{e}",__LINE__)
   exit
end

#
#   !THM:Simple I/O
#
$m.f_thm("simple I/O")
#   put to output
$sdtout=STDOUT
#   read from Key
#   puts ARGF.read
puts ARGV

#
#   === end
#
$m.f_end
__END__



